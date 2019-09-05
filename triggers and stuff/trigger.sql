--triggers can coexist in the same table for the same action
create trigger NewAuthor3 on Authors
AFTER INSERT 
AS
BEGIN
INSERT INTO BOTIME(KODI,Emri,Mbiemri,Librat) 
select AuthorId,Firstname,Lastname,NULL from inserted

END
SELECT * FROM BOTIME

insert into authors(AuthorId,FirstName,Lastname)
values(1005,'Armend','Hoxha')
select * from botime
select * from authors