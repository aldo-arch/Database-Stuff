--triger qe kontrollon nese autori ka botime dhe nuk lejon fshirjen
--transaksioni kthen mbarpsht te gjithe inserted ndonese autori me kodin 1003 nuk ka 
-- botime
CREATE TRIGGER DeleteAuthor on Authors
AFTER DELETE AS
BEGIN
 if exists(
		 select AuthorId from deleted where AuthorId in 
			(
			select kodi from botime
			)
			)
		begin
		raiserror('nuk mund te fshihet autori pasi ka botime',1,10)
		
	if (@@TRANCOUNT>0)
	begin
	PRINT 'transaksioni anullohet'
	ROLLBACK
	
	end
	end
 
END
select * from authors
delete from authors 
select * from botime
insert into authors(AuthorId,Firstname,Lastname) values (1003,'artur','kraja')