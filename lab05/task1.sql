use UNIVER;

select PULPIT.PULPIT_NAME[Кафедра]
from PULPIT, FACULTY 
where PULPIT.FACULTY = FACULTY.FACULTY
and FACULTY.FACULTY in (select PROFESSION.FACULTY
						from PROFESSION
						where PROFESSION.PROFESSION_NAME like '%технология%'
						or    PROFESSION.PROFESSION_NAME like '%технологии%')

select PULPIT.PULPIT_NAME[Кафедра]
from PULPIT inner join FACULTY
on PULPIT.FACULTY = FACULTY.FACULTY
where FACULTY.FACULTY in (select PROFESSION.FACULTY
						  from PROFESSION
						  where PROFESSION.PROFESSION_NAME like '%технология%'
						  or PROFESSION.PROFESSION_NAME like '%технологии%')

select distinct PULPIT.PULPIT_NAME[Кафедра] 
from PULPIT inner join FACULTY
	on  FACULTY.FACULTY = PULPIT.FACULTY
	inner join PROFESSION
		on FACULTY.FACULTY = PROFESSION.FACULTY
		where PROFESSION.PROFESSION_NAME like '%технология%'
		   or PROFESSION.PROFESSION_NAME like '%технологии%'

select AUDITORIUM_NAME[Аудитория], AUDITORIUM_TYPE[Тип аудитории], AUDITORIUM_CAPACITY[Вместимость]
from AUDITORIUM a
where a.AUDITORIUM_CAPACITY = (select top(1) AUDITORIUM_CAPACITY from AUDITORIUM aa
						   where aa.AUDITORIUM_TYPE = a.AUDITORIUM_TYPE order by AUDITORIUM_CAPACITY desc)
order by AUDITORIUM_CAPACITY desc

select FACULTY_NAME from FACULTY
where not exists (select * from PULPIT 
				  where PULPIT.FACULTY = FACULTY.FACULTY) 

select top 1
	(select avg(NOTE) from PROGRESS 
			where SUBJECT like 'ОАиП')[ОАиП],
	(select avg(NOTE) from PROGRESS 
			where SUBJECT like 'КГ')[КГ],
	(select avg(NOTE) from PROGRESS 
			where SUBJECT like 'СУБД')[СУБД]
from PROGRESS

select NOTE, SUBJECT from PROGRESS
	where NOTE >=all (select NOTE from PROGRESS WHERE SUBJECT like 'О%')

select NOTE, SUBJECT from PROGRESS
	where NOTE >any (select NOTE from PROGRESS WHERE NOTE > 5)
	order by NOTE desc





