use UNIVER;

go
CREATE VIEW [Преподаватель]
	as select TEACHER [Код],
			  TEACHER_NAME [Имя преподавателя],
			  GENDER [Пол],
			  PULPIT [Код кафедры] from TEACHER

go
select * from [Преподаватель]
DROP VIEW [Преподаватель]

go
CREATE VIEW [Количество кафедр]
	as select f.FACULTY [Факультет], 
	count(p.PULPIT) [Количество кафедр]
	from FACULTY f inner join PULPIT p
	on f.FACULTY = p.FACULTY
	group by f.FACULTY

go
ALTER VIEW [Количество кафедр] with SCHEMABINDING
as select	f.FACULTY		[Факультет],
			count(p.PULPIT)		[Количество кафедр]
			from dbo.FACULTY f inner join dbo.PULPIT p
			on f.FACULTY = p.FACULTY 
			group by f.FACULTY;

go
select * from [Количество кафедр]
DROP VIEW [Количество кафедр]

go
create view [Аудитории](Код, Тип)
as
select AUDITORIUM.AUDITORIUM, 
	   AUDITORIUM_TYPE
from AUDITORIUM
where AUDITORIUM.AUDITORIUM_TYPE like 'ЛК%'

go
insert Аудитории values ('328-9', 'NК')

go
select * from [Аудитории]

go
alter view [Аудитории] (Код, Тип)
as select AUDITORIUM, AUDITORIUM_TYPE from AUDITORIUM
where AUDITORIUM.AUDITORIUM_TYPE like 'ЛК%' WITH CHECK OPTION

go
select * from [Аудитории]
DROP VIEW [Аудитории]

go
create view Дисциплины(Код, Наименование, Код_кафедры)
as select TOP 150 SUBJECT.SUBJECT,
		  SUBJECT.SUBJECT_NAME,
		  SUBJECT.PULPIT
from SUBJECT 
ORDER BY SUBJECT.SUBJECT

go
select * from [Дисциплины]
DROP VIEW [Дисциплины]