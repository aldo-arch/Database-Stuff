select * from Authors
select * from Books
select * from OrderDetails
select * from Orders


--insert into Books(BookId,Title) values ('b1234','titullb')
--insert into orderdetails values ('asd',1,300)

-- a delete trigger that does does a cascade delete



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
 
END




delete from orders
select * from orders
select * from orderdetails