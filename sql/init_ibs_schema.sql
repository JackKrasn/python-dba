def INIT_TDEF='T_USR' --Default tablespace
def INIT_TTMP='TEMP' --Temporary tablespace
def OWNER='IBS' --IBSO schema owner name

SET VERIFY OFF
SET ECHO ON
create user &&OWNER identified by &&OWNER;
alter  user &&OWNER default tablespace &&INIT_TDEF;
alter  user &&OWNER temporary tablespace &&INIT_TTMP;
alter  user &&OWNER default role none;

--sysgrant.sql

prompt Refreshing System Privileges and Grants

set echo on

prompt ROLES grants
grant RESOURCE to &&OWNER;
grant CONNECT to &&OWNER with admin option;

prompt PRIVILEGES grants
grant ALTER SESSION to &&OWNER with admin option;
grant ALTER SYSTEM to &&OWNER;
grant ALTER TABLESPACE to &&OWNER;
grant ANALYZE ANY to &&OWNER;
grant CHANGE NOTIFICATION to &&OWNER; 
grant CREATE ANY CONTEXT to &&OWNER;
grant CREATE ANY DIRECTORY to &&OWNER;
grant CREATE ANY JOB to &&OWNER;
grant CREATE ANY SYNONYM to &&OWNER;
grant CREATE ANY TRIGGER to &&OWNER;
grant CREATE DATABASE LINK to &&OWNER;
grant CREATE PROCEDURE to &&OWNER;
grant CREATE ROLE to &&OWNER;
grant CREATE SEQUENCE to &&OWNER;
grant CREATE SESSION to &&OWNER;
grant CREATE SNAPSHOT to &&OWNER;
grant CREATE TABLE to &&OWNER;
grant CREATE TRIGGER to &&OWNER;
grant CREATE TYPE to &&OWNER;
grant CREATE USER to &&OWNER;
grant CREATE VIEW to &&OWNER;
grant DROP ANY CONTEXT to &&OWNER;
grant DROP ANY DIRECTORY to &&OWNER;
grant DROP ANY SYNONYM to &&OWNER;
grant DROP ANY TRIGGER to &&OWNER;
grant MANAGE SCHEDULER to &&OWNER;
grant QUERY REWRITE to &&OWNER;
grant UNLIMITED TABLESPACE to &&OWNER;

prompt OBJECTS grants
grant EXECUTE on SYS.DBMS_ALERT to &&OWNER;
grant EXECUTE on SYS.DBMS_APPLICATION_INFO to &&OWNER;
grant EXECUTE on SYS.DBMS_AQ to &&OWNER;
grant EXECUTE on SYS.DBMS_AQADM to &&OWNER;
grant EXECUTE on SYS.DBMS_JOB to &&OWNER;
grant EXECUTE on SYS.DBMS_LOB to &&OWNER;
grant EXECUTE on SYS.DBMS_LOCK to &&OWNER;
grant EXECUTE on SYS.DBMS_OUTPUT to &&OWNER;
grant EXECUTE on SYS.DBMS_PIPE to &&OWNER;
grant EXECUTE on SYS.DBMS_RLS to &&OWNER;
grant EXECUTE on SYS.DBMS_SCHEDULER to &&OWNER;
grant EXECUTE on SYS.DBMS_SESSION to &&OWNER;
grant EXECUTE on SYS.DBMS_SHARED_POOL to &&OWNER;
grant EXECUTE on SYS.DBMS_SQL to &&OWNER;
grant EXECUTE on SYS.DBMS_STATS to &&OWNER;
grant EXECUTE on SYS.DBMS_SYSTEM to &&OWNER;
grant EXECUTE on SYS.DBMS_UTILITY to &&OWNER;
grant EXECUTE on SYS.DBMS_XMLGEN to &&OWNER;
grant EXECUTE on SYS.UTL_FILE to &&OWNER;
grant EXECUTE on SYS.UTL_RAW to &&OWNER;
grant EXECUTE on SYS.UTL_RECOMP to &&OWNER;
grant EXECUTE on SYS.DBMS_CRYPTO to &&OWNER;

