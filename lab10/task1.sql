use UNIVER

exec sp_helpindex 'AUDITORIUM'
exec sp_helpindex 'AUDITORIUM_TYPE'
exec sp_helpindex 'FACULTY'
exec sp_helpindex 'GROUPS'
exec sp_helpindex 'PROFESSION'
exec sp_helpindex 'PULPIT'
exec sp_helpindex 'STUDENT'
exec sp_helpindex 'SUBJECT'
exec sp_helpindex 'TEACHER'

create table #EX001
(
	TIND int,
	TFIELD varchar(100),
	TNEWIND int
);

set nocount on;
declare @i int = 0;
while @i<1000
begin
	insert #EX001(TIND,TFIELD,TNEWIND)
	values(floor(30000*rand()),replicate('строка',10),floor(3000*rand()));
	set @i = @i +1;
end;

checkpoint;
DBCC DROPCLEANBUFFERS;

select * from #EX001 WHERE TIND between 1500 and 2500 order by TIND 
create clustered index #EX001_CL on #EX001(TIND asc)

drop index #EX001_CL on #EX001
drop table #EX001

----task 2-----
 create table #EX2
 (
	TIND int,
	TFIELD varchar(100),
	TNEWIND int
 )

 set nocount on
 declare @i2 int = 0
 while @i2<10000
 begin
	insert #EX2(TIND,TFIELD,TNEWIND) values (floor(30000*rand()),replicate('строк',10),floor(3000*rand()));
	set @i2 = @i2+1;
 end;

 select count(*)[Количество_строк] from #EX2
 select * from #EX2

 create index #EX2_NONCLU on #EX2(TIND,TNEWIND)

 select * from #EX2 where TIND>1500 and TNEWIND<400
 select * from #EX2 order by TIND,TNEWIND

 select * from #EX2 where TIND=13013 and TNEWIND>3

 drop index #EX2_NONCLU on #EX2

 ----task 3----

 create index #EX2_TIND_X on #EX2(TIND) include (TNEWIND)

 select * from #EX2 where TIND>15000
 
 drop index #EX2_TIND_X on #EX2

 ----task 4----
 ---0.127
SELECT TIND from  #EX2 where TIND between 5000 and 19999; 
---0.006
SELECT TIND from  #EX2 where TIND>15000 and  TIND < 20000 
---0.0031
SELECT TIND from  #EX2 where TIND=17000

create index #EX2_WHERE on #EX2(TIND) where (TIND>=15000 and TIND<20000)
drop index #EX2_WHERE on #EX2

----task 5----
use tempdb

create table #EX5
(
	TKEY int, 
    ID int identity(1, 1),
    TF varchar(100)
);

set nocount on;
declare @iter int = 0;
while @iter < 15000
begin
	INSERT #EX5(TKEY, TF) values(floor(30000 * RAND()), replicate('строка ', 10));
	set @iter += 1;
end;

create index #EX5_TKEY on #EX5(TKEY)

select NAME [Индекс], avg_fragmentation_in_percent [Фрагментация %]
from sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'),
object_id(N'#EX5'),NULL,NULL,NULL) ss join sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id where name is not null

insert top(10000000) #EX5(TKEY, TF) select TKEY, TF from #EX5

alter index #EX5_TKEY on #EX5 reorganize

alter index #EX5_TKEY on #EX5 rebuild with (online = off);

---task 6---


drop index #EX5_TKEY on #EX5;
create index #EX05_TKEY on #EX5(TKEY) with (fillfactor = 65)

insert top(50)percent into #EX5(TKEY, TF) select TKEY, TF from #EX5;

select NAME [Индекс], avg_fragmentation_in_percent [Фрагментация %]
from sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'),
object_id(N'#EX5'),NULL,NULL,NULL) ss join sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id where name is not null

drop table #EX2



