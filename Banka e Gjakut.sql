
CREATE DATABASE Banka_Gjakut
 
CREATE TABLE dbo.Banka_Gjakut(
	Banka_ID int IDENTITY(1,1) NOT NULL,
	Emer varchar(50) NULL,
	Adresa varchar(50) NULL,
	Nr_Cel int NULL,
 CONSTRAINT PK_Banka_Gjakut PRIMARY KEY CLUSTERED 
(
	Banka_ID ASC
))
CREATE TABLE dbo.Dhuruesit(
	Dhuruesi_ID int IDENTITY(1,1) NOT NULL,
	Emer varchar(255) NULL,
	Mbiemer varchar(15) NULL,
	Atesia varchar(15) NULL,
	Gjinia varchar(1) NULL,
	Datelindja datetime NULL,
	Nr_Kontakti varchar(50) NULL,
	Gjaku_ID int NULL,
 CONSTRAINT PK__Dhuruesi PRIMARY KEY CLUSTERED 
(
	Dhuruesi_ID ASC
))


CREATE TABLE dbo.Doktoret(
	Doktori_ID int IDENTITY(1,1) NOT NULL,
	Emer varchar(30) NULL,
	Mbiemer varchar(30) NULL,
	Nr_Kontakti varchar(50) NULL,
	Email varchar(30) NULL,
	Adresa varchar(30) NULL,
 CONSTRAINT PK__Doktoret PRIMARY KEY CLUSTERED 
(
	Doktori_ID ASC
))

CREATE TABLE dbo.Gjaku(
	Gjaku_ID int NOT NULL,
	Tipi_Gjakut varchar(2) NULL,
PRIMARY KEY CLUSTERED 
(
	Gjaku_ID ASC
))


CREATE TABLE dbo.Inventari(
	Inventari_ID int IDENTITY(1,1) NOT NULL,
	Data_Dhurimit date NULL,
	Expiration_Date date NULL,
	Sasia_ml int NULL,
	Sasia_Perdorur int NULL,
	Dhuruesi_ID int NULL,
	Pacienti_ID int NULL,
	Doktori_ID int NULL,
 CONSTRAINT PK__Inventari PRIMARY KEY CLUSTERED 
(
	Inventari_ID ASC
))

CREATE TABLE dbo.Menaxher(
	Menaxher_ID int NOT NULL,
	Emer varchar(15) NULL,
	Mbiemer varchar(15) NULL,
	Nr_Kontakti int NULL,
	Email varchar(30) NULL,
	Adresa varchar(15) NULL,
PRIMARY KEY CLUSTERED 
(
	Menaxher_ID ASC
))



CREATE TABLE dbo.Pacientet(
	Pacienti_ID int IDENTITY(1,1) NOT NULL,
	Emer varchar(15) NULL,
	Mbiemer varchar(15) NULL,
	Atesia varchar(15) NULL,
	Gjinia varchar(1) NULL,
	Datelindja datetime NULL,
	Nr_Kontakti varchar(50) NULL,
	Simptoma varchar(20) NULL,
	Gjaku_ID int NULL,
 CONSTRAINT PK__Pacientet PRIMARY KEY CLUSTERED 
(
	Pacienti_ID ASC
))

CREATE TABLE dbo.Recepsioni(
	Recepsionist_ID int IDENTITY(1,1) NOT NULL,
	Emer varchar(30) NULL,
	Mbiemer varchar(30) NULL,
	Nr_Kontakti varchar(50) NULL,
	Adresa varchar(30) NULL,
 CONSTRAINT PK__Recepsioi PRIMARY KEY CLUSTERED 
(
	Recepsionist_ID ASC
))


ALTER TABLE dbo.Dhuruesit  WITH CHECK ADD  CONSTRAINT FK_Dhuruesit_Gjaku FOREIGN KEY(Gjaku_ID)
REFERENCES dbo.Gjaku (Gjaku_ID)

ALTER TABLE dbo.Dhuruesit CHECK CONSTRAINT FK_Dhuruesit_Gjaku

ALTER TABLE dbo.Inventari  WITH CHECK ADD  CONSTRAINT FK_Inventari_Dhuruesit FOREIGN KEY(Dhuruesi_ID)
REFERENCES dbo.Dhuruesit (Dhuruesi_ID)

ALTER TABLE dbo.Inventari CHECK CONSTRAINT FK_Inventari_Dhuruesit

ALTER TABLE dbo.Inventari  WITH CHECK ADD  CONSTRAINT FK_Inventari_Doktoret FOREIGN KEY(Doktori_ID)
REFERENCES dbo.Doktoret (Doktori_ID)

ALTER TABLE dbo.Inventari CHECK CONSTRAINT FK_Inventari_Doktoret

ALTER TABLE dbo.Inventari  WITH CHECK ADD  CONSTRAINT FK_Inventari_Pacientet FOREIGN KEY(Pacienti_ID)
REFERENCES dbo.Pacientet (Pacienti_ID)

ALTER TABLE dbo.Inventari CHECK CONSTRAINT FK_Inventari_Pacientet

ALTER TABLE dbo.Pacientet  WITH CHECK ADD  CONSTRAINT FK_Pacientet_Gjaku FOREIGN KEY(Gjaku_ID)
REFERENCES dbo.Gjaku (Gjaku_ID)

ALTER TABLE dbo.Pacientet CHECK CONSTRAINT FK_Pacientet_Gjaku

