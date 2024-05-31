use UNIVER

---tsak1---
declare ISITCursor cursor for select SUBJECT.SUBJECT from SUBJECT where PULPIT like '����';
declare @subject varchar(50), @subjects char (500) = ' ';

open ISITCursor;
fetch ISITCursor into @subject
print '���������� ������� ����'
while @@FETCH_STATUS = 0
begin
	set @subjects = rtrim(@subject) + ',' + @subjects;
	fetch ISITCursor into @subject 
end;
print @subjects
close ISITCursor
deallocate ISITCursor

---task2---

declare FirstCursor cursor local for select STUDENT.NAME, STUDENT.BDAY from STUDENT

declare @n varchar(50), @d date;
open FirstCursor;
fetch FirstCursor into @n, @d;
print '1.' + @n + ' ' + cast(@d as varchar(50));
go
declare @n varchar(50), @d date;
fetch FirstCursor into @n, @d;
print '2.' + @n + ' ' + cast(@d as varchar(50));
close FirstCursor
deallocate FirstCursor
go

declare SecCursor cursor global for select STUDENT.NAME, STUDENT.BDAY from STUDENT

declare @n varchar(50), @d date;
open SecCursor;
fetch SecCursor into @n, @d;
print '1.' + @n + ' ' + cast(@d as varchar(50));
go
declare @n varchar(50), @d date;
fetch SecCursor into @n, @d;
print '2.' + @n + ' ' + cast(@d as varchar(50));
close SecCursor
deallocate SecCursor
go

---task3---

declare @s varchar(50), @sn varchar(50), @p varchar(50) 
declare StCursor cursor local static for select SUBJECT.SUBJECT, SUBJECT.SUBJECT_NAME, SUBJECT.PULPIT from SUBJECT;

open StCursor 
print '���������� �����: '+ cast(@@CURSOR_ROWS as varchar(5));
update SUBJECT set SUBJECT.SUBJECT = '����' where SUBJECT.SUBJECT = '��';
delete SUBJECT where SUBJECT.SUBJECT='��';
insert SUBJECT(SUBJECT.SUBJECT, SUBJECT.SUBJECT_NAME, SUBJECT.PULPIT) values ('��', '���������� ���', '��');
fetch StCursor into @s, @sn, @p;
while @@FETCH_STATUS = 0
begin
	print @s+' '+@sn+' '+@p;
	fetch StCursor into @s, @sn, @p;
end;
close StCursore;


declare @s1 varchar(50), @sn1 varchar(50), @p1 varchar(50) 
declare StCursor cursor local dynamic for select SUBJECT.SUBJECT, SUBJECT.SUBJECT_NAME, SUBJECT.PULPIT from SUBJECT;

open StCursor 
print '���������� �����: '+ cast(@@CURSOR_ROWS as varchar(5));
update SUBJECT set SUBJECT.SUBJECT = '����' where SUBJECT.SUBJECT = '��';
delete SUBJECT where SUBJECT.SUBJECT='��';
insert SUBJECT(SUBJECT.SUBJECT, SUBJECT.SUBJECT_NAME, SUBJECT.PULPIT) values ('��', '���������� ���ll', '��');
fetch StCursor into @s1, @sn1, @p1;
while @@FETCH_STATUS = 0
begin
	print @s1+' '+@sn1+' '+@p1;
	fetch StCursor into @s1, @sn1, @p1;
end;
close StCursore;

---task4---

declare @first int, @second varchar(50);
declare NewCursor cursor local dynamic SCROLL 
	for select row_number() over(order by SUBJECT.SUBJECT) N, SUBJECT.SUBJECT from SUBJECT where SUBJECT.PULPIT = '����';
open NewCursor;
fetch first from NewCursor into @first,@second;
print '������ ������: ' + cast(@first as varchar(5)) + rtrim(@second);
fetch next from NewCursor into @first, @second;
print '��������� ������: ' + cast(@first as varchar(5)) + rtrim(@second);
fetch prior from NewCursor into @first, @second;
print '���������� ������ �� �������), : ' + cast(@first as varchar(5)) + rtrim(@second);
fetch last from NewCursor into @first,@second;
print '��������� ������: ' + cast(@first as varchar(5)) + rtrim(@second);
fetch absolute 5 from NewCursor into @first,@second;
print '5 ������ �� ������: ' + cast(@first as varchar(5)) + rtrim(@second);
fetch absolute -5 from NewCursor into @first,@second;
print '5 ������ �� �����: ' + cast(@first as varchar(5)) + rtrim(@second);
fetch relative 7 from NewCursor into @first,@second;
print '7 ������ ������ �� �������: ' + cast(@first as varchar(5)) + rtrim(@second);
fetch relative -7 from NewCursor into @first,@second;
print '7 ������ ����� �� �������: ' + cast(@first as varchar(5)) + rtrim(@second);
close NewCursor;

---task6---

select * from PROGRESS
INSERT INTO PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE) values ('��', 1025,  '06.05.2013', 3);
delete PROGRESS where IDSTUDENT = 1025

declare @sub varchar(20), @id varchar(50), @note int;
declare LastCursor cursor local dynamic 
	for select  STUDENT.NAME, PROGRESS.IDSTUDENT, PROGRESS.NOTE from PROGRESS join STUDENT on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT where PROGRESS.NOTE<4 for update;

open LastCursor
fetch LastCursor into @sub, @id, @note;
print @id + ' : ' + @sub + ' ������: '+ cast(@note as varchar(15));
delete PROGRESS where current of LastCursor
close LastCursor

declare @id1 int, @note1 int
declare LasttCursor cursor local dynamic
	for select PROGRESS.IDSTUDENT, PROGRESS.NOTE from PROGRESS where PROGRESS.IDSTUDENT = 1005 for update;

open  LasttCursor
fetch LasttCursor into @id1, @note1;
print 'ID: '+cast(@id1 as varchar(15)) + ' ���� ������: ' + cast(@note1 as varchar(15));
update PROGRESS set NOTE = NOTE+2 where current of LasttCursor;
close LasttCursor
select * from PROGRESS
