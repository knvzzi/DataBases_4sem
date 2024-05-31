use Kazantseva_MyBase

---task1.1---
create function COUNT_zakazy(@f varchar(20)) returns int
as begin declare @rc int=0;
set @rc = (select count(�����_������)
			from ������ z join ��������� zk
			on z.�����_�������� = zk.������������_�����
			where ������������_����� = @f);
return @rc;
end;

go
select ������������_�����, dbo.COUNT_zakazy(������������_�����) from ���������

---task2---
go
create function FZakazy(@tz char(20)) returns char(300)
as
begin
declare @tv char(20)
declare @t varchar(300) = '���������� ������: ';
declare ZkTovar cursor local 
for select ������������_�����������_������ from ������
	where �����_��������=@tz;
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
select ������������_�����, dbo.FZakazy(������������_�����) from ���������

---task3---
create function FTovCena(@f varchar(50), @p real) returns table
as return
select f.����, p.������������_�����������_������
	from ������ f left outer join ������ p
	on f.������������_������ = p.������������_�����������_������
	where p.������������_�����������_������=isnull(@f, p.������������_�����������_������)
	and
	f.���� = isnull(@p, f.����)

go
select * from dbo.FTovCena(null,null);
select * from dbo.FTovCena('����',null);
select * from dbo.FTovCena(null, 15);
select * from dbo.FTovCena('����',15);

---task4---
go
create function FKolTov(@p varchar(50)) returns int
as
begin
declare @rc int=(select count(*) from ������
where �����_��������=isnull(@p, �����_��������));
return @rc;
end;
go

select distinct �����_��������, dbo.FKolTov(�����_��������)[���������� �������] from ������
select dbo.FKolTov(NULL)[����� �������]