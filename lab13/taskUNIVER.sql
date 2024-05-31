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
print '���������� ���������: ' + cast(@n1 as varchar(5));

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

insert #SUBJECT exec PSUBJECT @p = '����'
insert #SUBJECT exec PSUBJECT @p = '�����'

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
	print '����� ������: '+ cast(error_number() as varchar(6));
	print '���������: '+ error_message();
	print '�������: '+ cast(error_severity() as varchar(6));
	print '�����: '+ cast(error_state() as varchar(6));
	print '����� ������: '+ cast(error_line() as varchar(8));
	print '����� ������: '+ cast(error_number() as varchar(8));
	if ERROR_PROCEDURE() is not null
	print '��� ���������: '+ error_procedure();
	return -1;
end catch
go

declare @rc int; ---�������
exec @rc = PAUDITORIUM_INSERT @a = '203-3', @n = '��', @c = 70, @t = '203-3';
print '��� ������: '+ cast(@rc as varchar(5));

declare @rc1 int; ---������
exec @rc1 = PAUDITORIUM_INSERT @a = '203-3', @n = '��', @c = 70, @t = '203-3';
print '��� ������: '+ cast(@rc1 as varchar(5));

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
		raiserror('������',11,1);
	else 
		open SubRep;
		fetch SubRep into @tv;
		print '����������';
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
	print '������ � ����������'
	if error_procedure() is not null
		print '��� ���������: '+error_procedure();
	return @k;
end catch
go

declare @k int; ---�������
exec @k = SUBJECT_REPORT @p = '����'
print '���������� ���������: '+cast(@k as varchar(5));
go

declare @k int; ---������ � ����������
exec @k = SUBJECT_REPORT @p = 12
print '���������� ���������: '+cast(@k as varchar(5));
go

--- task6 ---
--exec @rc = PAUDITORIUM_INSERT @a = '203-3', @n = '��', @c = 70, @t = '203-3';

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
 print '����� ������: '+ cast(error_number() as varchar(5));
 print '���������: '+error_message();
 print '�������: '+cast(error_severity() as varchar(6));
 print '�����: '+cast(error_state() as varchar (8));
 print '����� ������:' + cast(error_line() as varchar(8));
 if error_procedure() is not null
 print '���������: '+error_procedure();
if @@TRANCOUNT>0 rollback tran;
return -1;
end catch
go

declare @k int;
exec @k = PAUDITORIUM_INSERTX @a = '205', @n = '��', @c = 10, @t = '205', @tn = '������������ �������';
print '��� ������ = '+cast(@k as varchar(5));

select * from AUDITORIUM;
select * from AUDITORIUM_TYPE;