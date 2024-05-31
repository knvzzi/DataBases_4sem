use UNIVER

---task1---

create table TR_AUDIT
(
	ID int identity,    ---номер
	STMT varchar(20)    ---DML-оператор
		check (STMT in ('INS','DEL','UPD')),
	TRNAME varchar(50), ---имя триггера
	CC varchar(300)     ---комментарий
)

go
create trigger TR_TEACHER_INS  on TEACHER after INSERT
as declare @a1 char(10), @a2 varchar(100), @a3 char(1), @a4 char(20), @in varchar(300);
print 'Операция вставки';
set @a1 = (select [TEACHER] from INSERTED);
set @a2 = (select [TEACHER_NAME] from INSERTED);
set @a3 = (select [GENDER] from INSERTED);
set @a4 = (select [PULPIT] from INSERTED);
set @in = cast(@a1 as varchar(20))+''+cast(@a2 as varchar(20))+''+cast(@a3 as varchar(20))+''+cast(@a4 as varchar(20));
insert into TR_AUDIT(STMT, TRNAME, CC) values ('INS', 'TRIG_Tov_Ins', @in);
return

insert into TEACHER(TEACHER, TEACHER_NAME, GENDER, PULPIT) values ('КТИ', 'Казанцева Татьяна Игоревна', 'ж', 'ИСиТ')

select * from TR_AUDIT

---task2---
go 
create trigger TR_TEACHER_DEL on TEACHER after DELETE
as declare @a1 char(10), @a2 varchar(100), @a3 char(1), @a4 char(20), @in varchar(300); 
print 'Операция удаления'
set @a1 = (select [TEACHER] from DELETED);
set @a2 = (select [TEACHER_NAME] from DELETED);
set @a3 = (select [GENDER] from DELETED);
set @a4 = (select [PULPIT] from DELETED);
set @in = cast(@a1 as varchar(20))+''+cast(@a2 as varchar(20))+''+cast(@a3 as varchar(20))+''+cast(@a4 as varchar(20));
insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL', 'TR_TEACHER_DEL', @in);
return;

delete from TEACHER where TEACHER.TEACHER = 'КТИ';

select * from TR_AUDIT

---task3---
go
create trigger TR_TEACHER_UPD  on TEACHER after UPDATE 
as declare @a1 char(10), @a2 varchar(100), @a3 char(1), @a4 char(20), @in varchar(300), @on varchar(300);
print 'Операция обновления 1';
set @a1 = (select [TEACHER] from INSERTED);
set @a2 = (select [TEACHER_NAME] from INSERTED);
set @a3 = (select [GENDER] from INSERTED);
set @a4 = (select [PULPIT] from INSERTED);
set @in = cast(@a1 as varchar(20))+''+cast(@a2 as varchar(20))+''+cast(@a3 as varchar(20))+''+cast(@a4 as varchar(20));
insert into TR_AUDIT(STMT, TRNAME, CC) values ('UPD', 'TR_TEACHER_UPD', @in);
print 'Операция обновления 2'
set @a1 = (select [TEACHER] from DELETED);
set @a2 = (select [TEACHER_NAME] from DELETED);
set @a3 = (select [GENDER] from DELETED);
set @a4 = (select [PULPIT] from DELETED);
set @in = cast(@a1 as varchar(20))+''+cast(@a2 as varchar(20))+''+cast(@a3 as varchar(20))+''+cast(@a4 as varchar(20));
insert into TR_AUDIT(STMT, TRNAME, CC) values ('UPD', 'TR_TEACHER_UPD', @in);
return;

UPDATE TEACHER 
SET TEACHER_NAME = 'Казанцева Татьяна Игоревна',
    GENDER = 'м',
    PULPIT = 'ИСиТ'
WHERE TEACHER = 'КТИ';

select * from TR_AUDIT

delete from TR_AUDIT where ID = 5;

---task4---
go
create trigger TR_TEACHER on TEACHER after INSERT, DELETE, UPDATE
as declare @a1 char(10), @a2 varchar(100), @a3 char(1), @a4 char(20), @in varchar(300), @on varchar(300);
declare @ins int = (select count(*) from inserted),
		@del int = (select count(*) from deleted);
if @ins>0 and @del=0
begin
	print 'Событие: INSERT';
	set @a1 = (select [TEACHER] from INSERTED);
	set @a2 = (select [TEACHER_NAME] from INSERTED);
	set @a3 = (select [GENDER] from INSERTED);
	set @a4 = (select [PULPIT] from INSERTED);
	set @in = cast(@a1 as varchar(20))+''+cast(@a2 as varchar(20))+''+cast(@a3 as varchar(20))+''+cast(@a4 as varchar(20));
	insert into TR_AUDIT(STMT, TRNAME, CC) values ('INS', 'TR_TEACHER', @in);
end;
else
if @ins=0 and @del>0
begin
	print 'Событие: DELETE';
	set @a1 = (select [TEACHER] from DELETED);
	set @a2 = (select [TEACHER_NAME] from DELETED);
	set @a3 = (select [GENDER] from DELETED);
	set @a4 = (select [PULPIT] from DELETED);
	set @in = cast(@a1 as varchar(20))+''+cast(@a2 as varchar(20))+''+cast(@a3 as varchar(20))+''+cast(@a4 as varchar(20));
	insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL', 'TR_TEACHER', @in);
