--Export/Import i nje tablespace (data + metadata using transport mode)
-------------------------------------------------------------------------

--1.log ne sqldeveloper si sysdba user per te krijuar user PROJEKT qe do te beje exp/imp
create user projekt IDENTIFIED by projekt;

--2. i japim privilegjet userit te krijuar
grant sysdba to projekt;
grant connect to projekt;
grant all privileges to projekt;

--3. Krijojme nje direktoti ku do te gjenden filet qe do eksportohen

SQL> CREATE DIRECTORY testdir AS 'D:\app\Aldo\datapump';

--4.i japim read write userit ne direktorine e krijuar


SQL>GRANT READ ON DIRECTORY testdir TO projekt;
SQL>GRANT WRITE ON DIRECTORY testdir TO projekt;


--5. Krijojme direktorine ne nivel serveri

--ne linux: mkdir datapump


6. krijojme tabelen dhe e popullojme ate
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

--7. krijojme nje tablespace te ri me datafile perkates

create TABLESPACE projekt
datafile 'D:\app\Aldo\oradata\ambrasejati\projekt.dbf'
size 10M
autoextend on
next 10M
maxsize unlimited
nologging;


--8. krijojme 1 tabele ne tablespace e ri 

create table banke_gjaku_bkp TABLESPACE projekt as select * from banke_gjaku;

--9. kalojme tablespace ne read only mode 
alter TABLESPACE projekt read only;

--10. bejme export vetem te te dhenave te tabeles

--expdp projekt/projekt TRANSPORT_TABLESPACES=projekt directory=testdir dumpfile=tt.dmp logfile=tt.log

--C:\Users\Aldo>expdp projekt/projekt TRANSPORT_TABLESPACES=projekt directory=tes
--tdir dumpfile=tt.dmp logfile=tt.log

--Export: Release 11.2.0.1.0 - Production on Sat Jun 3 19:01:48 2017

--Copyright (c) 1982, 2009, Oracle and/or its affiliates.  All rights reserved.

--Connected to: Oracle Database 11g Enterprise Edition Release 11.2.0.1.0 - 64bit
--Production
--With the Partitioning, OLAP, Data Mining and Real Application Testing options
--Starting "PROJEKT"."SYS_EXPORT_TRANSPORTABLE_01":  projekt/******** TRANSPORT_TA
--BLESPACES=projekt directory=testdir dumpfile=tt.dmp logfile=tt.log
--Processing object type TRANSPORTABLE_EXPORT/PLUGTS_BLK
--Processing object type TRANSPORTABLE_EXPORT/TABLE
--Processing object type TRANSPORTABLE_EXPORT/POST_INSTANCE/PLUGTS_BLK
--Master table "PROJEKT"."SYS_EXPORT_TRANSPORTABLE_01" successfully loaded/unloaded
--******************************************************************************
--Dump file set for PROJEKT.SYS_EXPORT_TRANSPORTABLE_01 is:
--  D:\APP\Aldo\DATAPUMP\TT.DMP
--******************************************************************************
--Datafiles required for transportable tablespace PROJEKT:
  --D:\APP\Aldo\ORADATA\AMBRASEJATI\PROJEKT.DBF
--Job "PROJEKT"."SYS_EXPORT_TRANSPORTABLE_01" successfully completed at 19:02:48
----------------------------------------

--10. bejme drop tablespace
sqlplus / as sysdba
drop TABLESPACE projekt including contents and datafiles;

--11. bejme import

--impdp projekt/projekt directory=testdir TRANSPORT_DATAFILES="D:\APP\Aldo\ORADATA\AMBRASEJATI\PROJEKT.DBF"  dumpfile=tt.dmp logfile=imptt_test.log


--12. kontrollojme ns eshte bere import
select * from banke_gjaku_bkp;
ose
sqlplus / as sysdba
select * from dba_tablespaces;


