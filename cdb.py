#!/usr/bin/env python
# -*- coding: utf-8 -*-
from oracledb import db, dblogger, orautils
import logging
import argparse
import os
import utils
import config

# BASE_DIR = os.path.dirname(os.path.realpath(__file__))
# SQL_DIR = os.path.join(BASE_DIR, 'sql')
# TPL_DIR = os.path.join(BASE_DIR, 'templates')

logger = logging.getLogger('oracledb.cdb')
log_adapter = dblogger.DBLoggerAdapter(logger)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='create oracle database')
    parser.add_argument('-s', '--sid', metavar='ORACLE_SID',
                        required=True,
                        help='oracle sid')

    parser.add_argument('-v', '--ver', metavar='ORACLE_VERSION',
                        required=False,
                        default=12102,
                        choices=['12102', '12201'],
                        help='oracle version. Available value: 12102,12201. Default: 12102 ')

    parser.add_argument('-o', '--oradata', metavar='ORADATA',
                        required=False,
                        default='/db1/oradata',
                        help='directory for database. Parameter db_create_file_dest. default value=/db1/oradata')

    parser.add_argument('-n', '--nls_characterset', metavar='CHARACTERSET',
                        choices=['CL8ISO8859P5', 'CL8MSWIN1251'],
                        default='CL8ISO8859P5',
                        required=False,
                        help='oracle database characterset. Available value: CL8MSWIN1251, CL8ISO8859P5. Default: CL8ISO8859P5')

    parser.add_argument('--host', metavar='HOSTNAME',
                        default='localhost',
                        help='hostname where database will be created')

    parser.add_argument('-c', '--cdb',
                        default=False,
                        action='store_true',
                        help='create cdb or non-cdb. Default: false')

    parser.add_argument('-a', '--archive_mode',
                        default=False,
                        action='store_true',
                        help='Database in archive mode or not. Default: false')

    parser.add_argument('-l', '--logging',
                        default='INFO',
                        choices=['CRITICAL', 'ERROR', 'WARNING', 'INFO', 'DEBUG', 'NOTSET'],
                        help='logging levels. Default: INFO')

    parser.add_argument('-t', '--type',
                        default='cft',
                        choices=['other','cft'],
                        help='type of database. Available value: other, cft. If selected cft,  then additional tablespaces'
                             ' will be created. Default: cft')


    args = parser.parse_args()

    dblogger.root_logger.setLevel(getattr(logging, args.logging))
    # logger.setLevel(getattr(logging, args.logging))
    # Для передачи аргумента cdb.
    if args.cdb:
        cdb = ' --cdb'
    else:
        cdb = ''

    if args.archive_mode:
        archive_mode = ' --archive_mode'
    else:
        archive_mode = ''
    # если host=localhost , значит host не задавался и следовательно бд необходимо создать на локальном сервере,
    # в противном случае предполагается, что хост расположен удаленно и требуется скопировать сначала скрипты.
    if args.host != 'localhost':
        import remote
        client = remote.SSH(hostname=args.host, username='oracle')
        # копирование всех скриптов
        client.put_all(config.BASE_DIR, '/tmp')
        DIRNAME = os.path.split(config.BASE_DIR)[1]
        client.run('. /u/dba/venv/python_dba/bin/activate; python /tmp/'
                 + DIRNAME + '/cdb.py -s ' + args.sid + ' -v ' + str(args.ver)
                 + ' -o ' + args.oradata + ' -n ' + args.nls_characterset + cdb + archive_mode + ' -l ' + args.logging)
        client.close()
    else:
        # к абсолюдному пути еще добавляется sid. Путь согласно стандартизации
        # https://bftman.ftc.ru:8443/pages/viewpage.action?pageId=30867462
        oradata = os.path.join(args.oradata, args.sid)
        oracle_version = 'o' + str(args.ver)

        orautils.oraenv(oracle_version)
        db1 = db.LocalDb(oracle_version)
        db1.create_from_tpl(args.sid, oradata, nls=args.nls_characterset, archive_mode=args.archive_mode, cdb=args.cdb)
        if args.type == 'cft':
            log_adapter.info('create tablespaces for cft platform')
            for sql in utils.get_sql(config.SQL_DIR, 'create_tablespaces.sql'):
                db1.cur().ddl_execute(sql)

            log_adapter.info('create user ibs, add grants to ibs')
            cmd = '{}/bin/sqlplus -S / as sysdba @{}/init_ibs_schema.sql'.format(db1.oracle_home, config.SQL_DIR)
            db1._run_cmd(cmd, stdoutDisable=True)

            # change system options
            db1.cur().ddl_execute('alter system set filesystemio_options=setall scope=spfile')
            db1.shut_immediate()
            db1.open()

