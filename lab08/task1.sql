use UNIVER;

go
CREATE VIEW [�������������]
	as select TEACHER [���],
			  TEACHER_NAME [��� �������������],
			  GENDER [���],
			  PULPIT [��� �������] from TEACHER

go
select * from [�������������]
DROP VIEW [�������������]

go
CREATE VIEW [���������� ������]
	as select f.FACULTY [���������], 
	count(p.PULPIT) [���������� ������]
	from FACULTY f inner join PULPIT p
	on f.FACULTY = p.FACULTY
	group by f.FACULTY

go
ALTER VIEW [���������� ������] with SCHEMABINDING
as select	f.FACULTY		[���������],
			count(p.PULPIT)		[���������� ������]
			from dbo.FACULTY f inner join dbo.PULPIT p
			on f.FACULTY = p.FACULTY 
			group by f.FACULTY;

go
select * from [���������� ������]
DROP VIEW [���������� ������]

go
create view [���������](���, ���)
as
select AUDITORIUM.AUDITORIUM, 
	   AUDITORIUM_TYPE
from AUDITORIUM
where AUDITORIUM.AUDITORIUM_TYPE like '��%'

go
insert ��������� values ('328-9', 'N�')

go
select * from [���������]

go
alter view [���������] (���, ���)
as select AUDITORIUM, AUDITORIUM_TYPE from AUDITORIUM
where AUDITORIUM.AUDITORIUM_TYPE like '��%' WITH CHECK OPTION

go
select * from [���������]
DROP VIEW [���������]

go
create view ����������(���, ������������, ���_�������)
as select TOP 150 SUBJECT.SUBJECT,
		  SUBJECT.SUBJECT_NAME,
		  SUBJECT.PULPIT
from SUBJECT 
ORDER BY SUBJECT.SUBJECT

go
select * from [����������]
DROP VIEW [����������]