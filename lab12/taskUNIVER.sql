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
	print '���������� ����� � ������� X: '+cast(@c as varchar(2));
	if @flag = 'c' commit; -- ���������� ����������: �������� 
	else rollback;		   -- ���������� ����������: �����  
SET IMPLICIT_TRANSACTIONS  OFF

if exists (select * from SYS.objects
	where OBJECT_ID = object_id(N'DBO.X'))
print '������� X ����';
else print '������� � ���'

---task2---

begin try  --�������--
	begin tran
		insert X values ('Tanya', 19);
		insert X values ('Misha', 15);
		delete X where age = 12;
	commit tran
end try
begin catch
	print '������: '+case
	when error_number()=2627 and patindex('%PK_X%',error_message())>0
	then '������������'
	else '����������� ������: '+cast(error_number() as varchar(5))+error_message()
	end;
	if @@trancount>0 rollback tran;
end catch

begin try
	begin tran --������������--
		insert X values ('Tanya', 19);
		insert X values ('Misha', 15);
		delete X where age = 12;
	commit tran
end try
begin catch
	print '������: '+case

	when error_number()=2627 and patindex('%PK__X%',error_message())>0
	then '������������'

	else '����������� ������: '+cast(error_number() as varchar(5))+error_message()
	end;
	if @@trancount>0 rollback tran;
end catch

begin try
	begin tran --����������� ������ (�� ��� ��� ������)--
		insert X values ('mnmbmmn', 'HJKBJH');
	commit tran
end try
begin catch
	print '������: '+case

	when error_number()=2627 and patindex('%PK__X%',error_message())>0
	then '������������'

	else '����������� ������: '+cast(error_number() as varchar(5))+ ' ' + error_message()
	end;
	if @@trancount>0 rollback tran;
end catch

---task3---

declare @point varchar(32) --�������
begin try
	begin tran
	insert TEACHER values ('���','��������� ������� ��������','�','����') --�������
	set @point = 'p1';
	save tran @point; --������������ ����� �1

	delete TEACHER where TEACHER = '���'; --��������
	set @point = 'p2';
	save tran @point; --����������� ����� �2
	
	update PROGRESS set NOTE = NOTE-1 where IDSTUDENT = 1005; --����������
	set @point = 'p3';
	save tran @point; --����������� ����� �3
	commit tran
end try
begin catch
	print '������: '+case

	when error_number() = 2627 and patindex('%PK__TEACHER%', error_message())>0
	then '������������'

	else '���������� ������ ' + cast(error_number() as varchar(5)) + ' ' + error_message()
	end;
if @@trancount>0
	begin
		print '����������� �����: ' + @point;
		rollback tran @point; --����� � ����������� �����
		commit tran;
	end; --�������� ���������, ����������� �� ����������� �����
end catch

------------------------------------------------

declare @point1 varchar(32) --p2
begin try
	begin tran
	insert TEACHER values ('���','��������� ������� ��������','�','����') --�������
	set @point1 = 'p1';
	save tran @point1; --������������ ����� �1

	delete TEACHER where TEACHER = '���'; --��������
	set @point1 = 'p2';
	save tran @point1; --����������� ����� �2
	
	update PROGRESS set NOTE = NOTE-1 where IDSTUDENT = 'ffff'; --����������
	set @point1 = 'p3';
	save tran @point1; --����������� ����� �3
	commit tran
end try
begin catch
	print '������: '+case

	when error_number() = 2627 and patindex('%PK__TEACHER%', error_message())>0
	then '������������'

	else '���������� ������ ' + cast(error_number() as varchar(5)) + ' ' + error_message()
	end;
if @@trancount>0
	begin
		print '����������� �����: ' + @point1;
		rollback tran @point1; --����� � ����������� �����
		commit tran;
	end; --�������� ���������, ����������� �� ����������� �����
end catch

-------------------------------------------------

