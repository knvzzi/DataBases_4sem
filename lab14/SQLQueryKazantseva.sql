use Kazantseva_MyBase

---task1.1---
create function COUNT_zakazy(@f varchar(20)) returns int
as begin declare @rc int=0;
set @rc = (select count(Номер_заказа)
			from Заказы z join Заказчики zk
			on z.Фирма_заказчик = zk.Наименование_фирмы
			where Наименование_фирмы = @f);
return @rc;
end;

go
select Наименование_фирмы, dbo.COUNT_zakazy(Наименование_фирмы) from Заказчики

---task2---
go
create function FZakazy(@tz char(20)) returns char(300)
as
begin
declare @tv char(20)
declare @t varchar(300) = 'Заказанные товары: ';
declare ZkTovar cursor local 
for select Наименование_заказанного_товара from Заказы
	where Фирма_заказчик=@tz;
open ZkTovar;
fetch ZkTovar into @tv;
while @@FETCH_STATUS = 0
begin
	set @t = @t + ', '+rtrim(@tv);
	fetch ZkTovar into @tv;
end;
return @t;
end;

go
select Наименование_фирмы, dbo.FZakazy(Наименование_фирмы) from Заказчики

---task3---
create function FTovCena(@f varchar(50), @p real) returns table
as return
select f.Цена, p.Наименование_заказанного_товара
	from Товары f left outer join Заказы p
	on f.Наименование_товара = p.Наименование_заказанного_товара
	where p.Наименование_заказанного_товара=isnull(@f, p.Наименование_заказанного_товара)
	and
	f.Цена = isnull(@p, f.Цена)

go
select * from dbo.FTovCena(null,null);
select * from dbo.FTovCena('Стол',null);
select * from dbo.FTovCena(null, 15);
select * from dbo.FTovCena('Стол',15);

---task4---
go
create function FKolTov(@p varchar(50)) returns int
as
begin
declare @rc int=(select count(*) from Заказы
where Фирма_заказчик=isnull(@p, Фирма_заказчик));
return @rc;
end;
go

select distinct Фирма_заказчик, dbo.FKolTov(Фирма_заказчик)[Количество заказов] from Заказы
select dbo.FKolTov(NULL)[Всего заказов]