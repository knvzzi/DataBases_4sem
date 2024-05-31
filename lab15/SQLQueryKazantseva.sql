use Kazantseva_MyBase
go
create table TR_Tov
(
	ID int identity, --�����
	ST varchar(20) check (ST in('INS', 'DEL', 'UPD')),
	TRN varchar(50), --��� ��������
	C varchar(300) --�����������
)

---task1---
go
create trigger TRIG_Tov_Ins
			on ������ after INSERT
as declare @a1 nvarchar(20), @a2 real, @a3 nvarchar(100), @in varchar(300);
print '�������� �������';
set @a1 = (select [������������_������] from INSERTED);
set @a2 = (select [����] from INSERTED);
set @a3 = (select [��������] from INSERTED);
set @in = cast(@a1 as varchar(20)) + ' '+cast(@a2 as varchar(20))+' '+cast(@a3 as varchar(20));
insert into TR_Tov(ST, TRN, C) values('INS', 'TRIG_Tov_Ins', @in);
return

insert into ������(������������_������, ����, ��������) values ('�������', 12, '��������')
select * from TR_Tov

---task24---
go
create trigger TRIG_Tov  on ������ after INSERT, DELETE, UPDATE  
as declare @a1 nvarchar(20), @a2 real, @a3 nvarchar(100), @in varchar(300);
declare @ins int = (select count(*) from inserted),
              @del int = (select count(*) from deleted); 
if  @ins > 0 and  @del = 0  
begin 
     print '�������: INSERT';
     set @a1 = (select [������������_������] from INSERTED);
	 set @a2 = (select [����] from INSERTED);
	 set @a3 = (select [��������] from INSERTED);
	 set @in = cast(@a1 as varchar(20)) + ' '+cast(@a2 as varchar(20))+' '+cast(@a3 as varchar(20));
	 insert into TR_Tov(ST, TRN, C) values('INS', 'TRIG_Tov', @in);
end; 
else		  	 
if @ins = 0 and  @del > 0  
begin 
print '�������: DELETE';
    set @a1 = (select [������������_������] from deleted);
    set @a2 = (select [����] from deleted);
    set @a3 = (select [��������] from deleted);
    set @in = cast(@a1 as varchar(20)) + ' '+cast(@a2 as varchar(20))+' '+cast(@a3 as varchar(20));
    insert into TR_Tov(ST, TRN, C)  values('DEL', 'TRIG_Tov', @in);
end; 
else	  
if @ins > 0 and  @del > 0  
begin 
    print '�������: UPDATE'; 
    set @a1 = (select [������������_������] from inserted);
    set @a2 = (select [����] from inserted);
    set @a3 = (select [��������] from inserted);
    set @in = cast(@a1 as varchar(20)) + ' '+cast(@a2 as varchar(20))+' '+cast(@a3 as varchar(20));
    set @a1 = (select [������������_������] from deleted);
    set @a2 = (select [����] from deleted);
    set @a3 = (select [��������] from deleted);
    set @in = cast(@a1 as varchar(20)) + ' '+cast(@a2 as varchar(20))+' '+cast(@a3 as varchar(20))+' '+@in;
    insert into TR_Tov(ST, TRN, C)  values('UPD', 'TRIG_Tov', @in); 
end;  
return;  

insert into  ������(������������_������, ����, ��������)
                                    values('�����', 140, 'jfjfjjfjf');                   
delete from ������ where ������������_������ = '�����';        
update ������ set ��������='����������'  where ������������_������ = '�����';                
select * from TR_Tov

---task35---
alter table ������  add constraint ����  check(���� >= 15)
ALTER TABLE ������ DROP CONSTRAINT ����;
go 	
update ������ set ���� = null where ������������_������ = '����';
select * from ������ 

---task46---
go
create trigger AUD_AFTER_UPDA on ������ after UPDATE  
       as print 'AUD_AFTER_UPDATE_A';
return;  
go 
create trigger AUD_AFTER_UPDB on ������ after UPDATE  
       as print 'AUD_AFTER_UPDATE_B';
return;  
go  
create trigger AUD_AFTER_UPDC on ������ after UPDATE  
       as print 'AUD_AFTER_UPDATE_C';
 return;  
go    

select t.name, e.type_desc 
         from sys.triggers  t join  sys.trigger_events e  
                  on t.object_id = e.object_id  
                            where OBJECT_NAME(t.parent_id) = '������' and 
	                                                                        e.type_desc = 'UPDATE' ;  

exec  SP_SETTRIGGERORDER @triggername = 'AUD_AFTER_UPDC', 
	                        @order = 'First', @stmttype = 'UPDATE';

exec  SP_SETTRIGGERORDER @triggername = 'AUD_AFTER_UPDA', 
	                        @order = 'Last', @stmttype = 'UPDATE';

---task58---
go
create trigger Tov_INSTEAD_OF
	on ������ instead of DELETE
	 as raiserror (N'�������� ���������', 10,1);
return;

delete from ������ where ������������_������='����'
select * from ������

---task69---
go	

  create  trigger DDL_PRODAJI on database 
                          for DDL_DATABASE_LEVEL_EVENTS  as   
  declare @t varchar(50) =  EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]', 'varchar(50)')
  declare @t1 varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'varchar(50)');
  declare @t2 varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectType)[1]', 'varchar(50)'); 
  if @t1 = '������' 
  begin
       print '��� �������: '+@t;
       print '��� �������: '+@t1;
       print '��� �������: '+@t2;
       raiserror( N'�������� � �������� ������ ���������', 16, 1);  
       rollback;    
   end;

alter table ������ Drop Column ����;