declare @point2 varchar(32) --p1
begin try
	begin tran
	insert TEACHER values ('���','��������� ������� ��������','�','����') --�������
	set @point2 = 'p1';
	save tran @point2; --������������ ����� �1

	delete TEACHER where TEACHER = 5; --��������
	set @point2 = 'p2';
	save tran @point2; --����������� ����� �2
	
	update PROGRESS set NOTE = NOTE-1 where IDSTUDENT = 1005; --����������
	set @point2 = 'p3';
	save tran @point2; --����������� ����� �3
	commit tran
end try
begin catch
	print '������: '+case

	when error_number() = 2627 and patindex('%PK__TEACHER%', error_message())>0
	then '������������'

	else '���������� ������ ' + cast(error_number() as varchar(5)) + ' ' + error_message()
	end;
if @@trancount>0
	begin
		print '����������� �����: ' + @point2;
		rollback tran @point2; --����� � ����������� �����
		commit tran;
	end; --�������� ���������, ����������� �� ����������� �����
end catch

---task4---
delete TEACHER where TEACHER = '���';

--A--
set transaction isolation level READ UNCOMMITTED
begin transaction
select @@spid, 'insert TEACHER' '���������', *from TEACHER
									where TEACHER = '���';
select @@spid, 'update PROGRESS' '���������', NOTE, SUBJECT from PROGRESS where NOTE = 8;
-----t1-----
select @@spid, 'insert TEACHER' '���������', *from TEACHER
									where TEACHER = '���';
select @@spid, 'update PROGRESS' '���������', NOTE, SUBJECT from PROGRESS where NOTE = 8;
commit; 

select @@spid, * from TEACHER;
select @@spid, * from PROGRESS;
commit;
-----t2-----

--B--
begin transaction 
select @@spid
insert TEACHER values ('���','��������� ������� ��������','�','����');
update PROGRESS set NOTE = 8 where IDSTUDENT = 1005;
-----t1-----
-----t2-----
rollback;

---task5---

--A--
set transaction isolation level READ COMMITTED 
begin transaction
select count(*) from TEACHER where PULPIT = '��';
-----t1-----
-----t2-----
select 'update TEACHER' '���������', count(*)
				from TEACHER where PULPIT = '��';
commit;

--B--
begin transaction
-----t1-----
update TEACHER set PULPIT = '��' where TEACHER='���'
commit;
-----t2-----
rollback

update TEACHER set PULPIT = '����' where TEACHER='���'

---task6---

--A--
set transaction isolation level REPEATABLE READ
begin transaction
select count(*) from TEACHER where PULPIT = '��'
-----t1-----
-----t2-----
select case
when TEACHER='���' then 'insert TEACHER' else ' '
end '���������', TEACHER from TEACHER where  PULPIT = '��'
commit;
--B--
begin transaction
-----t1-----

update TEACHER set PULPIT = '��' where TEACHER='���'
commit;
--insert TEACHER values ('���','׸���� ��� ����������','�','��');
--commit;
-----t2-----
rollback

delete TEACHER where TEACHER = '���'

---task7---

--A--
set transaction isolation level SERIALIZABLE
begin transaction
insert TEACHER values ('���','׸���� ��� ����������','�','��');
update TEACHER set PULPIT = '��' where TEACHER='���'
select count(*) from TEACHER where PULPIT = '��'
-----t1-----
select count(*) from TEACHER where PULPIT = '��'
-----t2-----
commit;

--B--
begin transaction
update TEACHER set PULPIT = '��' where TEACHER='���'
insert TEACHER values ('���','׸���� ��� ����������','�','��');

select count(*) from TEACHER where PULPIT = '��'
-----t1-----
commit;
select count(*) from TEACHER where PULPIT = '��'
-----t2-----

---task8---

delete TEACHER where TEACHER = '���'
update TEACHER set PULPIT = '����' where TEACHER = '������' 

begin tran --�������
insert TEACHER values ('���','������ ���� ��������','�','��');
	begin tran --����������
		update TEACHER set PULPIT = '�����' where TEACHER = '������' 
		commit; --����������
		if @@trancount>0 rollback; --�������
	select
		(select count(*) from TEACHER where PULPIT = '��')'��',
		(select count(*) from TEACHER where PULPIT = '�����')'�����'
