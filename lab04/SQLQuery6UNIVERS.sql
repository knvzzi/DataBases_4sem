USE master;
CREATE database UNIVERS;

------------�������� � ���������� ������� AUDITORIUM_TYPE 
USE UNIVERS;
create table AUDITORIUM_TYPE 
(    AUDITORIUM_TYPE  char(10) constraint AUDITORIUM_TYPE_PK  primary key,  
      AUDITORIUM_TYPENAME  varchar(30)       
 )
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,  AUDITORIUM_TYPENAME )        values ('��',            '����������');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,  AUDITORIUM_TYPENAME )         values ('��-�',          '������������ �����');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME )         values ('��-�',          '���������� � ���. ����������');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,  AUDITORIUM_TYPENAME )          values  ('��-X',          '���������� �����������');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME )        values  ('��-��',   '����. ������������ �����');
                      
create table AUDITORIUM 
(   AUDITORIUM   char(20)  constraint AUDITORIUM_PK  primary key,              
    AUDITORIUM_TYPE     char(10) constraint  AUDITORIUM_AUDITORIUM_TYPE_FK foreign key         
                      references AUDITORIUM_TYPE(AUDITORIUM_TYPE), 
   AUDITORIUM_CAPACITY  integer constraint  AUDITORIUM_CAPACITY_CHECK default 1  check (AUDITORIUM_CAPACITY between 1 and 300),  -- ����������� 
   AUDITORIUM_NAME      varchar(50)                                     
)
insert into  AUDITORIUM   (AUDITORIUM, AUDITORIUM_NAME,  
 AUDITORIUM_TYPE, AUDITORIUM_CAPACITY)   
values  ('206-1', '206-1','��-�', 15);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) 
values  ('301-1',   '301-1', '��-�', 15);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )   
values  ('236-1',   '236-1', '��',   60);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )  
values  ('313-1',   '313-1', '��-�',   60);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )  
values  ('324-1',   '324-1', '��-�',   50);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )   
 values  ('413-1',   '413-1', '��-�', 15);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY ) 
values  ('423-1',   '423-1', '��-�', 90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )     
values  ('408-2',   '408-2', '��',  90);
create table FACULTY
  (    FACULTY      char(100)   constraint  FACULTY_PK primary key,
       FACULTY_NAME  varchar(50) default '???'
  );
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('����',   '������������ ���� � ���������������');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('����',   '���������� ���������� � �������');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('���',     '����������������� ���������');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('���',     '���������-������������� ���������');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('����',    '���������� � ������� ������ ��������������');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('���',     '���������� ������������ �������');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('��',     '��������� �������������� ����������');  
   create table PROFESSION
  (   PROFESSION   char(20) constraint PROFESSION_PK  primary key,
       FACULTY    char(100) constraint PROFESSION_FACULTY_FK foreign key 
                            references FACULTY(FACULTY),
       PROFESSION_NAME varchar(100),    QUALIFICATION   varchar(50)  
  );  
 insert into PROFESSION(FACULTY, PROFESSION, PROFESSION_NAME, QUALIFICATION)    values    ('��',  '1-40 01 02',   '�������������� ������� � �����-�����', '�������-�����������-�������������' );
 insert into PROFESSION(FACULTY, PROFESSION, PROFESSION_NAME, QUALIFICATION)    values    ('��',  '1-47 01 01', '������������ ����', '��������-��������' );
insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)    values    ('��',  '1-36 06 01',  '��������������� ������������ � ������� ��������� ����������', '�������-��������������' );                     
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)  values    ('����',  '1-36 01 08',    '��������������� � ������������ ������� �� �������������� ����������', '�������-�������' );
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)      values    ('����',  '1-36 07 01',  '������ � �������� ���������� ����������� � ����������� ������������ ����������', '�������-�������' );
 insert into PROFESSION(FACULTY, PROFESSION, PROFESSION_NAME, QUALIFICATION)  values    ('���',  '1-75 01 01',      '������ ���������', '������� ���-���� ���������' );
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)   values    ('���',  '1-75 02 01',   '������-�������� �������������', '������� ������-��������� �������������' );
 insert into PROFESSION(FACULTY, PROFESSION,     PROFESSION_NAME, QUALIFICATION)   values    ('���',  '1-89 02 02',     '������ � ���������������-���', '���������� � ����� �������' );
 insert into PROFESSION(FACULTY, PROFESSION, PROFESSION_NAME, QUALIFICATION)  values    ('���',  '1-25 01 07',  '��������� � ���������� �� ����-�������', '���������-��������' );
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)      values    ('���',  '1-25 01 08',    '������������� ����, ������ � �����', '���������' );                      
 insert into PROFESSION(FACULTY, PROFESSION,     PROFESSION_NAME, QUALIFICATION)  values    ('����',  '1-36 05 01',   '������ � ������������ ������� ���������', '�������-�������' );
 insert into PROFESSION(FACULTY, PROFESSION,   PROFESSION_NAME, QUALIFICATION)   values    ('����',  '1-46 01 01',      '�������������� ����', '�������-��������' );
 insert into PROFESSION(FACULTY, PROFESSION,     PROFESSION_NAME, QUALIFICATION)      values    ('���',  '1-48 01 02',  '���������� ���������� ��-���������� �������, ���������� � �������', '�������-�����-��������' );                
 insert into PROFESSION(FACULTY, PROFESSION,   PROFESSION_NAME, QUALIFICATION)    values    ('���',  '1-48 01 05',    '���������� ���������� ��-��������� ���������', '�������-�����-��������' ); 
 insert into PROFESSION(FACULTY, PROFESSION,    PROFESSION_NAME, QUALIFICATION)  values    ('���',  '1-54 01 03',   '������-���������� ������ � ������� �������� �������� ���������', '������� �� ������������' ); 
 create table  PULPIT 
(   PULPIT   char(20)  constraint PULPIT_PK  primary key,
    PULPIT_NAME  varchar(100), 
    FACULTY   char(100)   constraint PULPIT_FACULTY_FK foreign key 
                         references FACULTY(FACULTY) 
);  
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY )
  values  ('����', '�������������� ������ � ���������� ','��'  )
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
    values  ('��', '�����������','���')          
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
   values  ('��', '��������������','���')           
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
  values  ('�����', '���������� � ����������������','���')                
insert into PULPIT   (PULPIT,  PULPIT_NAME, FACULTY)
   values  ('����', '������ ������� � ������������','���') 
insert into PULPIT   (PULPIT,  PULPIT_NAME, FACULTY)
   values  ('���', '������� � ������������������','���')              
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
   values  ('������','������������ �������������� � ������-��������� �����-��������','���')          
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
   values  ('��', '���������� ����', '����')                          
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
   values  ('�����','������ ����� � ���������� �������������','����')  
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
   values  ('���','���������� �������������������� �����������', '����')   
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
values  ('�����','���������� � ������� ������� �� ���������','����')    
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
values  ('��', '������������ �����','���') 
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
 values  ('���','���������� ����������� ���������','���')             
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
 values  ('�������','���������� �������������� ������� � ����� ���������� ���������� ','����') 
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
    values  ('�����','��������� � ��������� ���������� �����������','����')                                               
insert into PULPIT   (PULPIT,    PULPIT_NAME, FACULTY)
values  ('����',    '������������� ������ � ����������','���')   
insert into PULPIT   (PULPIT,    PULPIT_NAME, FACULTY)
  values  ('����',   '����������� � ��������� ������������������','���')   
insert into PULPIT   (PULPIT,    PULPIT_NAME, FACULTY)
   values  ('������', '����������, �������������� �����, ������� � ������', '���')
   create table TEACHER
 (   TEACHER    char(10)  constraint TEACHER_PK  primary key,
     TEACHER_NAME  varchar(100), 
     GENDER     char(1) CHECK (GENDER in ('�', '�')),
     PULPIT   char(20) constraint TEACHER_PULPIT_FK foreign key 
                         references PULPIT(PULPIT) 
 );
insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('����',    '������ �������� �������������', '�',  '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('���',     '����� ��������� ����������', '�', '���');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('���',     '��������� ����� ��������', '�', '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                      values  ('���',     '����� ������� ��������', '�', '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('���',     '����� ������� �������������',  '�', '����');                     
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('���',     '����� ����� �������������',  '�',   '����');                                                                                           
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
             values  ('������',   '���������� ��������� �������������', '�','������');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('���',     '��������� ������� �����������', '�', '������');                       
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('����',   '������� ��������� ����������', '�', '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('����',   '������ ������ ��������', '�', '��');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('����', '������� ������ ����������',  '�',  '������');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('���',     '���������� ������� ��������', '�', '������');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('���',   '������ ������ ���������� ', '�', '��');                      
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('�����',   '��������� �������� ���������', '�', '�����'); 
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       valuecreate table SUBJECT
    (     SUBJECT  char(10) constraint SUBJECT_PK  primary key, 
           SUBJECT_NAME varchar(100) unique,
PULPIT  char(20) constraint SUBJECT_PULPIT_FK foreign key 
                         references PULPIT(PULPIT)   
     )s  ('������',   '���������� �������� ����������', '�', '��'); 
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('�����',   '�������� ������ ����������', '�', '��'); 

 insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('����',   '������� ���������� ������ ������', '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT)
                       values ('��',     '���� ������','����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('���',    '�������������� ����������','����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('����',  '������ �������������� � ����������������', '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('��',     '������������� ������ � ������������ ��������', '��-��');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('���',    '���������������� ������� ����������', '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('����',  '������������� ������ ��������� ����������', '��-��');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('���',     '�������������� �������������� ������', '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('��',      '������������ ��������� ','����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
           values ('�����',   '��������. ������, �������� � �������� �����', '��-����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('���',     '������������ �������������� �������', '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('���',     '����������� ��������. ������������', '������');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT)
                       values ('��',   '���������� ����������', '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
                      values ('��',   '�������������� ����������������','����');  
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
               values ('����', '���������� ������ ���',  '����');                   
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
               values ('���',  '��������-��������������� ����������������', '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('��', '��������� ������������������','����')
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('��', '������������� ������','����')
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('������OO','�������� ������ ������ � ���� � ���. ������.','��')
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('�������','������ ������-��������� � ������������� �����-����',  '������')
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
                       values ('��', '���������� �������� ','��')
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
                       values ('��',    '�����������', '�����') 
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('��',    '������������ �����', '��')   
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
                       values ('���',    '���������� ��������� �������','��������') 
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('���',    '������ ��������� ����','��')
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
                       values ('����',   '���������� � ������������ �������������', '�����') 
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
                       values ('����',   '���������� ���������� �������� ���������� ','�������')
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
values ('���',    '���������� ������������','��������')                                                                                                                                                           
create table GROUPS 
(   IDGROUP  integer  identity(1,1) constraint GROUP_PK  primary key,              
    FACULTY   char(100) constraint  GROUPS_FACULTY_FK foreign key         
                                                         references FACULTY(FACULTY), 
     PROFESSION  char(20) constraint  GROUPS_PROFESSION_FK foreign key         
                                                         references PROFESSION(PROFESSION),
    YEAR_FIRST  smallint  check (YEAR_FIRST<=YEAR(GETDATE())),                  
  )
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values ('����','1-40 01 02', 2013), --1
                ('����','1-40 01 02', 2012),
                ('����','1-40 01 02', 2011),
                ('����','1-40 01 02', 2010),
                ('����','1-47 01 01', 2013),---5 ��
                ('����','1-47 01 01', 2012),
                ('����','1-47 01 01', 2011),
                ('����','1-36 06 01', 2010),-----8 ��
                ('����','1-36 06 01', 2013),
                ('����','1-36 06 01', 2012),
                ('����','1-36 06 01', 2011),
                ('����','1-36 01 08', 2013),---12 ��                                                  
                ('����','1-36 01 08', 2012),
                ('����','1-36 07 01', 2011),
                ('����','1-36 07 01', 2010),
                ('���','1-48 01 02', 2012), ---16 �� 
                ('���','1-48 01 02', 2011),
                ('���','1-48 01 05', 2013),
                ('���','1-54 01 03', 2012),
                ('���','1-75 01 01', 2013),--20 ��      
                ('���','1-75 02 01', 2012),
                ('���','1-75 02 01', 2011),
                ('���','1-89 02 02', 2012),
                ('���','1-89 02 02', 2011),  
                ('����','1-36 05 01', 2013),
                ('����','1-36 05 01', 2012),
                ('����','1-46 01 01', 2012),--27 ��
                ('���','1-25 01 07', 2013), 
                ('���','1-25 01 07', 2012),     
                ('���','1-25 01 07', 2010),
                ('���','1-25 01 08', 2013),
                ('���','1-25 01 08', 2012) ---32 ��       
                          
create table STUDENT 
(    IDSTUDENT   integer  identity(1000,1) constraint STUDENT_PK  primary key,
      IDGROUP   integer  constraint STUDENT_GROUP_FK foreign key         
                      references GROUPS(IDGROUP),        
      NAME   nvarchar(100), 
      BDAY   date,
      STAMP  timestamp,
      INFO     xml,
      FOTO     varbinary
 ) 
insert into STUDENT (IDGROUP,NAME, BDAY)
    values (9, '����� ������� ��������',         '12.07.1994'),
           (9, '������� �������� ����������',    '06.03.1994'),
           (9, '�������� ����� �����������',     '09.11.1994'),
           (9, '������� ����� ���������',        '04.10.1994'),
           (9, '��������� ��������� ����������', '08.01.1994'),
           (10, '������� ������ ���������',       '02.08.1993'),
           (10, '������� ��� ����������',         '07.12.1993'),
           (10, '������� ����� �����������',      '02.12.1993'),
           (11, '������� ������ �����������',     '08.03.1992'),
           (11, '������� ����� �������������',    '02.06.1992'),
           (11, '�������� ����� �����������',     '11.12.1992'),
           (11, '�������� ������� �������������', '11.05.1992'),
           (11, '����������� ������� ��������',   '09.11.1992'),
           (11, '�������� ������� ����������',    '01.11.1992'),
           (12, '�������� ����� ������������',    '08.07.1995'),
           (12, '������ ������� ����������',      '02.11.1995'),
           (12, '������ ��������� �����������',   '07.05.1995'),
           (12, '����� ��������� ���������',      '04.08.1995'),
           (13, '���������� ����� ����������',    '08.11.1994'),
           (13, '�������� ������ ��������',       '02.03.1994'),
(13, '���������� ����� ����������',    '04.06.1994'),
           (13, '��������� ���������� ���������', '09.11.1994'),
           (13, '����� ��������� �������',        '04.07.1994'),
           (14, '����������� ����� ������������', '03.01.1993'),
           (14, '������� ���� ��������',          '12.09.1993'),
           (14, '��������� ������ ��������',      '12.06.1993'),
           (14, '���������� ��������� ����������','09.02.1993'),
           (14, '������� ������ ���������',       '04.07.1993'),
           (15, '������ ������� ���������',       '08.01.1992'),
           (15, '��������� ����� ����������',     '12.05.1992'),
           (15, '�������� ����� ����������',      '08.11.1992'),
           (15, '������� ������� ���������',      '12.03.1992'),
           (16, '�������� ����� �������������',   '10.08.1995'),
           (16, '���������� ������ ��������',     '02.05.1995'),
           (16, '������ ������� �������������',   '08.01.1995'),
           (16, '��������� ��������� ��������',   '11.09.1995'),
           (17, '������ ������� ������������',   '08.01.1994'),
           (17, '������ ������ ����������',      '11.09.1994'),
           (17, '����� ���� �������������',      '06.04.1994'),
           (17, '������� ������ ����������',     '12.08.1994')
insert into STUDENT (IDGROUP,NAME, BDAY)
    values (18, '��������� ��������� ����������','07.11.1993'),
           (18, '������ ������� ����������',     '04.06.1993'),
           (18, '������� ����� ����������',      '10.12.1993'),
           (18, '������� ������ ����������',     '04.07.1993'),
           (18, '������� ����� ���������',       '08.01.1993'),
           (18, '����� ������� ����������',      '02.09.1993'),
           (19, '���� ������ �����������',       '11.12.1995'),
           (19, '������� ���� �������������',    '10.06.1995'),
           (19, '��������� ���� ���������',      '09.08.1995'),
           (19, '����� ����� ���������',         '04.07.1995'),
           (19, '��������� ������ ����������',   '08.03.1995'),
           (19, '����� ����� ��������',          '12.09.1995'),
           (20, '������ ����� ������������',     '08.10.1994'),
           (20, '���������� ����� ����������',   '10.02.1994'),
           (20, '�������� ������� �������������','11.11.1994'),
           (20, '���������� ����� ����������',   '10.02.1994'),
           (20, '����������� ����� ��������',    '12.01.1994'),
           (21, '�������� ������� �������������','11.09.1993'),
           (21, '������ �������� ����������',    '01.12.1993'),
           (21, '���� ������� ����������',       '09.06.1993'),
           (21, '�������� ���������� ����������','05.01.1993'),
           (21, '����������� ����� ����������',  '01.07.1993'),
           (22, '������� ��������� ���������',   '07.04.1992'),
           (22, '������ �������� ���������',     '10.12.1992'),
           (22, '��������� ����� ����������',    '05.05.1992'),
           (22, '���������� ����� ������������', '11.01.1992'),
           (22, '�������� ����� ����������',     '04.06.1992'),
           (23, '����� ����� ����������',        '08.01.1994'),
           (23, '��������� ��������� ���������', '07.02.1994'),
           (23, '������ ������ �����������',     '12.06.1994'),
           (23, '������� ����� ��������',        '03.07.1994'),
           (23, '������ ������ ���������',       '04.07.1994'),
           (24, '������� ��������� ����������',  '08.11.1993'),
           (24, '������ ����� ����������',       '02.04.1993'),
           (24, '������ ���� ��������',          '03.06.1993'),
           (24, '������� ������ ���������',      '05.11.1993'),
           (24, '������ ������ �������������',   '03.07.1993'),
           (25, '��������� ����� ��������',      '08.01.1995'),
           (25, '���������� ��������� ���������','06.09.1995'),
           (25, '�������� ��������� ����������', '08.03.1995'),
           (25, '��������� ����� ��������',      '07.08.1995')
create table PROGRESS
 (  SUBJECT   char(10) constraint PROGRESS_SUBJECT_FK foreign key
references SUBJECT(SUBJECT),                
     IDSTUDENT integer  constraint PROGRESS_IDSTUDENT_FK foreign key         
                      references STUDENT(IDSTUDENT),        
     PDATE    date, 
     NOTE     integer check (NOTE between 1 and 10)
  )
insert into PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE)
    values  ('����', 1005,  '01.10.2013',8),
           ('����', 1006,  '01.10.2013',7),
           ('����', 1007,  '01.10.2013',5),
           ('����', 1008,  '01.10.2013',4)
insert into PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE)
    values   ('����', 1009,  '01.12.2013',5),
           ('����', 1010,  '01.12.2013',9),
           ('����', 1011,  '01.12.2013',5),
           ('����', 1012,  '01.12.2013',4)
insert into PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE)
    values ('��',   1013,  '06.5.2013',4),
           ('��',   1014,  '06.05.2013',7),
           ('��',   1015,  '06.05.2013',7),
           ('��',   1016,  '06.05.2013',9),
           ('��',   1017,  '06.05.2013',5),
           ('��',   1018,  '06.05.2013',6)

SELECT AUDITORIUM.AUDITORIUM_NAME, AUDITORIUM_TYPE.AUDITORIUM_TYPE
From AUDITORIUM inner join AUDITORIUM_TYPE
On AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE

SELECT AUDITORIUM.AUDITORIUM_NAME, AUDITORIUM_TYPE.AUDITORIUM_TYPE, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME
From AUDITORIUM inner join AUDITORIUM_TYPE
On AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE and AUDITORIUM_TYPE.AUDITORIUM_TYPENAME like '%���������%'

SELECT isnull (TEACHER.TEACHER_NAME, '***')[�������������],
PULPIT.PULPIT_NAME
FROM PULPIT left outer join TEACHER
ON PULPIT.PULPIT = TEACHER.PULPIT

SELECT AUDITORIUM.AUDITORIUM_NAME, AUDITORIUM_TYPE.AUDITORIUM_TYPE
From AUDITORIUM cross join AUDITORIUM_TYPE
where AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE

