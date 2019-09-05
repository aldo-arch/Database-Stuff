-- first lets add an active smallint column to the Books table 
-- this column will  allow nulls and defaults to 1 = active 0 =not active
create trigger fshiliber on books
INSTEAD OF DELETE
AS
BEGIN
update books set active = 0 where BookId in
(select bookid from deleted)

END
select * from books

update books set active=1
delete from books 

select * from books