grant SELECT  on SYS.DBA_CONTEXT to &&OWNER;
grant SELECT  on SYS.DBA_DATA_FILES to &&OWNER;
grant SELECT  on SYS.DBA_ROLE_PRIVS to &&OWNER;
grant SELECT  on SYS.DBA_OBJECTS  to &&OWNER with grant option;
grant SELECT  on SYS.DBA_JOBS to &&OWNER with grant option;
grant SELECT  on SYS.DBA_SCHEDULER_JOBS to &&OWNER with grant option;
grant SELECT  on SYS.DBA_SCHEDULER_JOB_CLASSES to &&OWNER with grant option;
grant SELECT  on SYS.DBA_SCHEDULER_JOB_RUN_DETAILS to &&OWNER with grant option;
grant SELECT  on SYS.DBA_TABLES  to &&OWNER with grant option;
grant SELECT  on SYS.DBA_INDEXES  to &&OWNER;
grant SELECT  on SYS.DBA_TRIGGERS  to &&OWNER;
grant SELECT  on SYS.DBA_CONSTRAINTS  to &&OWNER;
grant SELECT  on SYS.DBA_SOURCE  to &&OWNER;
grant SELECT  on SYS.DBA_ERRORS  to &&OWNER;
grant SELECT  on SYS.DBA_VIEWS  to &&OWNER;
grant SELECT  on SYS.DBA_TYPES  to &&OWNER;
grant SELECT  on SYS.DBA_COLL_TYPES  to &&OWNER;
grant SELECT  on SYS.DBA_TYPE_ATTRS  to &&OWNER;
grant SELECT  on SYS.DBA_TYPE_METHODS  to &&OWNER;
grant SELECT  on SYS.DBA_METHOD_RESULTS  to &&OWNER;
grant SELECT  on SYS.DBA_ALL_TABLES  to &&OWNER;
grant SELECT  on SYS.DBA_NESTED_TABLES  to &&OWNER;
grant SELECT  on SYS.DBA_TAB_COLUMNS  to &&OWNER;
grant SELECT  on SYS.DBA_UNUSED_COL_TABS  to &&OWNER;
grant SELECT  on SYS.DBA_IND_COLUMNS  to &&OWNER;
grant SELECT  on SYS.DBA_IND_EXPRESSIONS  to &&OWNER;
grant SELECT  on SYS.DBA_CONS_COLUMNS  to &&OWNER;
grant SELECT  on SYS.DBA_TRIGGER_COLS  to &&OWNER;
grant SELECT  on SYS.DBA_TAB_PARTITIONS  to &&OWNER with grant option;
grant SELECT  on SYS.DBA_TAB_SUBPARTITIONS  to &&OWNER with grant option;
grant SELECT  on SYS.DBA_IND_PARTITIONS  to &&OWNER with grant option;
grant SELECT  on SYS.DBA_IND_SUBPARTITIONS to &&OWNER with grant option;
grant SELECT  on SYS.DBA_PART_COL_STATISTICS to &&OWNER;
grant SELECT  on SYS.DBA_PART_INDEXES to &&OWNER with grant option;
grant SELECT  on SYS.DBA_USERS  to &&OWNER;
grant SELECT  on SYS.DBA_DEPENDENCIES  to &&OWNER;
grant SELECT  on SYS.DBA_TAB_PRIVS  to &&OWNER;
grant SELECT  on SYS.DBA_SYS_PRIVS  to &&OWNER;
grant SELECT  on SYS.DBA_TABLESPACES  to &&OWNER with grant option;
grant SELECT  on SYS.DBA_SYNONYMS  to &&OWNER;
grant SELECT  on SYS.DBA_SEQUENCES  to &&OWNER;
grant SELECT  on SYS.DBA_EXTENTS  to &&OWNER;
grant SELECT  on SYS.DBA_LOCK  to &&OWNER;
grant SELECT  on SYS.DBA_LOCK_INTERNAL to &&OWNER;
grant SELECT  on SYS.DBA_LIBRARIES  to &&OWNER;
grant SELECT  on SYS.DBA_OBJECT_TABLES to &&OWNER;
grant SELECT  on SYS.DBA_NESTED_TABLE_COLS to &&OWNER;
grant SELECT  on SYS.DBA_TAB_COLS to &&OWNER;
grant SELECT  on SYS.DBA_TABLESPACE_GROUPS to &&OWNER;

