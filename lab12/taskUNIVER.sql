---task1---

set nocount on
if exists (select * from SYS.OBJECTS
	where OBJECT_ID = object_id(N'DBO.X'))
drop table X;

declare @c int, @flag char = 'c';
SET IMPLICIT_TRANSACTIONS  ON    
create table X(names varchar(15) primary key,
			   age int);
	insert X values ('Anya', 12);
	set @c = (select count(*) from X);
	print 'Количество строк в таблице X: '+cast(@c as varchar(2));
	if @flag = 'c' commit; -- завершение транзакции: фиксация 
	else rollback;		   -- завершение транзакции: откат  
SET IMPLICIT_TRANSACTIONS  OFF

if exists (select * from SYS.objects
	where OBJECT_ID = object_id(N'DBO.X'))
print 'таблица X есть';
else print 'таблицы Х нет'

---task2---

begin try  --успешно--
	begin tran
		insert X values ('Tanya', 19);
		insert X values ('Misha', 15);
		delete X where age = 12;
	commit tran
end try
begin catch
	print 'ошибка: '+case
	when error_number()=2627 and patindex('%PK_X%',error_message())>0
	then 'дублирование'
	else 'неизвестная ошибка: '+cast(error_number() as varchar(5))+error_message()
	end;
	if @@trancount>0 rollback tran;
end catch

begin try
	begin tran --дублтрование--
		insert X values ('Tanya', 19);
		insert X values ('Misha', 15);
		delete X where age = 12;
	commit tran
end try
begin catch
	print 'ошибка: '+case

	when error_number()=2627 and patindex('%PK__X%',error_message())>0
	then 'дублирование'

	else 'неизвестная ошибка: '+cast(error_number() as varchar(5))+error_message()
	end;
	if @@trancount>0 rollback tran;
end catch

begin try
	begin tran --неизвестная ошибка (не тот тип данных)--
		insert X values ('mnmbmmn', 'HJKBJH');
	commit tran
end try
begin catch
	print 'ошибка: '+case

	when error_number()=2627 and patindex('%PK__X%',error_message())>0
	then 'дублирование'

	else 'неизвестная ошибка: '+cast(error_number() as varchar(5))+ ' ' + error_message()
	end;
	if @@trancount>0 rollback tran;
end catch

---task3---

declare @point varchar(32) --успешно
begin try
	begin tran
	insert TEACHER values ('КТИ','Казанцева Татьяна Игоревна','ж','ИСиТ') --вставка
	set @point = 'p1';
	save tran @point; --контрольаная точка р1

	delete TEACHER where TEACHER = 'КТИ'; --удаление
	set @point = 'p2';
	save tran @point; --контрольная точка р2
	
	update PROGRESS set NOTE = NOTE-1 where IDSTUDENT = 1005; --обновление
	set @point = 'p3';
	save tran @point; --контрольная точка р3
	commit tran
end try
begin catch
	print 'ошибка: '+case

	when error_number() = 2627 and patindex('%PK__TEACHER%', error_message())>0
	then 'дублирование'

	else 'неизвестна ошибка ' + cast(error_number() as varchar(5)) + ' ' + error_message()
	end;
if @@trancount>0
	begin
		print 'контрольная точка: ' + @point;
		rollback tran @point; --откат к контрольной точке
		commit tran;
	end; --фиксация изменений, выполненных до контрольной точки
end catch

------------------------------------------------

declare @point1 varchar(32) --p2
begin try
	begin tran
	insert TEACHER values ('КТИ','Казанцева Татьяна Игоревна','ж','ИСиТ') --вставка
	set @point1 = 'p1';
	save tran @point1; --контрольаная точка р1

	delete TEACHER where TEACHER = 'КТИ'; --удаление
	set @point1 = 'p2';
	save tran @point1; --контрольная точка р2
	
	update PROGRESS set NOTE = NOTE-1 where IDSTUDENT = 'ffff'; --обновление
	set @point1 = 'p3';
	save tran @point1; --контрольная точка р3
	commit tran
end try
begin catch
	print 'ошибка: '+case

	when error_number() = 2627 and patindex('%PK__TEACHER%', error_message())>0
	then 'дублирование'

	else 'неизвестна ошибка ' + cast(error_number() as varchar(5)) + ' ' + error_message()
	end;
if @@trancount>0
	begin
		print 'контрольная точка: ' + @point1;
		rollback tran @point1; --откат к контрольной точке
		commit tran;
	end; --фиксация изменений, выполненных до контрольной точки
end catch

-------------------------------------------------

