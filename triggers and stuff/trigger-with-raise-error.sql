-- an insert trigger that does raise an error but does not rollback
-- it shoul be used by the code to rollback

CREATE TRIGGER NewAuthor4 on Authors
AFTER INSERT AS
BEGIN
 Declare @res as int
 Declare @auid as int
 if  exists
 (
 select AuthorId from inserted where AuthorId not in 
	(
	select Kodi from Botime
	)
 )
 BEGIN
 RAISERROR('shkrimtari/et nuk gjendet ne tabelen botime',10,1)
 END
END


insert into authors(authorid,firstname,lastname)
values (1010,'Artut','Hejl')

insert into authors(authorid,firstname,lastname)
values (1011,'Artur','Hejl2')

select * from authors
--does not rollback

--if we use a transaction

BEGIN TRY
BEGIN TRANSACTION
insert into authors(authorid,firstname,lastname)
values (1029,'Artut','Hejl')
--insert into authors(authorid,firstname,lastname)
--values (1024,'Artur','Hejl2')
PRINT @@ERROR
IF (@@error = 0 )COMMIT TRANSACTION

END TRY
BEGIN CATCH
PRINT 'an error occured'
ROLLBACK TRANSACTION
END CATCH

SELECT * FROM AUTHORS
SELECT * FROM BOTIME