#!/usr/bin/env python
# -*- coding: utf-8 -*-
from oracledb import db, dblogger, orautils
import logging
import argparse
import os
import sys
import re
import config
import utils
import atexit
from ldapoid import ld, oidexceptions


def my_cleanup():
    if client:
        log_adapter.debug('rm /tmp/get_list_port.py')
        client.run('[ -f /tmp/get_list_port.py ] && rm -f /tmp/get_list_port.py')
        client.close()
    if db1.conn:
        log_adapter.debug('close connection with db')
        db1.conn.close()


logger = logging.getLogger('oracledb.copy_pdb')
log_adapter = dblogger.DBLoggerAdapter(logger)

if os.path.isfile(config.PATH_YOU_CONFIG) and os.access(config.PATH_YOU_CONFIG, os.R_OK):
    settings = utils.load_yml_config(config.PATH_YOU_CONFIG)
else:
    log_adapter.error('The config file %s is not exists or not readable', config.PATH_YOU_CONFIG)
    sys.exit(1)

if type(settings) is not dict:
    log_adapter.error('%s', settings)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='create pluggable database from another pdb or seed')

    parser.add_argument('src_tns',
                        #nargs='+',
                        help='source tns alias')

    parser.add_argument('dst_tns',
                        #nargs='+',
                        help='destination tns alias')

    parser.add_argument('--snap',
                        default=False,
                        action='store_true',
                        help='create pluggable database as snapshot copy')

    parser.add_argument('--passw',
                        help='sys password for source database')

    args = parser.parse_args()
    src_tns = args.src_tns
    dst_tns = args.dst_tns
    if args.passw is None:
        passw = settings['PASS_SYS']
    else:
        passw = args.passw
    db1 = db.Db(src_tns, wallet=False, passw=passw)
    db1. connection()
    if db1.info_con['CON_TYPE'] != 'NONCDB':
        con_name = db1.info_con['CON_NAME']
        log_adapter.debug(db1.info_con)
        db1.set_con()
        # Получить максимальный номер контейнера
        pdb_name = db1.cur().execute('select pdb_name from cdb_pdbs where creation_scn=(select max(creation_scn) from cdb_pdbs)').out_list()[0]
        log_adapter.debug(pdb_name)
        max_num = int(re.match('.*S([0-9]+)$', pdb_name['PDB_NAME']).groups(1)[0])
        dst_pdb_name = con_name + 'S' + str(max_num+1)
        log_adapter.debug('New pdb name:%s', dst_pdb_name)
        db1.copy_pdb(con_name, dst_pdb_name, snap=args.snap)
        db1.pdb_open(con_name=dst_pdb_name)
        db1.cur().ddl_execute('alter pluggable database {} save state'.format(dst_pdb_name))

        # create directory for fio
        fio_home_dir = settings['PLATFORM']['FIO_HOME_DIR'] + '/' + dst_pdb_name.lower()
        owner = settings['PLATFORM']['OWNER']
        import remote
        client = remote.SSH(hostname=db1.info_instance['HOST_NAME'], username='oracle')
        atexit.register(my_cleanup)
        log_adapter.info('create fio directory %s',fio_home_dir)
        client.run('mkdir -p {}/ibs'.format(fio_home_dir))

        # change fio
        db1.set_con(con_name=dst_pdb_name)
        db1.cft_chfio(fio_home_dir)

        # Определение на каком порту слушает листенер. Это необходимо для регистрации БД в ldap
        client.put_file(os.path.join(config.BASE_DIR, 'get_list_port.py'), '/tmp/get_list_port.py')
        lis_port = client.run(". {}/bin/activate; python /tmp/get_list_port.py {} {}".format(settings['VENV'],
                                                                                             db1.param['local_listener'],
                                                                                             db1.info_db['DB_UNIQUE_NAME']))

        if not re.match("^[0-9]+$", lis_port):
            log_adapter.error('listener port number incorrect')
            sys.exit(1)

        # register in ldap
        oid_conn = ld.connection(settings['OID']['SERVER'],
                                 settings['OID']['DN'],
                                 settings['OID']['PASS'])
        try:
            ld.create_dbalias(oid_conn,
                              dn_domain=settings['OID']['DN_DOMAIN'],
                              dbalias=dst_tns,
                              host=db1.info_instance['HOST_NAME'].split('.')[0] + '.ftc.ru',
                              lisport=lis_port,
                              sn=dst_pdb_name.lower())
            log_adapter.info('add tns alias %s successfully', dst_tns)
        except oidexceptions.TnsAlreadyExists, e:
            log_adapter.error('e')
    else:
        log_adapter.error('Src database %s is not multitenant database', src_tns)
        sys.exit(1)




