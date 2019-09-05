select * from Authors
select * from Books
select * from OrderDetails
select * from Orders


--insert into Books(BookId,Title) values ('b1234','titullb')
--insert into orderdetails values ('asd',1,300)

-- a delete trigger that does does a cascade delete



CREATE TRIGGER DeletePorosi on Orders
AFTER DELETE AS
BEGIN
 Declare @orderid as int
 select @orderid=deleted.OrderNo from deleted
 delete from OrderDetails where OrderNo=@orderid
END




delete from orders
select * from orders
select * from orderdetails