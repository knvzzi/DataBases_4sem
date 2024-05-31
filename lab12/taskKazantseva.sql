use Kazantseva_MyBase

--- task1 ---

set nocount on
	if  exists (select * from  SYS.OBJECTS        -- ������� X ����?
	            where OBJECT_ID= object_id(N'DBO.X') )	            
	drop table X;           
	declare @c int, @flag char = 'c';           -- commit ��� rollback?
	SET IMPLICIT_TRANSACTIONS  ON   -- �����. ����� ������� ����������
	CREATE table X(K int );                         -- ������ ���������� 
		INSERT X values (1),(2),(3);
		set @c = (select count(*) from X);
		print '���������� ����� � ������� X: ' + cast( @c as varchar(2));
		if @flag = 'c'  commit;                   -- ���������� ����������: �������� 
	          else   rollback;                                 -- ���������� ����������: �����  
      SET IMPLICIT_TRANSACTIONS  OFF   -- ������. ����� ������� ����������
	
	if  exists (select * from  SYS.OBJECTS       -- ������� X ����?
	            where OBJECT_ID= object_id(N'DBO.X') )
	print '������� X ����';  
      else print '������� X ���'

--- task2 ---

begin try
	begin tran 
		delete ������ where ������������_������ = '����';
		insert ������ values ('����', 15, '�����������');
		insert ������ values ('���������', 500, '������');
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

--- task3 ---
 
declare @point varchar(32);
begin try
 begin tran
	delete ������ where ������������_������ = '����';
	set @point = 'p1';
	save tran @point;

	insert ������ values ('����', 15, '�����������');
	set @point = 'p2';
	save tran @point;
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

--- task4 ---

-- A ---
	set transaction isolation level READ UNCOMMITTED 
	begin transaction 
	-------------------------- t1 ------------------
	select @@SPID, 'insert ������' '���������', * from ������ 
	                                                                where ������������_������ = '�������';
	select @@SPID, 'update ������'  '���������',  ������������_�����������_������, 
                      ������.�����_�������� from ������  where ������������_�����������_������ = '�������';
	commit; 
	-------------------------- t2 -----------------
	--- B --	
	begin transaction 
	select @@SPID
	insert ������ values ('�������', 2, '�4'); 
	update ������ set ������������_�����������_������  =  '�������' 
                           where ������������_�����������_������ = '����' 
	-------------------------- t1 --------------------
	-------------------------- t2 --------------------
	rollback;

--- task5 ---

-- A ---
set transaction isolation level READ COMMITTED 
	begin transaction 
	select count(*) from ������ where ������������_�����������_������ = '����';
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select  'update ������'  '���������', count(*)
	                           from ������  where ������������_�����������_������ = '����';
	commit; 

	--- B ---	
	begin transaction 	  
	-------------------------- t1 --------------------
          update ������ set ������������_�����������_������ = '����' 
                                       where ������������_�����������_������ = '����' 
          commit; 
	-------------------------- t2 --------------------	

--- task6 ---

-- A ---
set transaction isolation level  REPEATABLE READ 
begin transaction 
	select �����_�������� from ������ where ������������_�����������_������ = '����';
-------------------------- t1 ------------------ 
-------------------------- t2 -----------------
	select  case
    when �����_�������� = '����� �' then 'insert  ������'  else ' ' 
	end '���������', �����_�������� from ������  where ������������_�����������_������ = '����';
	commit; 

--- B ---	
begin transaction 	  
-------------------------- t1 --------------------
    insert ������ values (12,  '����� �',  '�����',  10,  '01.12.2014',  '���������');
    commit; 
-------------------------- t2 --------------------

--- task7 ---

-- A ---
set transaction isolation level SERIALIZABLE 
begin transaction 
delete ������ where �����_�������� = '����� �';  
         insert ������ values (12,  '����� �',  '�����',  10,  '01.12.2014',  '���������');
         update ������ set �����_�������� = '����� �' where ������������_�����������_������ = '����';
         select  �����_�������� from ������  where ������������_�����������_������ = '����';
-------------------------- t1 -----------------
select  �����_�������� from ������  where ������������_�����������_������ = '����';
-------------------------- t2 ------------------ 
commit; 	

--- B ---	
begin transaction 	  
delete ������ where �����_�������� = '����� �';  
         insert ������ values (12,  '����� �',  '�����',  10,  '01.12.2014',  '���������');
         update ������ set �����_�������� = '����� �' where ������������_�����������_������ = '����';
         select  �����_�������� from ������  where ������������_�����������_������ = '����';
-------------------------- t1 --------------------
         commit; 
         select  �����_�������� from ������  where ������������_�����������_������ = '����';
-------------------------- t2 --------------------

--- task8 ---

begin tran
 insert ������ values (12,  '����� �',  '�����',  10,  '01.12.2014',  '���������');
 begin tran
	update ������ set ������������_������ = '�����' where ������������_������ = '�������';
	commit;
	if @@trancount>0 rollback;
 select
	(select count(*) from ������ where ������������_�����������_������ = '�����') '������',
	(select count(*) from ������ where ������������_������ = '�����') '������';

