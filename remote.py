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
        last_line = None
        stdin, stdout, stderr = self.exec_command(command, get_pty=True)
        for line in iter(stdout.readline, ""):
            #log_adapter.info(line.rstrip())
            last_line = line.rstrip()
            # log_adapter.info(line.rstrip())

        if last_line:
            return last_line

    def put_all(self, localpath, remotepath):
        """
        Загрузить всю директорию
        :param localpath: исходное расположение директории
        :param remotepath: удаленное расположение родительской директории. В данной директории будет создана
        директория, как в localpath
        """
        # log_adapter.info('copy directory from %s to %s', localpath, remotepath)
        sftp = self.open_sftp()
        remotepath = remotepath.replace('\\', '/') # при копировании из Windows на linux, приходится править пути
        #  recursively upload a full directory
        os.chdir(os.path.split(localpath)[0])
        parent = os.path.split(localpath)[1]
        for walker in os.walk(parent):
            try:
                sftp.mkdir(os.path.join(remotepath, walker[0]).replace('\\', '/'))
            except:
                pass
            for file in walker[2]:
                sftp.put(os.path.join(walker[0], file).replace('\\', '/'),
                        os.path.join(remotepath, walker[0], file).replace('\\', '/'))
        sftp.close()

    def put_file(self, localfile, remotefile):
        """
        Скопировать один файл
        :param localfile: абсолюдный путь к файлу
        :param remotepath: путь на удаленном хосте
        :return:
        """
        log_adapter.info('copy file %s to %s', localfile, remotefile)
        sftp = self.open_sftp()
        sftp.put(localfile, remotefile)
        sftp.close()