grant SELECT  on SYS.V_$SESSION to &&OWNER with grant option;
grant SELECT  on SYS.V_$LOCK  to &&OWNER with grant option;
grant SELECT  on SYS.V_$PROCESS  to &&OWNER with grant option;
grant SELECT  on SYS.V_$INSTANCE to &&OWNER with grant option;
grant SELECT  on SYS.V_$SESSTAT  to &&OWNER with grant option;
grant SELECT  on SYS.V_$STATNAME to &&OWNER with grant option;
grant SELECT  on SYS.GV_$SESSION  to &&OWNER with grant option;
grant SELECT  on SYS.GV_$LOCK     to &&OWNER with grant option;
grant SELECT  on SYS.GV_$PROCESS  to &&OWNER with grant option;
grant SELECT  on SYS.GV_$INSTANCE to &&OWNER with grant option;
grant SELECT  on SYS.GV_$SESSTAT  to &&OWNER with grant option;
grant SELECT  on SYS.GV_$STATNAME to &&OWNER with grant option;

grant SELECT  on SYS.V_$SQLAREA to &&OWNER;
grant SELECT  on SYS.V_$DB_PIPES to &&OWNER;
grant SELECT  on SYS.V_$SGASTAT  to &&OWNER;
grant SELECT  on SYS.V_$SYSSTAT  to &&OWNER;
grant SELECT  on SYS.V_$SQLTEXT  to &&OWNER;
grant SELECT  on SYS.GV_$SGASTAT  to &&OWNER;
grant SELECT  on SYS.GV_$SYSSTAT  to &&OWNER;
grant SELECT  on SYS.GV_$SQLTEXT  to &&OWNER;
grant SELECT  on SYS.GV_$SQLAREA  to &&OWNER;
grant SELECT  on SYS.GV_$DB_PIPES to &&OWNER;

grant SELECT  on SYS.V_$PARAMETER to &&OWNER with grant option;
grant SELECT  on SYS.GV_$PARAMETER to &&OWNER with grant option;
grant SELECT  on SYS.V_$SESSION_EVENT to &&OWNER with grant option;
grant SELECT  on SYS.GV_$SESSION_EVENT to &&OWNER with grant option;
grant SELECT  on SYS.V_$SESSION_WAIT to &&OWNER with grant option;
grant SELECT  on SYS.GV_$SESSION_WAIT to &&OWNER with grant option;
grant SELECT  on SYS.V_$SYSTEM_EVENT to &&OWNER with grant option;
grant SELECT  on SYS.GV_$SYSTEM_EVENT to &&OWNER with grant option;
grant SELECT  on SYS.V_$EVENT_NAME to &&OWNER with grant option;
grant SELECT  on SYS.GV_$EVENT_NAME to &&OWNER with grant option;
grant SELECT  on SYS.V_$SESS_IO to &&OWNER with grant option;
grant SELECT  on SYS.GV_$SESS_IO to &&OWNER with grant option;
grant SELECT  on SYS.V_$MYSTAT to &&OWNER with grant option;
grant SELECT  on SYS.GLOBAL_CONTEXT to &&OWNER with grant option;
grant SELECT  on SYS.V_$CONTEXT to &&OWNER with grant option;
grant SELECT  on SYS.GV_$CONTEXT to &&OWNER with grant option;
grant SELECT  on SYS.V_$GLOBALCONTEXT to &&OWNER with grant option;
grant SELECT  on SYS.GV_$GLOBALCONTEXT to &&OWNER with grant option;
grant SELECT  on SYS.V_$DB_OBJECT_CACHE to &&OWNER;
grant SELECT  on SYS.V_$DATABASE to &&OWNER;
grant SELECT  on SYS.V_$OSSTAT  to &&OWNER;
grant SELECT  on SYS.V_$LICENSE to &&OWNER;

prompt XDB grants
grant EXECUTE on XDB.DBMS_XMLDOM to &&OWNER;
grant EXECUTE on XDB.DBMS_XMLPARSER to &&OWNER;

