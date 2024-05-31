use UNIVER

select AUDITORIUM_TYPENAME,
	max(AUDITORIUM_CAPACITY)[Максимальная вмесимость аудиторий],
	min(AUDITORIUM_CAPACITY)[Минимальная вмесимость аудиторий],
	avg(AUDITORIUM_CAPACITY)[Средняя вмесимость аудиторий],
	sum(AUDITORIUM_CAPACITY)[Суммарная вмесимость аудиторий],
	count(AUDITORIUM_TYPE.AUDITORIUM_TYPE)[Общее количсетво аудиторий данного типа]
from AUDITORIUM inner join AUDITORIUM_TYPE
on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE Group by AUDITORIUM_TYPENAME

select *
from (select Case when PROGRESS.NOTE between 1 and 5 then 'Оценка ниже 5'
	when PROGRESS.NOTE between 5 and 7 then 'Оценка от 5 до 7'
	else 'Оценка выше 7'
	end [Пределы оценок], count(*)[Количество]
from PROGRESS Group by Case
	when PROGRESS.NOTE between 1 and 5 then 'Оценка ниже 5'
	when PROGRESS.NOTE between 5 and 7 then 'Оценка от 5 до 7'
	else 'Оценка выше 7'
	end) as T
		order by Case[Пределы оценок]
			when 'Оценка ниже 5' then 3
			when 'Оценка от 5 до 7' then 2 
			when 'Оценка выше 7' then 1
			else 0
		end

select f.FACULTY,
	   g.PROFESSION,
	   g.IDGROUP,
	   (2014 - g.YEAR_FIRST)[Курс],
	   round(avg(cast(p.NOTE as float)),2) as [Средняя оценка]
from FACULTY f 
	inner join GROUPS g on f.FACULTY = g.FACULTY
	inner join STUDENT s on g.IDGROUP = s.IDGROUP
	inner join PROGRESS p on p.IDSTUDENT = s.IDSTUDENT
group by f.FACULTY, g.PROFESSION, g.YEAR_FIRST, g.IDGROUP
order by [Средняя оценка] desc

select f.FACULTY,
	   g.PROFESSION,
	   g.IDGROUP,
	   (2014 - g.YEAR_FIRST)[Курс],
	   round(avg(cast(p.NOTE as float)),2) as [Средняя оценка]
from FACULTY f 
	inner join GROUPS g on f.FACULTY = g.FACULTY
	inner join STUDENT s on g.IDGROUP = s.IDGROUP
	inner join PROGRESS p on p.IDSTUDENT = s.IDSTUDENT
	where p.SUBJECT = 'ОАиП' or p.SUBJECT = 'КГ'
group by f.FACULTY, g.PROFESSION, g.YEAR_FIRST, g.IDGROUP 
order by [Средняя оценка] desc

select g.PROFESSION,
	   p.SUBJECT,
	   f.FACULTY,
	   round(avg(cast(p.NOTE as float)),2) as [Средняя оценка]
from FACULTY f
	inner join GROUPS g on f.FACULTY = g.FACULTY
	inner join STUDENT s on g.IDGROUP = s.IDGROUP
	inner join PROGRESS p on p.IDSTUDENT = s.IDSTUDENT
	where f.FACULTY in ('ХТиТ')
group by g.PROFESSION, p.SUBJECT, f.FACULTY

select  p.SUBJECT, p.NOTE, count(p.NOTE)[Количество_студентов]
from PROGRESS p
	group by p.SUBJECT, p.NOTE
	having p.NOTE = 8 or p.NOTE = 5
order by (p.SUBJECT)

