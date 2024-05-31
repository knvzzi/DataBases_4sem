use UNIVER

select AUDITORIUM_TYPENAME,
	max(AUDITORIUM_CAPACITY)[������������ ���������� ���������],
	min(AUDITORIUM_CAPACITY)[����������� ���������� ���������],
	avg(AUDITORIUM_CAPACITY)[������� ���������� ���������],
	sum(AUDITORIUM_CAPACITY)[��������� ���������� ���������],
	count(AUDITORIUM_TYPE.AUDITORIUM_TYPE)[����� ���������� ��������� ������� ����]
from AUDITORIUM inner join AUDITORIUM_TYPE
on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE Group by AUDITORIUM_TYPENAME

select *
from (select Case when PROGRESS.NOTE between 1 and 5 then '������ ���� 5'
	when PROGRESS.NOTE between 5 and 7 then '������ �� 5 �� 7'
	else '������ ���� 7'
	end [������� ������], count(*)[����������]
from PROGRESS Group by Case
	when PROGRESS.NOTE between 1 and 5 then '������ ���� 5'
	when PROGRESS.NOTE between 5 and 7 then '������ �� 5 �� 7'
	else '������ ���� 7'
	end) as T
		order by Case[������� ������]
			when '������ ���� 5' then 3
			when '������ �� 5 �� 7' then 2 
			when '������ ���� 7' then 1
			else 0
		end

select f.FACULTY,
	   g.PROFESSION,
	   g.IDGROUP,
	   (2014 - g.YEAR_FIRST)[����],
	   round(avg(cast(p.NOTE as float)),2) as [������� ������]
from FACULTY f 
	inner join GROUPS g on f.FACULTY = g.FACULTY
	inner join STUDENT s on g.IDGROUP = s.IDGROUP
	inner join PROGRESS p on p.IDSTUDENT = s.IDSTUDENT
group by f.FACULTY, g.PROFESSION, g.YEAR_FIRST, g.IDGROUP
order by [������� ������] desc

select f.FACULTY,
	   g.PROFESSION,
	   g.IDGROUP,
	   (2014 - g.YEAR_FIRST)[����],
	   round(avg(cast(p.NOTE as float)),2) as [������� ������]
from FACULTY f 
	inner join GROUPS g on f.FACULTY = g.FACULTY
	inner join STUDENT s on g.IDGROUP = s.IDGROUP
	inner join PROGRESS p on p.IDSTUDENT = s.IDSTUDENT
	where p.SUBJECT = '����' or p.SUBJECT = '��'
group by f.FACULTY, g.PROFESSION, g.YEAR_FIRST, g.IDGROUP 
order by [������� ������] desc

select g.PROFESSION,
	   p.SUBJECT,
	   f.FACULTY,
	   round(avg(cast(p.NOTE as float)),2) as [������� ������]
from FACULTY f
	inner join GROUPS g on f.FACULTY = g.FACULTY
	inner join STUDENT s on g.IDGROUP = s.IDGROUP
	inner join PROGRESS p on p.IDSTUDENT = s.IDSTUDENT
	where f.FACULTY in ('����')
group by g.PROFESSION, p.SUBJECT, f.FACULTY

select  p.SUBJECT, p.NOTE, count(p.NOTE)[����������_���������]
from PROGRESS p
	group by p.SUBJECT, p.NOTE
	having p.NOTE = 8 or p.NOTE = 5
order by (p.SUBJECT)

