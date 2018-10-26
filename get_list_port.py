# -*- coding: utf-8 -*-
import oracledb
import sys

listener = sys.argv[1]
sid = sys.argv[2]
oracledb.orautils.oraenv(sid)
lis = oracledb.db.Listener(listener)
print(lis.get_port_number())