prompt NO DEFAULT ROLES

alter user &&OWNER default role none;
revoke ALTER USER from &&OWNER;

prompt Patch for Oracle Bugs for role CONNECT

revoke create view from connect;
revoke create table from connect;
revoke create synonym from connect;
revoke create cluster from connect;
revoke create sequence from connect;
revoke create database link from connect;
revoke alter  session from connect;
grant  create session to connect;

prompt Drop owner roles without admin option

begin
  for i in (
    select p.granted_role as role
      from dba_role_privs p
     where p.grantee = upper('&&OWNER')
       and p.granted_role like upper('&&OWNER\_%') escape '\'
       and upper(p.admin_option) <> 'YES'
    union
    select r.role
      from dba_roles r
     where r.role like upper('&&OWNER\_%') escape '\'
       and not exists (select 1
              from dba_role_privs p
             where p.granted_role = r.role
               and p.grantee <> 'SYS')
  ) loop
    execute immediate('DROP ROLE ' || i.role);
  end loop;
end;
/

set echo off

--c_sys.sql

Prompt * Installation FIO/HASH/XML/RUNPROC - ORACLE server

var s1 varchar2(2000)
var s2 varchar2(2000)
var s4 varchar2(2000)
var s5 varchar2(2000)
begin
  for c in (select library_name, file_spec from dba_libraries
             where owner=upper('&&OWNER') and library_name in ('LIBFIO','LIBHASH','LIBXML','LIBRUNPROC')
  ) loop
      if c.library_name='LIBFIO' then
          :s1 := replace(c.file_spec,'/fio.s','/libfio.s');
      elsif c.library_name='LIBHASH' then
          :s2 := replace(c.file_spec,'/hash.s','/libhash.s');
      elsif c.library_name='LIBXML' then
          :s4 := c.file_spec;
      else
          :s5 := c.file_spec;
      end if;
  end loop;
  :s1 := nvl(:s1,'/u/tools/fio/libfio.so');
  :s2 := nvl(:s2,'/u/tools/hash/libhash.so');
  :s4 := nvl(:s4,'/u/tools/xml/libxml.so');
  :s5 := nvl(:s5,'/u/tools/runproc/librunproc.so');
end;
/

var db_version number

declare
  s1 varchar2(100);
  s2 varchar2(100);
begin
  dbms_utility.db_version(s1,s2);
  :db_version := substr(s1,1,instr(s1,'.')-1);
end;
/

column xxx new_value fiopath noprint
select :s1 xxx from dual;
column xxx new_value hashpath noprint
select :s2 xxx from dual;
column xxx new_value xmlpath noprint
select :s4 xxx from dual;
column xxx new_value runpath noprint
select :s5 xxx from dual;
SET SERVEROUTPUT ON SIZE 10000

Prompt * creating library libfio
create or replace library &&OWNER..libfio as '&&fiopath'
/

Prompt * creating library libhash
create or replace library &&OWNER..libhash as '&&hashpath'
/

Prompt * creating library libxml
create or replace library &&OWNER..libxml as '&&xmlpath'
/

Prompt * creating library librunproc
create or replace library &&OWNER..librunproc as '&&runpath'
/

