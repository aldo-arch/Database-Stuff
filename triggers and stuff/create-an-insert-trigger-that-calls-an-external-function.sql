-- an insert trigger that does a rollback
-- the trigger calls an externatl function

CREATE TRIGGER NewAuthor2 on Authors
AFTER INSERT AS
BEGIN
  Declare @auid as int
 select @auid=inserted.AuthorId from insterted 
  if dbo.librat(@auid)=0
 BEGIN
 RAISERROR('shkrimtari nuk gjendet ne tabelen botime',10,1)
 ROLLBACK
 END
END


-- try to insert an author
insert into Authors(AuthorId,Firstname,Lastname)
values (1003,'Artur','Kraja')
