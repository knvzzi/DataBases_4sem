use Kazantseva_MyBase

--- task1 ---

go 
create procedure PrZakazy
as
begin
	declare @k int = (select count(*) from ������);
	select * from ������;
	return @k;
end;
go

declare @k int;
exec @k = PrZakazy;
print '�����ec��� �������: '+ cast(@k as varchar(5));
go

--- task2 ---

alter procedure PrZakazy @p varchar(20), @c int output
as begin
declare @k int = (select count(*) from ������);
print '����������: @p = '+@p+ ', @c = ' + cast(@c as varchar(3));
select * from ������ where ������.�����_�������� = @p;
return @k;
end
go

declare @k int, @r int;
exec @k = PrZakazy @p='����� �', @c = @r output;
print '�����ec��� �������: '+ cast(@k as varchar(5));
go

--- task3 ---

alter procedure PrZakazy @p varchar(20)
as begin
	declare @k int = (select count(*) from ������);
	select * from ������ where ������.�����_�������� = @p;
	return @k;
end;

create table #Zk
	(�����_������ nvarchar(10) primary key not null,
	 �����_�������� nvarchar(20),
	 ������������_�����������_������ nvarchar(20),
	 ����_�������� date,
	 ���_�������� nvarchar(25)
)


insert #Zk exec PrZakazy @p = '����� �';
select * from #Zk

--- task4 ---

go
create procedure TovaryInsert 
		@t NVARCHAR(20), @cn real, @kl nvarchar(100)
as declare @rc int = 1;
begin try
	insert into ������ (������������_������,����,��������) values (@t, @cn, @kl);
	return @rc;
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

declare @rc int;
exec @rc = TovaryInsert @t = '����', @cn = 21, @kl = 'Ҹ����';
print '��� ������: '+ cast(@rc as varchar(5));
go

select * from ������

drop procedure TovaryInsert
go

--- task5 ---

create procedure Zkz_REPORT  @p CHAR(50)
   as  
   declare @rc int = 0;                            
   begin try    
      declare @tv char(20), @t char(300) = ' ';  
      declare ZkTov CURSOR  for 
      select ������������_�����������_������ from ������ where �����_�������� = @p;
      if not exists (select ������������_�����������_������
                                                          from ������ where �����_�������� = @p)
            raiserror('������', 11, 1);
       else 
        open ZkTov;	  
    fetch  ZkTov into @tv;   
    print   '���������� ������';   
    while @@fetch_status = 0                                     
    begin 
	set @t = rtrim(@tv) + ', ' + @t;  
         set @rc = @rc + 1;       
         fetch  ZkTov into @tv; 
     end;   
print @t;        
close  ZkTov;
    return @rc;
   end try  
   begin catch              
        print '������ � ����������' 
        if error_procedure() is not null   
  print '��� ��������� : ' + error_procedure();
        return @rc;
   end catch; 

declare @k int;
exec @k = PrZakazy @p='����� �';
print '�����ec��� �������: '+ cast(@k as varchar(5));
go

--- task6 ---

go
create procedure TovaryInsert_X
     @a nvarchar(10), @t NVARCHAR(20), @cn real, @kl nvarchar(100), @d nvarchar(20), @kll int, @dt date, @v nvarchar(25)
as  declare @rc int=1;                            
begin try 
    set transaction isolation level SERIALIZABLE;          
    begin tran
	exec @rc=TovaryInsert @t, @cn, @kl;  
    insert into ������ (�����_������, �����_��������,  
         ������������_�����������_������, ����������_�����������_������, ����_��������, ���_��������)
                                               values (@a, @d, @t, @kll, @dt, @v)
    commit tran; 
    return @rc;           
end try
begin catch 
    print '����� ������  : ' + cast(error_number() as varchar(6));
    print '���������     : ' + error_message();
    print '�������       : ' + cast(error_severity()  as varchar(6));
    print '�����         : ' + cast(error_state()   as varchar(8));
    print '����� ������  : ' + cast(error_line()  as varchar(8));
    if error_procedure() is not  null   
                     print '��� ��������� : ' + error_procedure();
     if @@trancount > 0 rollback tran ; 
     return -1;	  
end catch;
go

declare @rc int; 
exec @rc = TovaryInsert_X @a = 20, @t = '��������', @cn = 5, @kl = '���������', @d = '����� �', @kll = 3, @dt = '01.12.2014', @v = '���������';
print '��� ������=' + cast(@rc as varchar(3));  
go

drop procedure TovaryInsert_X