declare @point2 varchar(32) --p1
begin try
	begin tran
	insert TEACHER values ('КТИ','Казанцева Татьяна Игоревна','ж','ИСиТ') --вставка
	set @point2 = 'p1';
	save tran @point2; --контрольаная точка р1

	delete TEACHER where TEACHER = 5; --удаление
	set @point2 = 'p2';
	save tran @point2; --контрольная точка р2
	
	update PROGRESS set NOTE = NOTE-1 where IDSTUDENT = 1005; --обновление
	set @point2 = 'p3';
	save tran @point2; --контрольная точка р3
	commit tran
end try
begin catch
	print 'ошибка: '+case

	when error_number() = 2627 and patindex('%PK__TEACHER%', error_message())>0
	then 'дублирование'

	else 'неизвестна ошибка ' + cast(error_number() as varchar(5)) + ' ' + error_message()
	end;
if @@trancount>0
	begin
		print 'контрольная точка: ' + @point2;
		rollback tran @point2; --откат к контрольной точке
		commit tran;
	end; --фиксация изменений, выполненных до контрольной точки
end catch

---task4---
delete TEACHER where TEACHER = 'КТИ';

--A--
set transaction isolation level READ UNCOMMITTED
begin transaction
select @@spid, 'insert TEACHER' 'результат', *from TEACHER
									where TEACHER = 'КТИ';
select @@spid, 'update PROGRESS' 'результат', NOTE, SUBJECT from PROGRESS where NOTE = 8;
-----t1-----
select @@spid, 'insert TEACHER' 'результат', *from TEACHER
									where TEACHER = 'КТИ';
select @@spid, 'update PROGRESS' 'результат', NOTE, SUBJECT from PROGRESS where NOTE = 8;
commit; 

select @@spid, * from TEACHER;
select @@spid, * from PROGRESS;
commit;
-----t2-----

--B--
begin transaction 
select @@spid
insert TEACHER values ('КТИ','Казанцева Татьяна Игоревна','ж','ИСиТ');
update PROGRESS set NOTE = 8 where IDSTUDENT = 1005;
-----t1-----
-----t2-----
rollback;

---task5---

--A--
set transaction isolation level READ COMMITTED 
begin transaction
select count(*) from TEACHER where PULPIT = 'ЛВ';
-----t1-----
-----t2-----
select 'update TEACHER' 'результат', count(*)
				from TEACHER where PULPIT = 'ЛВ';
commit;

--B--
begin transaction
-----t1-----
update TEACHER set PULPIT = 'ЛВ' where TEACHER='БРГ'
commit;
-----t2-----
rollback

update TEACHER set PULPIT = 'ИСиТ' where TEACHER='БРГ'

---task6---

--A--
set transaction isolation level REPEATABLE READ
begin transaction
select count(*) from TEACHER where PULPIT = 'ЛВ'
-----t1-----
-----t2-----
select case
when TEACHER='ЧЯР' then 'insert TEACHER' else ' '
end 'результат', TEACHER from TEACHER where  PULPIT = 'ЛВ'
commit;
--B--
begin transaction
-----t1-----

update TEACHER set PULPIT = 'ЛВ' where TEACHER='БРГ'
commit;
--insert TEACHER values ('ЧЯР','Чёрная Яна Руслановна','ж','ЛВ');
--commit;
-----t2-----
rollback

delete TEACHER where TEACHER = 'ЧЯР'

---task7---

--A--
set transaction isolation level SERIALIZABLE
begin transaction
insert TEACHER values ('ЧЯР','Чёрная Яна Руслановна','ж','ЛВ');
update TEACHER set PULPIT = 'ЛВ' where TEACHER='БРГ'
select count(*) from TEACHER where PULPIT = 'ЛВ'
-----t1-----
select count(*) from TEACHER where PULPIT = 'ЛВ'
-----t2-----
commit;

--B--
begin transaction
update TEACHER set PULPIT = 'ЛВ' where TEACHER='БРГ'
insert TEACHER values ('ЧЯР','Чёрная Яна Руслановна','ж','ЛВ');

select count(*) from TEACHER where PULPIT = 'ЛВ'
-----t1-----
commit;
select count(*) from TEACHER where PULPIT = 'ЛВ'
-----t2-----

---task8---

delete TEACHER where TEACHER = 'ИИИ'
update TEACHER set PULPIT = 'ИСиТ' where TEACHER = 'БЗБРДВ' 

begin tran --внешняя
insert TEACHER values ('ИИИ','Иванов Иван Иванович','м','ЛВ');
	begin tran --внутренняя
		update TEACHER set PULPIT = 'ЛЗиДВ' where TEACHER = 'БЗБРДВ' 
		commit; --внутренняя
		if @@trancount>0 rollback; --внешняя
	select
		(select count(*) from TEACHER where PULPIT = 'ЛВ')'ЛВ',
		(select count(*) from TEACHER where PULPIT = 'ЛЗиДВ')'ЛЗиДВ'
