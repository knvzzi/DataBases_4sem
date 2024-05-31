use Kazantseva_MyBase;

---task1--
declare @tv char(20), @t char(300) = '';
declare ZkTovar cursor
	for select Заказы.Наименование_заказанного_товара from Заказы;
open ZkTovar;
fetch ZkTovar into @tv;
print 'Заказанные товары';
while @@FETCH_STATUS=0
	begin
		set @t = rtrim(@tv)+','+@t;
		fetch ZkTovar into @tv;
	end;
	print @t;
close ZkTovar;

---task2---
DECLARE Tovary CURSOR LOCAL                            
	             for SELECT Товары.Наименование_товара, Цена from Товары;
DECLARE @tv1 varchar(20), @cena real;      
	OPEN Tovary;	  
	fetch  Tovary into @tv1, @cena; 	
      print '1. '+@tv1+cast(@cena as varchar(6));   
      go
 DECLARE @tv1 char(20), @cena real;     	
	fetch  Tovary into @tv1, @cena; 	
      print '2. '+@tv1+cast(@cena as varchar(6));  
  go  

DECLARE Tovary CURSOR global
for SELECT Товары.Наименование_товара, Цена from Товары;
DECLARE @tv1 varchar(20), @cena real;      
	OPEN Tovary;	  
	fetch  Tovary into @tv1, @cena; 	
      print '1. '+@tv1+cast(@cena as varchar(6));   
      go
 DECLARE @tv1 char(20), @cena real;     	
	fetch  Tovary into @tv1, @cena; 	
      print '2. '+@tv1+cast(@cena as varchar(6));  
  go  

---task3---
DECLARE @tid char(10), @tnm char(40), @tgn char(10);  
	DECLARE Zakaz CURSOR LOCAL STATIC                              
		 for SELECT Заказы.Наименование_заказанного_товара, Заказы.Номер_заказа ,Заказы.Количество_заказанного_товара
		       FROM dbo.Заказы where Фирма_заказчик= 'Фирма Б';				   
	open Zakaz;
	print   'Количество строк : '+cast(@@CURSOR_ROWS as varchar(5)); 
    	UPDATE Заказы set Количество_заказанного_товара = 12 where Наименование_заказанного_товара = 'Стул';
	DELETE Заказы where Наименование_заказанного_товара = 'Стол';
	INSERT Заказы (Номер_заказа, Фирма_заказчик, Наименование_заказанного_товара,    
                                Количество_заказанного_товара, Дата_поставки, Вид_поставки) 
	                 values (1, 'Фирма А', 'Стол', 8, '2014-08-02', 'Самовывоз'); 
	FETCH  Zakaz into @tid, @tnm, @tgn;     
	while @@fetch_status = 0                                    
      begin 
          print @tid + ' '+ @tnm + ' '+ @tgn;      
          fetch Zakaz into @tid, @tnm, @tgn; 
       end;          
   CLOSE  Zakaz;

DECLARE @tid1 char(10), @tnm1 char(40), @tgn1 char(10);  
	DECLARE Zakaz CURSOR LOCAL dynamic                           
		 for SELECT Заказы.Наименование_заказанного_товара, Заказы.Номер_заказа ,Заказы.Количество_заказанного_товара
		       FROM dbo.Заказы where Фирма_заказчик= 'Фирма Б';				   
	open Zakaz;
	print   'Количество строк : '+cast(@@CURSOR_ROWS as varchar(5)); 
    	UPDATE Заказы set Количество_заказанного_товара = 16 where Наименование_заказанного_товара = 'Стул';
	DELETE Заказы where Наименование_заказанного_товара = 'Стол';
	INSERT Заказы (Номер_заказа, Фирма_заказчик, Наименование_заказанного_товара,    
                                Количество_заказанного_товара, Дата_поставки, Вид_поставки) 
	                 values (1, 'Фирма А', 'Стол', 8, '2014-08-02', 'Самовывоз'); 
	FETCH  Zakaz into @tid1, @tnm1, @tgn1;     
	while @@fetch_status = 0                                    
      begin 
          print @tid1 + ' '+ @tnm1 + ' '+ @tgn1;      
          fetch Zakaz into @tid1, @tnm1, @tgn1; 
       end;          
   CLOSE  Zakaz;

---task4---

DECLARE  @tc int, @rn char(50);  
         DECLARE Primer1 cursor local dynamic SCROLL                               
               for SELECT row_number() over (order by Наименование_заказанного_товара) N,
	                           Наименование_заказанного_товара FROM dbo.Заказы 
                               where Фирма_заказчик = 'Фирма Б' 
	OPEN Primer1;
	FETCH  Primer1 into  @tc, @rn;                 
	print 'следующая строка        : ' + cast(@tc as varchar(3))+ rtrim(@rn);      
	FETCH  LAST from  Primer1 into @tc, @rn;       
	print 'последняя строка          : ' +  cast(@tc as varchar(3))+ rtrim(@rn);      
CLOSE Primer1;

---task5-6---
declare @tn char(20), @tk int;
declare Primer2 cursor local dynamic
	for select Заказы.Наименование_заказанного_товара, Заказы.Количество_заказанного_товара
			   from Заказы for update;
	open Primer2;
	fetch Primer2 into @tn, @tk;
	delete Заказы where current of Primer2;
	fetch Primer2 into @tn, @tk;
	update Заказы set Количество_заказанного_товара = Количество_заказанного_товара+1
	where current of Primer2;
close Primer2
select * from Заказы
