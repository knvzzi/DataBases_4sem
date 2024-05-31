use Kazantseva_MyBase
go
create table TR_Tov
(
	ID int identity, --номер
	ST varchar(20) check (ST in('INS', 'DEL', 'UPD')),
	TRN varchar(50), --имя триггера
	C varchar(300) --комментарий
)

---task1---
go
create trigger TRIG_Tov_Ins
			on Товары after INSERT
as declare @a1 nvarchar(20), @a2 real, @a3 nvarchar(100), @in varchar(300);
print 'Операция вставки';
set @a1 = (select [Наименование_товара] from INSERTED);
set @a2 = (select [Цена] from INSERTED);
set @a3 = (select [Описание] from INSERTED);
set @in = cast(@a1 as varchar(20)) + ' '+cast(@a2 as varchar(20))+' '+cast(@a3 as varchar(20));
insert into TR_Tov(ST, TRN, C) values('INS', 'TRIG_Tov_Ins', @in);
return

insert into Товары(Наименование_товара, Цена, Описание) values ('Планшет', 12, 'Отличный')
select * from TR_Tov

---task24---
go
create trigger TRIG_Tov  on Товары after INSERT, DELETE, UPDATE  
as declare @a1 nvarchar(20), @a2 real, @a3 nvarchar(100), @in varchar(300);
declare @ins int = (select count(*) from inserted),
              @del int = (select count(*) from deleted); 
if  @ins > 0 and  @del = 0  
begin 
     print 'Событие: INSERT';
     set @a1 = (select [Наименование_товара] from INSERTED);
	 set @a2 = (select [Цена] from INSERTED);
	 set @a3 = (select [Описание] from INSERTED);
	 set @in = cast(@a1 as varchar(20)) + ' '+cast(@a2 as varchar(20))+' '+cast(@a3 as varchar(20));
	 insert into TR_Tov(ST, TRN, C) values('INS', 'TRIG_Tov', @in);
end; 
else		  	 
if @ins = 0 and  @del > 0  
begin 
print 'Событие: DELETE';
    set @a1 = (select [Наименование_товара] from deleted);
    set @a2 = (select [Цена] from deleted);
    set @a3 = (select [Описание] from deleted);
    set @in = cast(@a1 as varchar(20)) + ' '+cast(@a2 as varchar(20))+' '+cast(@a3 as varchar(20));
    insert into TR_Tov(ST, TRN, C)  values('DEL', 'TRIG_Tov', @in);
end; 
else	  
if @ins > 0 and  @del > 0  
begin 
    print 'Событие: UPDATE'; 
    set @a1 = (select [Наименование_товара] from inserted);
    set @a2 = (select [Цена] from inserted);
    set @a3 = (select [Описание] from inserted);
    set @in = cast(@a1 as varchar(20)) + ' '+cast(@a2 as varchar(20))+' '+cast(@a3 as varchar(20));
    set @a1 = (select [Наименование_товара] from deleted);
    set @a2 = (select [Цена] from deleted);
    set @a3 = (select [Описание] from deleted);
    set @in = cast(@a1 as varchar(20)) + ' '+cast(@a2 as varchar(20))+' '+cast(@a3 as varchar(20))+' '+@in;
    insert into TR_Tov(ST, TRN, C)  values('UPD', 'TRIG_Tov', @in); 
end;  
return;  

insert into  Товары(Наименование_товара, Цена, Описание)
                                    values('Стоол', 140, 'jfjfjjfjf');                   
delete from Товары where Наименование_товара = 'Стоол';        
update Товары set Описание='лылвотываы'  where Наименование_товара = 'Стоол';                
select * from TR_Tov

---task35---
alter table Товары  add constraint Цена  check(Цена >= 15)
ALTER TABLE Товары DROP CONSTRAINT Цена;
go 	
update Товары set Цена = null where Наименование_товара = 'Стул';
select * from Товары 

---task46---
go
create trigger AUD_AFTER_UPDA on Товары after UPDATE  
       as print 'AUD_AFTER_UPDATE_A';
return;  
go 
create trigger AUD_AFTER_UPDB on Товары after UPDATE  
       as print 'AUD_AFTER_UPDATE_B';
return;  
go  
create trigger AUD_AFTER_UPDC on Товары after UPDATE  
       as print 'AUD_AFTER_UPDATE_C';
 return;  
go    

select t.name, e.type_desc 
         from sys.triggers  t join  sys.trigger_events e  
                  on t.object_id = e.object_id  
                            where OBJECT_NAME(t.parent_id) = 'Товары' and 
	                                                                        e.type_desc = 'UPDATE' ;  

exec  SP_SETTRIGGERORDER @triggername = 'AUD_AFTER_UPDC', 
	                        @order = 'First', @stmttype = 'UPDATE';

exec  SP_SETTRIGGERORDER @triggername = 'AUD_AFTER_UPDA', 
	                        @order = 'Last', @stmttype = 'UPDATE';

---task58---
go
create trigger Tov_INSTEAD_OF
	on Товары instead of DELETE
	 as raiserror (N'Удаление запрещено', 10,1);
return;

delete from Товары where Наименование_товара='Стол'
select * from Товары

---task69---
go	

  create  trigger DDL_PRODAJI on database 
                          for DDL_DATABASE_LEVEL_EVENTS  as   
  declare @t varchar(50) =  EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]', 'varchar(50)')
  declare @t1 varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'varchar(50)');
  declare @t2 varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectType)[1]', 'varchar(50)'); 
  if @t1 = 'Товары' 
  begin
       print 'Тип события: '+@t;
       print 'Имя объекта: '+@t1;
       print 'Тип объекта: '+@t2;
       raiserror( N'операции с таблицей Товары запрещены', 16, 1);  
       rollback;    
   end;

alter table Товары Drop Column Цена;