--create eventlog table
CREATE TABLE [dbo].[eventlog](
	[kodi] [int] IDENTITY(1,1) NOT NULL,
	[event] [varchar](250) NOT NULL,
	[eventtime] [datetime] NULL,
 CONSTRAINT [PK_eventlog] PRIMARY KEY CLUSTERED 
(
	[kodi] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


-- lets first create a histrory table for authors
CREATE TABLE [dbo].[AuthorsHistory](
	[AuthorId] [int] NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[Lastname] [varchar](50) NOT NULL,
	[YearBorn] [int] NULL,
	[YearDied] [int] NULL,
	[Note] [varchar](250) NULL,
	lastchange datetime NULL,
	changedby varchar(30)
 CONSTRAINT [PK_Authors2] PRIMARY KEY CLUSTERED 
(
	[AuthorId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]



--lets create the trigger that will insert the old data at the history table

create trigger NdryshoAuthor on Authors
after update 
as
BEGIN
--log the event
insert into eventlog(event)
select 'authors are updated: old data-kodi='+convert(varchar,AuthorID,100)
+' FN='+Firstname+' LN='+LastName
from deleted

--log the event
insert into eventlog(event)
select 'new value for updated authors : kodi='+convert(varchar,AuthorID,100)
+' FN='+Firstname+' LN='+LastName 
from inserted

--save the history
insert into authorshistory(AuthorId,FirstName,Lastname,changedby)
select AuthorId,FirstName,Lastname,CURRENT_USER from deleted

END



--test the update trigge
update authors set Firstname='bojana' where AuthorId=1001
--see the results
select * from eventlog
select * from authorshistory
