--Import i SCHEMA PROJEKT


--1.log ne sqldeveloper si sysdba user per te krijuar user PROJEKT qe do te beje exp/imp
create user projekt IDENTIFIED by projekt;

--2. i japim privilegjet userit te krijuar
grant sysdba to projekt;
grant connect to projekt;
grant all privileges to projekt;

--3. Krijojme nje direktoti ku do te gjenden filet qe do eksportohen

SQL> CREATE DIRECTORY testdir AS 'D:\app\Aldo\datapump'; --vendos pathin sipas laptop

--4.i japim read write userit ne direktorine e krijuar

SQL>GRANT READ ON DIRECTORY testdir TO projekt;
SQL>GRANT WRITE ON DIRECTORY testdir TO projekt;

--5. Krijojme direktorine ne nivel serveri

--ne linux: mkdir datapump

--6. krijojme tabelen dhe e popullojme ate
CREATE TABLE Banke_Gjaku (
  Banka_ID number(10) NOT NULL,
  Emer varchar(50) NOT NULL,
  Adresa varchar(50) NOT NULL,
  "Nr-cel" varchar(16) NOT NULL
);


INSERT INTO Banke_Gjaku (Banka_ID, Emer, Adresa, "Nr-cel") VALUES
(0, 'Banka_1', 'Rruga e Dibres', '042356136');
INSERT INTO Banke_Gjaku (Banka_ID, Emer, Adresa, "Nr-cel") VALUES
(1, 'Banka_2', 'Materniteti i ri', '042668129');
INSERT INTO Banke_Gjaku (Banka_ID, Emer, Adresa, "Nr-cel") VALUES
(2, 'Banka_3', 'Rruga e Elbasanit', '042359123');

INSERT INTO Banke_Gjaku (Banka_ID, Emer, Adresa, "Nr-cel") VALUES
(3, 'Banka_4', 'Prane shkolles Ali Demi', '042691822');

INSERT INTO Banke_Gjaku (Banka_ID, Emer, Adresa, "Nr-cel") VALUES
(4, 'Banka_5', 'Prane shkolles 1 maji', '042762353');

INSERT INTO Banke_Gjaku (Banka_ID, Emer, Adresa, "Nr-cel") VALUES
(5, 'Banka_6', '21 dhjetori', '042122560');

INSERT INTO Banke_Gjaku (Banka_ID, Emer, Adresa, "Nr-cel") VALUES
(6, 'Banka_7', 'Prane parkut te lojrave 7 xhuxhat', '042909137');

INSERT INTO Banke_Gjaku (Banka_ID, Emer, Adresa, "Nr-cel") VALUES
(7, 'Banka_8', 'Prane fakultetit te gjuheve te huaja', '042881942');

INSERT INTO Banke_Gjaku (Banka_ID, Emer, Adresa, "Nr-cel") VALUES
(8, 'Banka_9', 'Prane stadiumit Qemal Stafa', '042891252');
INSERT INTO Banke_Gjaku (Banka_ID, Emer, Adresa, "Nr-cel") VALUES
(9, 'Banka_10', 'Prane lulishtes nje maji', '042883381');

commit;

--7. bejme export te skemes

expdp projekt/projekt SCHEMAS=projekt DUMPFILE=skema.dmp LOGFILE=skema.log

--8. kontrolloni ns eshte krijuar .dmp file dhe .log file te direktori qe krijuam (psh D:\app\Aldo\datapump)

--C:\Users\Aldo>expdp projekt/projekt SCHEMAS=projekt DUMPFILE=skema.dmp LOGFILE=
--skema.log
--Export: Release 11.2.0.1.0 - Production on Sat Jun 3 18:41:28 2017

--Copyright (c) 1982, 2009, Oracle and/or its affiliates.  All rights reserved.
--------------------------log--------------------------------------------------
--Connected to: Oracle Database 11g Enterprise Edition Release 11.2.0.1.0 - 64bit
--Production
--With the Partitioning, OLAP, Data Mining and Real Application Testing options
--Starting "PROJEKT"."SYS_EXPORT_SCHEMA_01":  projekt/******** SCHEMAS=projekt DUM
--PFILE=skema.dmp LOGFILE=skema.log
--Estimate in progress using BLOCKS method...
--Processing object type SCHEMA_EXPORT/TABLE/TABLE_DATA
--Total estimation using BLOCKS method: 256 KB
--Processing object type SCHEMA_EXPORT/USER
--Processing object type SCHEMA_EXPORT/SYSTEM_GRANT
--Processing object type SCHEMA_EXPORT/ROLE_GRANT
--Processing object type SCHEMA_EXPORT/DEFAULT_ROLE
--Processing object type SCHEMA_EXPORT/PRE_SCHEMA/PROCACT_SCHEMA
--Processing object type SCHEMA_EXPORT/TABLE/TABLE
--Processing object type SCHEMA_EXPORT/TABLE/INDEX/INDEX
--Processing object type SCHEMA_EXPORT/TABLE/CONSTRAINT/CONSTRAINT
--Processing object type SCHEMA_EXPORT/TABLE/INDEX/STATISTICS/INDEX_STATISTICS
--Processing object type SCHEMA_EXPORT/TABLE/COMMENT
--. . exported "PROJEKT"."BANKE_GJAKU"                     6.734 KB      10 rows
--. . exported "PROJEKT"."BANKE_GJAKU_BKP"                 6.734 KB      10 rows
--. . exported "PROJEKT"."BANKE_GJAKU_BKP030617"           6.742 KB      10 rows
--. . exported "PROJEKT"."BANKE_GJAKU_BKP2"                6.742 KB      10 rows
--Master table "PROJEKT"."SYS_EXPORT_SCHEMA_01" successfully loaded/unloaded
--******************************************************************************
--Dump file set for PROJEKT.SYS_EXPORT_SCHEMA_01 is:
  --D:\APP\Aldo\ADMIN\AMBRASEJATI\DPDUMP\SKEMA.DMP
--Job "PROJEKT"."SYS_EXPORT_SCHEMA_01" successfully completed at 18:42:49


--C:\Users\Aldo>

------------------------------------------------------------

--9. log ne sql dhe bej drop skemen
drop user projekt CASCADE;

--10. sigurohemi qe user eshte bere drop
sqlplus / as sysdba
select * from dba_users;

--11. importojme te dhenat ne db serish
--impdp projekt/projekt  directory=testdir DUMPFILE=skema.dmp LOGFILE=skema.log

--12. kontrollojme qe skema u be import
select * from dba_users;


