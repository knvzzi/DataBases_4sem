USE [UNIVER]
GO

/****** Object:  StoredProcedure [dbo].[PSUBJECT]    Script Date: 14.04.2024 01:03:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[PSUBJECT] @p varchar(20) = null, @c int output
as
begin
	declare @n int = (select count(*) from SUBJECT);
	print 'Параметры: @p = ' + @p + ', @c = ' + cast(@c as varchar(3))
	select * from SUBJECT where PULPIT = @p;
	set @c = @@rowcount;
	return @n;
end;
GO


declare @n int = 0, @r int = 0, @p varchar(20);
exec @n = PSUBJECT @p = 'ИСиТ', @c = @r output;
print 'Количество предметов всего = '+ cast(@n as varchar(3));
print 'Количество предметов на кафедре ' +' = '+cast(@r as varchar(3));



