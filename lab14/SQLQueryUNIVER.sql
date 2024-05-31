use UNIVER	
---task1.1---
go
create function COUNT_STUDENTS(@faculty varchar(20)) returns int
as 
begin 
	declare @num int = (select count(*) 
	from STUDENT join GROUPS 
		on GROUPS.IDGROUP = STUDENT.IDGROUP join FACULTY 
		on FACULTY.FACULTY = GROUPS.FACULTY 
			where GROUPS.FACULTY = @faculty);
return @num;
end;

go

select distinct GROUPS.FACULTY, dbo.COUNT_STUDENTS(GROUPS.FACULTY) from GROUPS

declare @i int = dbo.COUNT_STUDENTS('ИДиП');
print 'Количество студентов: '+ cast(@i as varchar)

go
drop function COUNT_STUDENTS

---task1.2---
go
alter function COUNT_STUDENTS (@faculty varchar(20) = null, @prof varchar(20) = null) returns int
as
begin
	declare @num int = (select count(*) from STUDENT 
		join GROUPS on GROUPS.IDGROUP = STUDENT.IDGROUP
		join FACULTY on FACULTY.FACULTY = GROUPS.FACULTY 
			where GROUPS.FACULTY = @faculty and GROUPS.PROFESSION = @prof);
	return @num;
end

go
declare @i int = dbo.COUNT_STUDENTS('ИДиП', '1-36 06 01');
print 'Количество студентов: '+ cast(@i as varchar)

---task2---
go
create function FSUBJECTS (@p varchar(20)) returns varchar(300)
as
begin
	declare @tv varchar(20)
	declare @t varchar(300) = 'Дисциплины: '
	declare CurSub cursor local
	for select SUBJECT.SUBJECT from SUBJECT where SUBJECT.PULPIT = @p;
	open CurSub
	fetch CurSub into @tv
	while @@FETCH_STATUS = 0
	begin
		set	@t=@t+ rtrim(@tv)+' , '
		fetch CurSub into @tv;
	end
	return @t
end

go
select distinct SUBJECT.PULPIT, dbo.FSUBJECTS(SUBJECT.PULPIT) from SUBJECT
go
drop function FSUBJECTS

---task3---

create function FFACPUL (@fac varchar(20), @pul varchar(20)) returns table
as return
select FACULTY.FACULTY, PULPIT.PULPIT 
from FACULTY left outer join PULPIT
on FACULTY.FACULTY = PULPIT.FACULTY
where FACULTY.FACULTY = isnull(@fac, FACULTY.FACULTY)
and PULPIT.PULPIT = ISNULL(@pul, PULPIT.PULPIT);

go
select * from dbo.FFACPUL(NULL,NULL);
select * from dbo.FFACPUL('ЛХФ',NULL);
select * from dbo.FFACPUL(NULL,'ЛВ');
select * from dbo.FFACPUL('ЛХФ','ЛВ');

go
drop function FFACPUL

---task4---
go
create function FCTEACHER(@kod varchar(20)) returns int
as
begin
	declare @rc int = (select count(*) from TEACHER
					where TEACHER.PULPIT = isnull(@kod, TEACHER.PULPIT));
	return @rc
end;

go
select distinct TEACHER.PULPIT, dbo.FCTEACHER('ИСиТ')[Количество преподавателей] from TEACHER where TEACHER.PULPIT = 'ИСиТ'
select distinct dbo.FCTEACHER(NULL)[Всего преподавателей] from TEACHER

drop function FCTEACHER