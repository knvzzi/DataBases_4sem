use Kazantseva_MyBase

--- task1 ---

go 
create procedure PrZakazy
as
begin
	declare @k int = (select count(*) from Заказы);
	select * from Заказы;
	return @k;
end;
go

declare @k int;
exec @k = PrZakazy;
print 'количecтво заказов: '+ cast(@k as varchar(5));
go

--- task2 ---

alter procedure PrZakazy @p varchar(20), @c int output
as begin
declare @k int = (select count(*) from Заказы);
print 'параметрпы: @p = '+@p+ ', @c = ' + cast(@c as varchar(3));
select * from Заказы where Заказы.Фирма_заказчик = @p;
return @k;
end
go

declare @k int, @r int;
exec @k = PrZakazy @p='Фирма Б', @c = @r output;
print 'количecтво заказов: '+ cast(@k as varchar(5));
go

--- task3 ---

alter procedure PrZakazy @p varchar(20)
as begin
	declare @k int = (select count(*) from Заказы);
	select * from Заказы where Заказы.Фирма_заказчик = @p;
	return @k;
end;

create table #Zk
	(Номер_заказа nvarchar(10) primary key not null,
	 Фирма_заказчик nvarchar(20),
	 Наименование_заказанного_товара nvarchar(20),
	 Дата_поставки date,
	 Вид_поставки nvarchar(25)
)


insert #Zk exec PrZakazy @p = 'Фирма А';
select * from #Zk

--- task4 ---

go
create procedure TovaryInsert 
		@t NVARCHAR(20), @cn real, @kl nvarchar(100)
as declare @rc int = 1;
begin try
	insert into Товары (Наименование_товара,Цена,Описание) values (@t, @cn, @kl);
	return @rc;
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

declare @rc int;
exec @rc = TovaryInsert @t = 'Плед', @cn = 21, @kl = 'Тёплый';
print 'код ошибки: '+ cast(@rc as varchar(5));
go

select * from Товары

drop procedure TovaryInsert
go

--- task5 ---

create procedure Zkz_REPORT  @p CHAR(50)
   as  
   declare @rc int = 0;                            
   begin try    
      declare @tv char(20), @t char(300) = ' ';  
      declare ZkTov CURSOR  for 
      select Наименование_заказанного_товара from Заказы where Фирма_заказчик = @p;
      if not exists (select Наименование_заказанного_товара
                                                          from Заказы where Фирма_заказчик = @p)
            raiserror('ошибка', 11, 1);
       else 
        open ZkTov;	  
    fetch  ZkTov into @tv;   
    print   'Заказанные товары';   
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
        print 'ошибка в параметрах' 
        if error_procedure() is not null   
  print 'имя процедуры : ' + error_procedure();
        return @rc;
   end catch; 

declare @k int;
exec @k = PrZakazy @p='Фирма Б';
print 'количecтво заказов: '+ cast(@k as varchar(5));
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
    insert into Заказы (Номер_заказа, Фирма_заказчик,  
         Наименование_заказанного_товара, Количество_заказанного_товара, Дата_поставки, Вид_поставки)
                                               values (@a, @d, @t, @kll, @dt, @v)
    commit tran; 
    return @rc;           
end try
begin catch 
    print 'номер ошибки  : ' + cast(error_number() as varchar(6));
    print 'сообщение     : ' + error_message();
    print 'уровень       : ' + cast(error_severity()  as varchar(6));
    print 'метка         : ' + cast(error_state()   as varchar(8));
    print 'номер строки  : ' + cast(error_line()  as varchar(8));
    if error_procedure() is not  null   
                     print 'имя процедуры : ' + error_procedure();
     if @@trancount > 0 rollback tran ; 
     return -1;	  
end catch;
go

declare @rc int; 
exec @rc = TovaryInsert_X @a = 20, @t = 'Тумбочка', @cn = 5, @kl = 'Маленькая', @d = 'Фирма А', @kll = 3, @dt = '01.12.2014', @v = 'Самовывоз';
print 'код ошибки=' + cast(@rc as varchar(3));  
go

drop procedure TovaryInsert_X