end;
else 
if @ins>0 and @del>0
begin
	print 'Событие: UPDATE';
	set @a1 = (select [TEACHER] from INSERTED);
	set @a2 = (select [TEACHER_NAME] from INSERTED);
	set @a3 = (select [GENDER] from INSERTED);
	set @a4 = (select [PULPIT] from INSERTED);
	set @in = cast(@a1 as varchar(20))+''+cast(@a2 as varchar(20))+''+cast(@a3 as varchar(20))+''+cast(@a4 as varchar(20));
	insert into TR_AUDIT(STMT, TRNAME, CC) values ('UPD', 'TR_TEACHER(ins)', @in);
	set @a1 = (select [TEACHER] from DELETED);
	set @a2 = (select [TEACHER_NAME] from DELETED);
	set @a3 = (select [GENDER] from DELETED);
	set @a4 = (select [PULPIT] from DELETED);
	set @in = cast(@a1 as varchar(20))+''+cast(@a2 as varchar(20))+''+cast(@a3 as varchar(20))+''+cast(@a4 as varchar(20));
	insert into TR_AUDIT(STMT, TRNAME, CC) values ('UPD', 'TR_TEACHER(del)', @in);
end
return

insert into TEACHER(TEACHER, TEACHER_NAME, GENDER, PULPIT) values ('ИИИ', 'Иванов Иван Иванович', 'м', 'ИСиТ')
delete from TEACHER where TEACHER.TEACHER = 'ИИИ';
UPDATE TEACHER 
SET TEACHER_NAME = 'Иванович Иван Иванович',
    GENDER = 'м',
    PULPIT = 'ИСиТ'
WHERE TEACHER = 'ИИИ';
select * from TR_AUDIT

---task5---
insert into TEACHER values ('Для теста', 'Для теста', 'н', 'ИСиТ')
select * from TR_AUDIT order by ID

---task6---
go
create trigger TR_TEACHER_DEL1 on TEACHER after DELETE
	as declare @in varchar(300)
	print 'AUD_AFTER_DELETE_A';
	set @in = 'Trigger Normal Priority'
	insert into TR_AUDIT (STMT, TRNAME, CC) values ('DEL', 'TR_TEACHER_DEL1', @IN)

return;
go
create trigger TR_TEACHER_DEL2 on TEACHER after DELETE
	as declare @in varchar(300)
	print 'AUD_AFTER_DELETE_B';
	set @in = 'Trigger Low Priority'
	insert into TR_AUDIT (STMT, TRNAME, CC) values ('DEL', 'TR_TEACHER_DEL2', @IN)
	return;
go
create trigger TR_TEACHER_DEL3 on TEACHER after DELETE
	as declare @in varchar(300)
	print 'AUD_AFTER_DELETE_C';
	set @in = 'Trigger Highest Priority'
	insert into TR_AUDIT (STMT, TRNAME, CC) values ('DEL', 'TR_TEACHER_DEL3', @IN)
	return;

select t.name, e.type_desc
	from sys.triggers t join sys.trigger_events e
		on t.object_id=e.object_id
			where OBJECT_NAME(t.parent_id)='TEACHER' and e.type_desc='DELETE';

exec sp_settriggerorder @triggername='TR_TEACHER_DEL3',
	@order='First', @stmttype='DELETE';

exec sp_settriggerorder @triggername='TR_TEACHER_DEL2',
	@order='Last', @stmttype='DELETE';

insert into TEACHER(TEACHER, TEACHER_NAME, GENDER, PULPIT) values ('ИИИ', 'Иванов Иван Иванович', 'м', 'ИСиТ')
delete from TEACHER where TEACHER.TEACHER = 'ИИИ';
select * from TR_AUDIT order by ID

---task7---
go
create trigger TEACH_TRAN 
				on TEACHER after insert, update, delete
					as declare @c int = (select count(TEACHER) from TEACHER)
if(@c>10)
begin
	raiserror('Общее количество учителей не может быть больше 10', 10,1)
	rollback;
end;
return;

insert into TEACHER values ('ТЕСТ', 'Просто для теста', 'м', 'ИСиТ')
select * from TEACHER
select * from TR_AUDIT order by ID

---task8---
go
create trigger Faculty_INSTEAD_OF
		on FACULTY instead of DELETE
		as raiserror (N'Удаление запрещено', 10,1);
return;

delete from FACULTY where FACULTY='ЛХФ';

---task9---
go
create trigger TR_TEACHER_DDL on database 
for DDL_DATABASE_LEVEL_EVENTS  as   
declare @EVENT_TYPE varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]', 'varchar(50)')
declare @OBJ_NAME varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'varchar(50)')
declare @OBJ_TYPE varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectType)[1]', 'varchar(50)')
if @OBJ_NAME = 'TEACHER' 
begin
	print 'Тип события: ' + cast(@EVENT_TYPE as varchar)
	print 'Имя объекта: ' + cast(@OBJ_NAME as varchar)
	print 'Тип объекта: ' + cast(@OBJ_TYPE as varchar)
	raiserror('Операции с таблицей TEACHER запрещены.', 16, 1)
	rollback  
end

go
alter table TEACHER drop column TEACHER_NAME