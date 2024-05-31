use UNIVER

--TASK 1--

declare @c char='a',
		@vc varchar(4)='БГТУ',
		@dt datetime,
		@tm	time(0),
		@i int,
		@si smallint,
		@ti tinyint,
		@n numeric(12,5);
set @dt=getdate();
set @tm='12:12:12';
set @i=(select sum(NOTE) from PROGRESS);

select @si=12, @ti=3, @n=6.8;

print '@dt = ' + cast(@dt as varchar(10));
print '@tm = ' + cast(@tm as varchar(10));
print '@c = ' + cast(@c as varchar(10));
print '@vc = ' + @vc;

select @i i, @si si, @ti ti, @n n 

--TASK 2--

declare @y1 int = (select cast(sum(AUDITORIUM.AUDITORIUM_CAPACITY) as int) from AUDITORIUM), 
		@y2 real, 
		@y3 numeric(8,3), 
		@y4 real,
		@y5 float
if @y1 > 300
begin
	select @y2 = (select count(*) from AUDITORIUM),
		   @y3 = (select cast(avg(AUDITORIUM.AUDITORIUM_CAPACITY) as numeric(8,3)) from AUDITORIUM)
	set @y4 = (select count(*) from AUDITORIUM where AUDITORIUM.AUDITORIUM_CAPACITY<@y3)
	set @y5 = cast(cast(@y4 as float) / cast(@y2 as float) * 100  as float);
	select @y1 'Общая вместимость', @y2 'Количество аудиторий', @y3 'Средняя вместимость', @y4 'Аудитории с вместимостю меньше средней', @y5 'Процент удиторий с вместимостью меньше средней'
end
else if @y1>200 print 'Общая вместимость от 200 до 300'
else if @y1>100 print 'Общая вместимость от 100 до 200'
else print 'Общая вместимость меньше 100'

--TASK 3--

print 'Число обработанных строк: ' + cast(@@ROWCOUNT as varchar(10));
print 'Версия SQL Server: ' + cast(@@VERSION as varchar(10));
print 'Системный идентификатор процесса, назначенный сервером текущему подключению: ' + cast(@@SPID as varchar(10));
print 'Код последней ошибки: ' + cast(@@ERROR as varchar(10));
print 'Имя сервера: ' + cast(@@SERVERNAME as varchar(10));
print 'Уровень вложенности транзакции: ' + cast(@@TRANCOUNT as varchar(10));
print 'Проверка результата считывания строк результирующего набора: ' + cast(@@FETCH_STATUS as varchar(10));
print 'Уровень вложенности текущей процедуры: ' + cast(@@NESTLEVEL as varchar(10));

--TASK 4--

declare @x int = 3, @t float = 1, @z float;
	if(@t>@x) 
		set @z= cast(power(sin(@t), 2) as varchar(12));
	if(@t<@x)
		set @z = cast((4*(@t+@x)) as varchar(12));
	else
		set @z = cast((1-power(exp(4.96981),(@x-2))) as varchar(12))
	print 'z = '+ cast(@z as varchar(10));

declare @student_name varchar(100) = 'Казанцева Татьяна Игоревна';
	
set @student_name = SUBSTRING(@student_name, 1, charindex(' ', @student_name)) +
					SUBSTRING(@student_name, charindex(' ', @student_name)+ 1, 1) + '.' +
					SUBSTRING(@student_name, charindex(' ', @student_name, charindex(' ', @student_name)+1)+1, 1)+ '.'  ;
print @student_name

declare @date datetime = getdate();
select * , (year(@date)-year(STUDENT.BDAY))[Возраст] from STUDENT where month(STUDENT.BDAY) = month(@date)+1;

select CASE
	when datepart(weekday, PDATE) = 1 then 'Понедельник'
	when datepart(weekday, PDATE) = 2 then 'Вторник'
	when datepart(weekday, PDATE) = 3 then 'Среда'
	when datepart(weekday, PDATE) = 4 then 'Четверг'
	when datepart(weekday, PDATE) = 5 then 'Пятница'
	when datepart(weekday, PDATE) = 6 then 'Суббота'
	when datepart(weekday, PDATE) = 7 then 'Воскресенье'
end [День недели], SUBJECT, PDATE
from PROGRESS where SUBJECT = 'СУБД'

--TASK 5--

declare @col int = (select count(*) from AUDITORIUM)
	if (select count(*) from AUDITORIUM)>20
begin 
	print 'Количество аудиторий больше 20';
	print 'Количество = ' + cast(@col as varchar(10));
end;
	else
begin 
	print 'Количество аудиторий меньше 20';
	print 'Количество = '+ cast(@col as varchar(10));
end;

--TASK 6--

select *
from (select Case when PROGRESS.NOTE between 1 and 5 then 'Оценка ниже 5'
				  when PROGRESS.NOTE between 5 and 7 then 'Оценка от 5 до 7'
				  else 'Оценка выше 7'
	end [Пределы оценок], count(*)[Количество]
from PROGRESS Group by Case
	when PROGRESS.NOTE between 1 and 5 then 'Оценка ниже 5'
	when PROGRESS.NOTE between 5 and 7 then 'Оценка от 5 до 7'
	else 'Оценка выше 7'
	end) as T
		order by Case[Пределы оценок]
			when 'Оценка ниже 5' then 3
			when 'Оценка от 5 до 7' then 2 
			when 'Оценка выше 7' then 1
			else 0
		end

--TASK 7--

create table #TABLE
	(TIND int,
	 TFIELD varchar(100),
	 TNEWIND int
	 );

set nocount on; --не выводить сообщения о вводе строк
declare @ii int = 0;
while @ii<10
	begin
insert #TABLE(TIND,TFIELD,TNEWIND)
	values(floor(30000*rand()),replicate('строка',10),floor(3000*rand()));
if(@ii%100=0)
	print @ii; --вывести сообщение
set @ii = @ii + 1;
end;

select * from #TABLE

--TASK 8--

declare @k int =1
	print @k+1
	print @k+2
RETURN
	print @k+3

--TASK 9--
begin try
	update STUDENT set IDGROUP='student' where IDGROUP=18
end try
begin catch
	print ERROR_NUMBER()
	print ERROR_MESSAGE()
	print ERROR_LINE()
	print ERROR_PROCEDURE()
	print ERROR_SEVERITY()
	print ERROR_STATE()
end catch
select * from STUDENT