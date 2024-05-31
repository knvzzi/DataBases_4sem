use Kazantseva_MyBase

--- task1 ---

set nocount on
	if  exists (select * from  SYS.OBJECTS        -- таблица X есть?
	            where OBJECT_ID= object_id(N'DBO.X') )	            
	drop table X;           
	declare @c int, @flag char = 'c';           -- commit или rollback?
	SET IMPLICIT_TRANSACTIONS  ON   -- включ. режим неявной транзакции
	CREATE table X(K int );                         -- начало транзакции 
		INSERT X values (1),(2),(3);
		set @c = (select count(*) from X);
		print 'количество строк в таблице X: ' + cast( @c as varchar(2));
		if @flag = 'c'  commit;                   -- завершение транзакции: фиксация 
	          else   rollback;                                 -- завершение транзакции: откат  
      SET IMPLICIT_TRANSACTIONS  OFF   -- выключ. режим неявной транзакции
	
	if  exists (select * from  SYS.OBJECTS       -- таблица X есть?
	            where OBJECT_ID= object_id(N'DBO.X') )
	print 'таблица X есть';  
      else print 'таблицы X нет'

--- task2 ---

begin try
	begin tran 
		delete Товары where Наименование_товара = 'Стол';
		insert Товары values ('Стол', 15, 'Деревнянный');
		insert Товары values ('Телевизор', 500, 'Плазма');
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

--- task3 ---
 
declare @point varchar(32);
begin try
 begin tran
	delete Товары where Наименование_товара = 'Стол';
	set @point = 'p1';
	save tran @point;

	insert Товары values ('Стол', 15, 'Деревнянный');
	set @point = 'p2';
	save tran @point;
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

--- task4 ---

-- A ---
	set transaction isolation level READ UNCOMMITTED 
	begin transaction 
	-------------------------- t1 ------------------
	select @@SPID, 'insert Товары' 'результат', * from Товары 
	                                                                where Наименование_товара = 'Блокнот';
	select @@SPID, 'update Заказы'  'результат',  Наименование_заказанного_товара, 
                      Заказы.Фирма_заказчик from Заказы  where Наименование_заказанного_товара = 'Блокнот';
	commit; 
	-------------------------- t2 -----------------
	--- B --	
	begin transaction 
	select @@SPID
	insert Товары values ('Блокнот', 2, 'А4'); 
	update Заказы set Наименование_заказанного_товара  =  'Блокнот' 
                           where Наименование_заказанного_товара = 'Стол' 
	-------------------------- t1 --------------------
	-------------------------- t2 --------------------
	rollback;

--- task5 ---

-- A ---
set transaction isolation level READ COMMITTED 
	begin transaction 
	select count(*) from Заказы where Наименование_заказанного_товара = 'Стул';
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select  'update Заказы'  'результат', count(*)
	                           from Заказы  where Наименование_заказанного_товара = 'Стул';
	commit; 

	--- B ---	
	begin transaction 	  
	-------------------------- t1 --------------------
          update Заказы set Наименование_заказанного_товара = 'Стул' 
                                       where Наименование_заказанного_товара = 'Стол' 
          commit; 
	-------------------------- t2 --------------------	

--- task6 ---

-- A ---
set transaction isolation level  REPEATABLE READ 
begin transaction 
	select Фирма_заказчик from Заказы where Наименование_заказанного_товара = 'Стул';
-------------------------- t1 ------------------ 
-------------------------- t2 -----------------
	select  case
    when Фирма_заказчик = 'Фирма А' then 'insert  Заказы'  else ' ' 
	end 'результат', Фирма_заказчик from Заказы  where Наименование_заказанного_товара = 'Стул';
	commit; 

--- B ---	
begin transaction 	  
-------------------------- t1 --------------------
    insert Заказы values (12,  'Фирма А',  'Диван',  10,  '01.12.2014',  'Самовывоз');
    commit; 
-------------------------- t2 --------------------

--- task7 ---

-- A ---
set transaction isolation level SERIALIZABLE 
begin transaction 
delete Заказы where Фирма_заказчик = 'Фирма А';  
         insert Заказы values (12,  'Фирма А',  'Диван',  10,  '01.12.2014',  'Самовывоз');
         update Заказы set Фирма_заказчик = 'Фирма А' where Наименование_заказанного_товара = 'Стул';
         select  Фирма_заказчик from Заказы  where Наименование_заказанного_товара = 'Стул';
-------------------------- t1 -----------------
select  Фирма_заказчик from Заказы  where Наименование_заказанного_товара = 'Стул';
-------------------------- t2 ------------------ 
commit; 	

--- B ---	
begin transaction 	  
delete Заказы where Фирма_заказчик = 'Фирма А';  
         insert Заказы values (12,  'Фирма А',  'Диван',  10,  '01.12.2014',  'Самовывоз');
         update Заказы set Фирма_заказчик = 'Фирма А' where Наименование_заказанного_товара = 'Стул';
         select  Фирма_заказчик from Заказы  where Наименование_заказанного_товара = 'Стул';
-------------------------- t1 --------------------
         commit; 
         select  Фирма_заказчик from Заказы  where Наименование_заказанного_товара = 'Стул';
-------------------------- t2 --------------------

--- task8 ---

begin tran
 insert Заказы values (12,  'Фирма А',  'Диван',  10,  '01.12.2014',  'Самовывоз');
 begin tran
	update Товары set Наименование_товара = 'Диван' where Наименование_товара = 'ножницы';
	commit;
	if @@trancount>0 rollback;
 select
	(select count(*) from Заказы where Наименование_заказанного_товара = 'Диван') 'Заказы',
	(select count(*) from Товары where Наименование_товара = 'Диван') 'Товары';

