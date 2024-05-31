use UNIVER

--- task1 ---

go
CREATE PROCEDURE PSUBJECT
as
begin
	declare @n int = (select count(*) from SUBJECT);
	select * from SUBJECT;
	return @n;
end;

declare @n1 int = 0;
exec @n1 = PSUBJECT;
print 'Количество предметов: ' + cast(@n1 as varchar(5));

drop procedure PSUBJECT
--- task3 ---

create table #SUBJECT(
		SUBJECT char(10) primary key not null,
		SUBJECT_NAME varchar(100),
		PULPIT char(20)
)
go

alter procedure PSUBJECT @p varchar(20)=null
as begin
DECLARE @n int = (select count(*) from SUBJECT);
select * from SUBJECT where PULPIT = @p;
end;
go

insert #SUBJECT exec PSUBJECT @p = 'ИСиТ'
insert #SUBJECT exec PSUBJECT @p = 'ЛМиЛЗ'

select * from #SUBJECT
go

--- task4 ---

create procedure PAUDITORIUM_INSERT 
		@a char(20), @n char(10), @c int = 0, @t varchar(50)
as declare @rc int = 1;
begin try
	insert into AUDITORIUM(AUDITORIUM, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY, AUDITORIUM_NAME) values (@a, @n, @c, @t);
	return @rc;
end try
begin catch
	print 'Номер ошибки: '+ cast(error_number() as varchar(6));
	print 'Сообщение: '+ error_message();
	print 'Уровень: '+ cast(error_severity() as varchar(6));
	print 'Метка: '+ cast(error_state() as varchar(6));
	print 'Номер строки: '+ cast(error_line() as varchar(8));
	print 'Номер ошибки: '+ cast(error_number() as varchar(8));
	if ERROR_PROCEDURE() is not null
	print 'Имя процедуры: '+ error_procedure();
	return -1;
end catch
go

declare @rc int; ---успешно
exec @rc = PAUDITORIUM_INSERT @a = '203-3', @n = 'ЛК', @c = 70, @t = '203-3';
print 'Код ошибки: '+ cast(@rc as varchar(5));

declare @rc1 int; ---ошибка
exec @rc1 = PAUDITORIUM_INSERT @a = '203-3', @n = 'ЛК', @c = 70, @t = '203-3';
print 'Код ошибки: '+ cast(@rc1 as varchar(5));

drop procedure PAUDITORIUM_INSERT
go

--- task5 ---

create procedure SUBJECT_REPORT @p char(10)
as declare @k int = 0;
begin try
	declare @tv char(20), @t char(300) = ' ';
	declare SubRep cursor for
	select SUBJECT from SUBJECT where PULPIT = @p;
	if not exists (select SUBJECT from SUBJECT where PULPIT = @p)
		raiserror('ошибка',11,1);
	else 
		open SubRep;
		fetch SubRep into @tv;
		print 'Дисциплины';
		while @@FETCH_STATUS = 0
		begin
			set @t=rtrim(@tv) + ' , ' + @t;
			set @k = @k + 1;
			fetch SubRep into @tv;
		end;
		print @t;
		close SubRep;
		return @k;
end try
begin catch
	print 'ошибка в параметрах'
	if error_procedure() is not null
		print 'имя процедуры: '+error_procedure();
	return @k;
end catch
go

declare @k int; ---успешно
exec @k = SUBJECT_REPORT @p = 'ИСиТ'
print 'количество дисциплин: '+cast(@k as varchar(5));
go

declare @k int; ---ошибка в параметрах
exec @k = SUBJECT_REPORT @p = 12
print 'количество дисциплин: '+cast(@k as varchar(5));
go

--- task6 ---
--exec @rc = PAUDITORIUM_INSERT @a = '203-3', @n = 'ЛК', @c = 70, @t = '203-3';

create procedure PAUDITORIUM_INSERTX @a char(20), @n char(10), @c int = 0, @t varchar(50), @tn varchar(50)
as declare @k int = 1;
begin try
	set transaction isolation level SERIALIZABLE;
	begin tran
		insert into AUDITORIUM_TYPE(AUDITORIUM_TYPE, AUDITORIUM_TYPENAME) values (@n, @tn);
		exec @k = PAUDITORIUM_INSERT @a, @n, @c, @t;
	commit tran;
	return @k
end try
begin catch
 print 'Номер ошибки: '+ cast(error_number() as varchar(5));
 print 'Сообщение: '+error_message();
 print 'Уровень: '+cast(error_severity() as varchar(6));
 print 'Метка: '+cast(error_state() as varchar (8));
 print 'Номер строки:' + cast(error_line() as varchar(8));
 if error_procedure() is not null
 print 'Процедура: '+error_procedure();
if @@TRANCOUNT>0 rollback tran;
return -1;
end catch
go

declare @k int;
exec @k = PAUDITORIUM_INSERTX @a = '205', @n = 'ЛБ', @c = 10, @t = '205', @tn = 'Лабораторный кабинет';
print 'код ошибки = '+cast(@k as varchar(5));

select * from AUDITORIUM;
select * from AUDITORIUM_TYPE;