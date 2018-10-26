# -*- coding: utf-8 -*-
import paramiko
import os
import logging
from oracledb import dblogger

logger = logging.getLogger('oracledb.remote')
log_adapter = dblogger.DBLoggerAdapter(logger)


class SSH(paramiko.SSHClient):
    def __init__(self, hostname, username=None, password=None):
        super(SSH, self).__init__()
        self.set_missing_host_key_policy(paramiko.AutoAddPolicy)
        self.connect(hostname=hostname, username=username, password=password)
        log_adapter.info('connected to host %s', hostname)

    def run(self, command):
        stdin, stdout, stderr = self.exec_command(command, get_pty=True)
        for line in iter(stdout.readline, ""):
            #log_adapter.info(line.rstrip())
            last_line = line.rstrip()
            log_adapter.info(line.rstrip())

        return last_line

    def put_all(self, localpath, remotepath):
        """
        Загрузить всю директорию
        :param localpath: исходное расположение директории
        :param remotepath: удаленное расположение родительской директории. В данной директории будет создана
        директория, как в localpath
        """
        log_adapter.info('copy directory from %s to %s', localpath, remotepath )
        self.ftp = self.open_sftp()
        remotepath = remotepath.replace('\\', '/') # при копировании из Windows на linux, приходится править пути
        #  recursively upload a full directory
        os.chdir(os.path.split(localpath)[0])
        parent = os.path.split(localpath)[1]
        for walker in os.walk(parent):
            try:
                self.ftp.mkdir(os.path.join(remotepath, walker[0]).replace('\\', '/'))
            except:
                pass
            for file in walker[2]:
                self.ftp.put(os.path.join(walker[0], file).replace('\\', '/'),
                         os.path.join(remotepath, walker[0], file).replace('\\', '/'))