Prompt * creating index sys.I_USER_ASTATUS_MAP1
create unique index sys.I_USER_ASTATUS_MAP1 on sys.USER_ASTATUS_MAP(STATUS#,STATUS)
/

Prompt * creating view dba_role_privs_simple
create or replace view sys.dba_role_privs_simple as
select u1.name grantee, u2.name GRANTED_ROLE
from sys.sysauth$ sa, sys.user$ u1, sys.user$ u2
where u1.user#=sa.grantee#
  and u2.user#=sa.privilege#
group by u1.name,u2.name
/
sho err view sys.dba_role_privs_simple

grant select on sys.dba_role_privs_simple to &&OWNER
/

Prompt * creating view dba_nested_tables_simple
create or replace view sys.dba_nested_tables_simple
(owner,table_name, table_type_owner, table_type_name, parent_table_name, parent_table_column, storage_spec, return_type, element_substitutable)
as
select u.name, o.name,
       nvl2(ct.synobj#, (select u.name from user$ u, obj$ o
            where o.owner#=u.user# and o.obj#=ct.synobj#), ut.name),
       nvl2(ct.synobj#, (select o.name from obj$ o
            where o.obj#=ct.synobj#), ot.name),
       op.name, c.name,
       lpad(decode(bitand(ct.flags, 64), 64, 'USER_SPECIFIED', 'DEFAULT'), 30),
       lpad(decode(bitand(ct.flags, 32), 32, 'LOCATOR', 'VALUE'), 20),
       lpad((case when bitand(ct.flags, 5120)=0 and bitand(t.properties, 8)= 8
       then 'Y' else 'N' end), 25)
from sys.ntab$ n, sys.obj$ o, sys.obj$ op, sys.obj$ ot, sys.col$ c,
  sys.coltype$ ct, sys.user$ u, sys.user$ ut, sys.type$ t, sys.collection$ cl
where o.owner# = u.user#
  and op.owner# = u.user#
  and n.obj# = op.obj#
  and n.ntab# = o.obj#
  and c.obj# = op.obj#
  and n.intcol# = c.intcol#
  and bitand(c.property,1)=0
  and op.obj# = ct.obj#
  and ct.toid = ot.oid$
  and ct.intcol#=n.intcol#
  and ot.owner# = ut.user#
  and ct.toid=cl.toid
  and cl.elem_toid=t.tvoid
  and bitand(ct.flags,4)=4
  and bitand(c.property,32768) != 32768
/
sho err view sys.dba_nested_tables_simple

grant select on sys.dba_nested_tables_simple to &&OWNER
/

column xxx new_value usrcols noprint
select decode(sign(:db_version-10),-1,'''ERROR'', 0',
       'decode(e.property, 0,''ERROR'', 1, ''WARNING'', ''UNDEFINED''), e.error#') xxx
  from dual;

prompt * creating view dba_errors_simple
create or replace view
sys.dba_errors_simple(owner,name,type,sequence,line,position,text,attribute,message_number) as
select u.name, o.name,
decode(o.type#, 4, 'VIEW', 7, 'PROCEDURE', 8, 'FUNCTION', 9, 'PACKAGE',
               11, 'PACKAGE BODY', 12, 'TRIGGER', 13, 'TYPE', 14, 'TYPE BODY',
               22, 'LIBRARY', 28, 'JAVA SOURCE', 29, 'JAVA CLASS',
               43, 'DIMENSION', 'UNDEFINED'),
  e.sequence#, e.line, e.position#, e.text,
  &&usrcols
from sys.obj$ o, sys.error$ e, sys.user$ u
where o.obj# = e.obj#
  and o.owner# = u.user#
  and o.type# in (4, 7, 8, 9, 11, 12, 13, 14, 22, 28, 29, 43)
/
sho err view sys.dba_errors_simple

grant select on sys.dba_errors_simple to &&OWNER
/

Prompt * creating view user_nested_tables_simple
create or replace view sys.user_nested_tables_simple
(table_name, table_type_owner, table_type_name, parent_table_name, parent_table_column, storage_spec, return_type, element_substitutable)
as
select o.name,
       nvl2(ct.synobj#, (select u.name from user$ u, obj$ o
            where o.owner#=u.user# and o.obj#=ct.synobj#), ut.name),
       nvl2(ct.synobj#, (select o.name from obj$ o
            where o.obj#=ct.synobj#), ot.name),
       op.name, c.name,
       lpad(decode(bitand(ct.flags, 64), 64, 'USER_SPECIFIED', 'DEFAULT'), 30),
       lpad(decode(bitand(ct.flags, 32), 32, 'LOCATOR', 'VALUE'), 20),
       lpad((case when bitand(ct.flags, 5120)=0 and bitand(t.properties, 8)= 8
       then 'Y' else 'N' end), 25)
from sys.ntab$ n, sys.obj$ o, sys.obj$ op, sys.obj$ ot,
  sys.col$ c, sys.coltype$ ct, sys.user$ ut, sys.type$ t, sys.collection$ cl
where o.owner# = userenv('SCHEMAID')
  and op.owner#= userenv('SCHEMAID')
  and n.obj# = op.obj#
  and n.ntab# = o.obj#
  and c.obj# = op.obj#
  and n.intcol# = c.intcol#
  and bitand(c.property,1)=0
  and op.obj# = ct.obj#
  and ct.toid = ot.oid$
  and ct.intcol#=n.intcol#
  and ot.owner# = ut.user#
  and ct.toid=cl.toid
  and cl.elem_toid=t.tvoid
  and bitand(ct.flags,4)=4
  and bitand(c.property,32768) != 32768
/

sho err view sys.user_nested_tables_simple

grant select on sys.user_nested_tables_simple to &&OWNER
/

prompt * creating view all_synonyms_simple
create or replace view
sys.all_synonyms_simple(owner,synonym_name,table_owner,table_name) as
select u.name, o.name, s.owner, s.name
  from sys.user$ u, sys.syn$ s, sys.obj$ o
 where o.obj# = s.obj#
   and o.type# = 5
   and o.owner# = u.user#
   and s.node is null
   and (
        o.owner# in (USERENV('SCHEMAID'), 1 /* PUBLIC */)  /* user's private, any public */
        or /* user has any privs on base object in local database */
        exists
        (select null
           from sys.objauth$ ba, sys.obj$ bo, sys.user$ bu
          where bu.name = s.owner
            and bo.name = s.name
            and bu.user# = bo.owner#
            and ba.obj# = bo.obj#
            and (   ba.grantee# in (select kzsrorol from x$kzsro)
                 or ba.grantor# = USERENV('SCHEMAID')
                )
        )
   )
/
sho err view sys.all_synonyms_simple

grant select on sys.all_synonyms_simple to &&OWNER
/

prompt * creating view user_errors_simple
create or replace view
sys.user_errors_simple(name,type,sequence,line,position,text) as
select o.name,
decode(o.type#, 4, 'VIEW', 7, 'PROCEDURE', 8, 'FUNCTION', 9, 'PACKAGE',
               11, 'PACKAGE BODY', 12, 'TRIGGER', 13, 'TYPE', 14, 'TYPE BODY',
               22, 'LIBRARY', 28, 'JAVA SOURCE', 29, 'JAVA CLASS',
               43, 'DIMENSION', 'UNDEFINED'),
  e.sequence#, e.line, e.position#, e.text
from sys.obj$ o, sys.error$ e
where o.obj# = e.obj#
  and o.type# in (4, 7, 8, 9, 11, 12, 13, 14, 22, 28, 29, 43)
  and o.owner# = userenv('SCHEMAID')
/
sho err view sys.user_errors_simple

grant select on sys.user_errors_simple to &&OWNER
/

prompt view dba_constraints_1
create or replace view dba_constraints_1(
  owner,
  constraint_name,
  constraint_type,
  table_name,
  search_condition,
  r_owner,
  r_constraint_name,
  delete_rule,
  status,
  deferrable,
  deferred,
  validated,
  generated,
  bad,
  rely,
  last_change,
  index_owner,
  index_name,
  invalid,
  view_related) as
select ou.name, oc.name,
       decode(c.type#, 1, 'C', 2, 'P', 3, 'U',
              4, 'R', 5, 'V', 6, 'O', 7,'C', '?'),
       o.name, c.condition, ru.name, rc.name,
       decode(c.type#, 4,
              decode(c.refact, 1, 'CASCADE', 2, 'SET NULL', 'NO ACTION'),
              NULL),
       decode(c.type#, 5, 'ENABLED',
              decode(c.enabled, NULL, 'DISABLED', 'ENABLED')),
       decode(bitand(c.defer, 1), 1, 'DEFERRABLE', 'NOT DEFERRABLE'),
       decode(bitand(c.defer, 2), 2, 'DEFERRED', 'IMMEDIATE'),
       decode(bitand(c.defer, 4), 4, 'VALIDATED', 'NOT VALIDATED'),
       decode(bitand(c.defer, 8), 8, 'GENERATED NAME', 'USER NAME'),
       decode(bitand(c.defer,16),16, 'BAD', null),
       decode(bitand(c.defer,32),32, 'RELY', null),
       c.mtime,
       decode(c.type#, 2, ui.name, 3, ui.name, null),
       decode(c.type#, 2, oi.name, 3, oi.name, null),
       decode(bitand(c.defer, 256), 256,
              decode(c.type#, 4,
                     case when (bitand(c.defer, 128) = 128
                                or o.status in (3, 5)
                                or ro.status in (3, 5)) then 'INVALID'
                          else null end,
                     case when (bitand(c.defer, 128) = 128
                                or o.status in (3, 5)) then 'INVALID'
                          else null end
                    ),
              null),
       decode(bitand(c.defer, 256), 256, 'DEPEND ON VIEW', null)
from sys.con$ oc, sys.con$ rc, sys.user$ ou, sys.user$ ru, sys.obj$ ro,
     sys.obj$ o, sys.cdef$ c, sys.obj$ oi, sys.user$ ui
where o.owner# = ou.user# /*oc.owner# = ou.user# */
  and oc.con# = c.con#
  and c.obj# = o.obj#
  and c.type# != 8        /* don't include hash expressions */
  and c.type# != 12       /* don't include log groups */
  and c.rcon# = rc.con#(+)
  and c.enabled = oi.obj#(+)
  and oi.owner# = ui.user#(+)
  and rc.owner# = ru.user#(+)
  and c.robj# = ro.obj#(+)
/

prompt view dba_cons_columns_1
create or replace view dba_cons_columns_1(
  owner,
  constraint_name,
  table_name,
  column_name,
  position) as
select u.name, c.name, o.name,
       decode(ac.name, null, col.name, ac.name), cc.pos#
from sys.user$ u, sys.con$ c, sys.col$ col, sys.ccol$ cc, sys.cdef$ cd,
     sys.obj$ o, sys.attrcol$ ac
where o.owner# = u.user# /*c.owner# = u.user# */
  and c.con# = cd.con#
  and cd.type# != 12       /* don't include log groups */
  and cd.con# = cc.con#
  and cc.obj# = col.obj#
  and cc.intcol# = col.intcol#
  and cc.obj# = o.obj#
  and col.obj# = ac.obj#(+)
  and col.intcol# = ac.intcol#(+)
/

grant select on dba_constraints_1 to &&OWNER
/
grant select on dba_cons_columns_1 to &&OWNER
/

prompt view dba_ind_columns_1
create or replace view dba_ind_columns_1 (
  index_owner,
  index_name,
  table_owner,
  table_name,
  column_name,
  column_position,
  column_length,
  char_length,
  descend
) as
select io.name, idx.name, bo.name, base.name, c.name,
       /*decode(bitand(c.property, 1024), 1024,
              (select decode(bitand(tc.property, 1), 1, ac.name, tc.name)
              from sys.col$ tc, attrcol$ ac
              where tc.intcol# = c.intcol#-1
                and tc.obj# = c.obj#
                and tc.obj# = ac.obj#(+)
                and tc.intcol# = ac.intcol#(+)),
              decode(ac.name, null, c.name, ac.name)),*/
       ic.pos#, c.length, c.spare3,
       decode(bitand(c.property, 131072), 131072, 'DESC', 'ASC')
from sys.col$ c, sys.obj$ idx, sys.obj$ base, sys.icol$ ic,
     sys.user$ io, sys.user$ bo, sys.ind$ i--, sys.attrcol$ ac
where ic.bo# = c.obj#
  --and decode(bitand(i.property,1024),0,ic.intcol#,ic.spare2) = c.intcol#
  and ic.intcol# = c.intcol#
  and ic.bo# = base.obj#
  and io.user# = idx.owner#
  and bo.user# = base.owner#
  and ic.obj# = idx.obj#
  and idx.obj# = i.obj#
  and i.type# in (1, 2, 3, 4, 6, 7, 9)
  --and c.obj# = ac.obj#(+)
  --and c.intcol# = ac.intcol#(+)
  and bitand(i.property,1024)=0
/

grant select on dba_ind_columns_1 to &&OWNER
/

exit

