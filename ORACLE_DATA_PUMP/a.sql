--Import i 1 tabele
--cmd
--sqlplus/sysdate 
--sqlplus sys/oracle as sysdba

--1.log ne sqldeveloper si sysdba user per te krijuar user PROJEKT qe do te beje exp/imp
create user projekt IDENTIFIED by projekt;

--2. i japim privilegjet userit te krijuar
grant sysdba to projekt;
grant connect to projekt;
grant all privileges to projekt;

--3. Krijojme nje direktori ku do te gjenden filet qe do eksportohen

--SQL> CREATE DIRECTORY testdir AS 'C:\Users\User\Downloads\datapump';

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

commit

--krijojme nje backup te tabeles
create table banke_gjaku_bkp_1223 as select * from banke_gjaku;


--7. bejme export

--expdp projekt/projekt directory=TESTDIR tables=projekt.banke_gjaku

--8. kontrolloni ns eshte krijuar .dmp file dhe .log file te direktori qe krijuam (psh D:\app\Aldo\datapump)

--9. log ne sql dhe bej drop tabelen
Drop table banke_gjaku purge;

--10. sigurohemi qe tabela eshte bere drop

select * from banke_gjaku;

--11. importojme te dhenat ne db serish
--impdp projekt/projekt directory=TESTDIR tables=projekt.banke_gjaku

--12. kontrollojme qe tabela u be import
select * from banke_gjaku;

