CREATE TRIGGER NewBook on Books
AFTER INSERT AS
BEGIN
INSERT INTO BookAuthors(BookID,AuthId) 
select inserted.BookId, 1001 from inserted

END


