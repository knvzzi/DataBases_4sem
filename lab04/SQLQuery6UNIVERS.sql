USE master;
CREATE database UNIVERS;

------------Создание и заполнение таблицы AUDITORIUM_TYPE 
USE UNIVERS;
create table AUDITORIUM_TYPE 
(    AUDITORIUM_TYPE  char(10) constraint AUDITORIUM_TYPE_PK  primary key,  
      AUDITORIUM_TYPENAME  varchar(30)       
 )
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,  AUDITORIUM_TYPENAME )        values ('ЛК',            'Лекционная');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,  AUDITORIUM_TYPENAME )         values ('ЛБ-К',          'Компьютерный класс');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME )         values ('ЛК-К',          'Лекционная с уст. проектором');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,  AUDITORIUM_TYPENAME )          values  ('ЛБ-X',          'Химическая лаборатория');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME )        values  ('ЛБ-СК',   'Спец. компьютерный класс');
                      
create table AUDITORIUM 
(   AUDITORIUM   char(20)  constraint AUDITORIUM_PK  primary key,              
    AUDITORIUM_TYPE     char(10) constraint  AUDITORIUM_AUDITORIUM_TYPE_FK foreign key         
                      references AUDITORIUM_TYPE(AUDITORIUM_TYPE), 
   AUDITORIUM_CAPACITY  integer constraint  AUDITORIUM_CAPACITY_CHECK default 1  check (AUDITORIUM_CAPACITY between 1 and 300),  -- вместимость 
   AUDITORIUM_NAME      varchar(50)                                     
)
insert into  AUDITORIUM   (AUDITORIUM, AUDITORIUM_NAME,  
 AUDITORIUM_TYPE, AUDITORIUM_CAPACITY)   
values  ('206-1', '206-1','ЛБ-К', 15);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) 
values  ('301-1',   '301-1', 'ЛБ-К', 15);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )   
values  ('236-1',   '236-1', 'ЛК',   60);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )  
values  ('313-1',   '313-1', 'ЛК-К',   60);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )  
values  ('324-1',   '324-1', 'ЛК-К',   50);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )   
 values  ('413-1',   '413-1', 'ЛБ-К', 15);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY ) 
values  ('423-1',   '423-1', 'ЛБ-К', 90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )     
values  ('408-2',   '408-2', 'ЛК',  90);
create table FACULTY
  (    FACULTY      char(100)   constraint  FACULTY_PK primary key,
       FACULTY_NAME  varchar(50) default '???'
  );
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('ИДиП',   'Издательское дело и принттехнологии');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('ХТиТ',   'Химическая технология и техника');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('ЛХФ',     'Лесохозяйственный факультет');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('ИЭФ',     'Инженерно-экономический факультет');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('ТТЛП',    'Технология и техника лесной промышленности');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('ТОВ',     'Технология органических веществ');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('ИТ',     'Факультет информационных технологий');  
   create table PROFESSION
  (   PROFESSION   char(20) constraint PROFESSION_PK  primary key,
       FACULTY    char(100) constraint PROFESSION_FACULTY_FK foreign key 
                            references FACULTY(FACULTY),
       PROFESSION_NAME varchar(100),    QUALIFICATION   varchar(50)  
  );  
 insert into PROFESSION(FACULTY, PROFESSION, PROFESSION_NAME, QUALIFICATION)    values    ('ИТ',  '1-40 01 02',   'Информационные системы и техно-логии', 'инженер-программист-системотехник' );
 insert into PROFESSION(FACULTY, PROFESSION, PROFESSION_NAME, QUALIFICATION)    values    ('ИТ',  '1-47 01 01', 'Издательское дело', 'редактор-технолог' );
insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)    values    ('ИТ',  '1-36 06 01',  'Полиграфическое оборудование и системы обработки информации', 'инженер-электромеханик' );                     
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)  values    ('ХТиТ',  '1-36 01 08',    'Конструирование и производство изделий из композиционных материалов', 'инженер-механик' );
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)      values    ('ХТиТ',  '1-36 07 01',  'Машины и аппараты химических производств и предприятий строительных материалов', 'инженер-механик' );
 insert into PROFESSION(FACULTY, PROFESSION, PROFESSION_NAME, QUALIFICATION)  values    ('ЛХФ',  '1-75 01 01',      'Лесное хозяйство', 'инженер лес-ного хозяйства' );
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)   values    ('ЛХФ',  '1-75 02 01',   'Садово-парковое строительство', 'инженер садово-паркового строительства' );
 insert into PROFESSION(FACULTY, PROFESSION,     PROFESSION_NAME, QUALIFICATION)   values    ('ЛХФ',  '1-89 02 02',     'Туризм и природопользова-ние', 'специалист в сфере туризма' );
 insert into PROFESSION(FACULTY, PROFESSION, PROFESSION_NAME, QUALIFICATION)  values    ('ИЭФ',  '1-25 01 07',  'Экономика и управление на пред-приятии', 'экономист-менеджер' );
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)      values    ('ИЭФ',  '1-25 01 08',    'Бухгалтерский учет, анализ и аудит', 'экономист' );                      
 insert into PROFESSION(FACULTY, PROFESSION,     PROFESSION_NAME, QUALIFICATION)  values    ('ТТЛП',  '1-36 05 01',   'Машины и оборудование лесного комплекса', 'инженер-механик' );
 insert into PROFESSION(FACULTY, PROFESSION,   PROFESSION_NAME, QUALIFICATION)   values    ('ТТЛП',  '1-46 01 01',      'Лесоинженерное дело', 'инженер-технолог' );
 insert into PROFESSION(FACULTY, PROFESSION,     PROFESSION_NAME, QUALIFICATION)      values    ('ТОВ',  '1-48 01 02',  'Химическая технология ор-ганических веществ, материалов и изделий', 'инженер-химик-технолог' );                
 insert into PROFESSION(FACULTY, PROFESSION,   PROFESSION_NAME, QUALIFICATION)    values    ('ТОВ',  '1-48 01 05',    'Химическая технология пе-реработки древесины', 'инженер-химик-технолог' ); 
 insert into PROFESSION(FACULTY, PROFESSION,    PROFESSION_NAME, QUALIFICATION)  values    ('ТОВ',  '1-54 01 03',   'Физико-химические методы и приборы контроля качества продукции', 'инженер по сертификации' ); 
 create table  PULPIT 
(   PULPIT   char(20)  constraint PULPIT_PK  primary key,
    PULPIT_NAME  varchar(100), 
    FACULTY   char(100)   constraint PULPIT_FACULTY_FK foreign key 
                         references FACULTY(FACULTY) 
);  
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY )
  values  ('ИСиТ', 'Информационных систем и технологий ','ИТ'  )
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
    values  ('ЛВ', 'Лесоводства','ЛХФ')          
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
   values  ('ЛУ', 'Лесоустройства','ЛХФ')           
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
  values  ('ЛЗиДВ', 'Лесозащиты и древесиноведения','ЛХФ')                
insert into PULPIT   (PULPIT,  PULPIT_NAME, FACULTY)
   values  ('ЛКиП', 'Лесных культур и почвоведения','ЛХФ') 
insert into PULPIT   (PULPIT,  PULPIT_NAME, FACULTY)
   values  ('ТиП', 'Туризма и природопользования','ЛХФ')              
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
   values  ('ЛПиСПС','Ландшафтного проектирования и садово-паркового строи-тельства','ЛХФ')          
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
   values  ('ТЛ', 'Транспорта леса', 'ТТЛП')                          
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
   values  ('ЛМиЛЗ','Лесных машин и технологии лесозаготовок','ТТЛП')  
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
   values  ('ТДП','Технологий деревообрабатывающих производств', 'ТТЛП')   
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
values  ('ТиДИД','Технологии и дизайна изделий из древесины','ТТЛП')    
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
values  ('ОХ', 'Органической химии','ТОВ') 
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
 values  ('ХПД','Химической переработки древесины','ТОВ')             
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
 values  ('ТНВиОХТ','Технологии неорганических веществ и общей химической технологии ','ХТиТ') 
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
    values  ('ПиАХП','Процессов и аппаратов химических производств','ХТиТ')                                               
insert into PULPIT   (PULPIT,    PULPIT_NAME, FACULTY)
values  ('ЭТиМ',    'Экономической теории и маркетинга','ИЭФ')   
insert into PULPIT   (PULPIT,    PULPIT_NAME, FACULTY)
  values  ('МиЭП',   'Менеджмента и экономики природопользования','ИЭФ')   
insert into PULPIT   (PULPIT,    PULPIT_NAME, FACULTY)
   values  ('СБУАиА', 'Статистики, бухгалтерского учета, анализа и аудита', 'ИЭФ')
   create table TEACHER
 (   TEACHER    char(10)  constraint TEACHER_PK  primary key,
     TEACHER_NAME  varchar(100), 
     GENDER     char(1) CHECK (GENDER in ('м', 'ж')),
     PULPIT   char(20) constraint TEACHER_PULPIT_FK foreign key 
                         references PULPIT(PULPIT) 
 );
insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('СМЛВ',    'Смелов Владимир Владиславович', 'м',  'ИСиТ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('ДТК',     'Дятко Александр Аркадьевич', 'м', 'ИВД');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('УРБ',     'Урбанович Павел Павлович', 'м', 'ИСиТ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                      values  ('ГРН',     'Гурин Николай Иванович', 'м', 'ИСиТ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('ЖЛК',     'Жиляк Надежда Александровна',  'ж', 'ИСиТ');                     
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('МРЗ',     'Мороз Елена Станиславовна',  'ж',   'ИСиТ');                                                                                           
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
             values  ('БРТШВЧ',   'Барташевич Святослав Александрович', 'м','ПОиСОИ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('АРС',     'Арсентьев Виталий Арсентьевич', 'м', 'ПОиСОИ');                       
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('НВРВ',   'Неверов Александр Васильевич', 'м', 'МиЭП');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('РВКЧ',   'Ровкач Андрей Иванович', 'м', 'ЛВ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('ДМДК', 'Демидко Марина Николаевна',  'ж',  'ЛПиСПС');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('БРГ',     'Бурганская Татьяна Минаевна', 'ж', 'ЛПиСПС');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('РЖК',   'Рожков Леонид Николаевич ', 'м', 'ЛВ');                      
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('ЗВГЦВ',   'Звягинцев Вячеслав Борисович', 'м', 'ЛЗиДВ'); 
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       valuecreate table SUBJECT
    (     SUBJECT  char(10) constraint SUBJECT_PK  primary key, 
           SUBJECT_NAME varchar(100) unique,
PULPIT  char(20) constraint SUBJECT_PULPIT_FK foreign key 
                         references PULPIT(PULPIT)   
     )s  ('БЗБРДВ',   'Безбородов Владимир Степанович', 'м', 'ОХ'); 
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('НСКВЦ',   'Насковец Михаил Трофимович', 'м', 'ТЛ'); 

 insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('СУБД',   'Системы управления базами данных', 'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT)
                       values ('БД',     'Базы данных','ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('ИНФ',    'Информационные технологии','ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('ОАиП',  'Основы алгоритмизации и программирования', 'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('ПЗ',     'Представление знаний в компьютерных системах', 'ИС-иТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('ПСП',    'Программирование сетевых приложений', 'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('МСОИ',  'Моделирование систем обработки информации', 'ИС-иТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('ПИС',     'Проектирование информационных систем', 'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('КГ',      'Компьютерная геометрия ','ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
           values ('ПМАПЛ',   'Полиграф. машины, автоматы и поточные линии', 'ПО-иСОИ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('КМС',     'Компьютерные мультимедийные системы', 'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('ОПП',     'Организация полиграф. производства', 'ПОиСОИ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT)
                       values ('ДМ',   'Дискретная математика', 'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
                      values ('МП',   'Математическое программирование','ИСиТ');  
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
               values ('ЛЭВМ', 'Логические основы ЭВМ',  'ИСиТ');                   
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
               values ('ООП',  'Объектно-ориентированное программирование', 'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('ЭП', 'Экономика природопользования','МиЭП')
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('ЭТ', 'Экономическая теория','ЭТиМ')
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('БЛЗиПсOO','Биология лесных зверей и птиц с осн. охотов.','ОВ')
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('ОСПиЛПХ','Основы садово-паркового и лесопаркового хозяй-ства',  'ЛПиСПС')
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
                       values ('ИГ', 'Инженерная геодезия ','ЛУ')
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
                       values ('ЛВ',    'Лесоводство', 'ЛЗиДВ') 
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('ОХ',    'Органическая химия', 'ОХ')   
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
                       values ('ТРИ',    'Технология резиновых изделий','ТНХСиППМ') 
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('ВТЛ',    'Водный транспорт леса','ТЛ')
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
                       values ('ТиОЛ',   'Технология и оборудование лесозаготовок', 'ЛМиЛЗ') 
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
                       values ('ТОПИ',   'Технология обогащения полезных ископаемых ','ТНВиОХТ')
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
values ('ПЭХ',    'Прикладная электрохимия','ХТЭПиМЭЕ')                                                                                                                                                           
create table GROUPS 
(   IDGROUP  integer  identity(1,1) constraint GROUP_PK  primary key,              
    FACULTY   char(100) constraint  GROUPS_FACULTY_FK foreign key         
                                                         references FACULTY(FACULTY), 
     PROFESSION  char(20) constraint  GROUPS_PROFESSION_FK foreign key         
                                                         references PROFESSION(PROFESSION),
    YEAR_FIRST  smallint  check (YEAR_FIRST<=YEAR(GETDATE())),                  
  )
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values ('ИДиП','1-40 01 02', 2013), --1
                ('ИДиП','1-40 01 02', 2012),
                ('ИДиП','1-40 01 02', 2011),
                ('ИДиП','1-40 01 02', 2010),
                ('ИДиП','1-47 01 01', 2013),---5 гр
                ('ИДиП','1-47 01 01', 2012),
                ('ИДиП','1-47 01 01', 2011),
                ('ИДиП','1-36 06 01', 2010),-----8 гр
                ('ИДиП','1-36 06 01', 2013),
                ('ИДиП','1-36 06 01', 2012),
                ('ИДиП','1-36 06 01', 2011),
                ('ХТиТ','1-36 01 08', 2013),---12 гр                                                  
                ('ХТиТ','1-36 01 08', 2012),
                ('ХТиТ','1-36 07 01', 2011),
                ('ХТиТ','1-36 07 01', 2010),
                ('ТОВ','1-48 01 02', 2012), ---16 гр 
                ('ТОВ','1-48 01 02', 2011),
                ('ТОВ','1-48 01 05', 2013),
                ('ТОВ','1-54 01 03', 2012),
                ('ЛХФ','1-75 01 01', 2013),--20 гр      
                ('ЛХФ','1-75 02 01', 2012),
                ('ЛХФ','1-75 02 01', 2011),
                ('ЛХФ','1-89 02 02', 2012),
                ('ЛХФ','1-89 02 02', 2011),  
                ('ТТЛП','1-36 05 01', 2013),
                ('ТТЛП','1-36 05 01', 2012),
                ('ТТЛП','1-46 01 01', 2012),--27 гр
                ('ИЭФ','1-25 01 07', 2013), 
                ('ИЭФ','1-25 01 07', 2012),     
                ('ИЭФ','1-25 01 07', 2010),
                ('ИЭФ','1-25 01 08', 2013),
                ('ИЭФ','1-25 01 08', 2012) ---32 гр       
                          
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
    values (9, 'Силюк Валерия Ивановна',         '12.07.1994'),
           (9, 'Сергель Виолетта Николаевна',    '06.03.1994'),
           (9, 'Добродей Ольга Анатольевна',     '09.11.1994'),
           (9, 'Подоляк Мария Сергеевна',        '04.10.1994'),
           (9, 'Никитенко Екатерина Дмитриевна', '08.01.1994'),
           (10, 'Яцкевич Галина Иосифовна',       '02.08.1993'),
           (10, 'Осадчая Эла Васильевна',         '07.12.1993'),
           (10, 'Акулова Елена Геннадьевна',      '02.12.1993'),
           (11, 'Плешкун Милана Анатольевна',     '08.03.1992'),
           (11, 'Буянова Мария Александровна',    '02.06.1992'),
           (11, 'Харченко Елена Геннадьевна',     '11.12.1992'),
           (11, 'Крученок Евгений Александрович', '11.05.1992'),
           (11, 'Бороховский Виталий Петрович',   '09.11.1992'),
           (11, 'Мацкевич Надежда Валерьевна',    '01.11.1992'),
           (12, 'Логинова Мария Вячеславовна',    '08.07.1995'),
           (12, 'Белько Наталья Николаевна',      '02.11.1995'),
           (12, 'Селило Екатерина Геннадьевна',   '07.05.1995'),
           (12, 'Дрозд Анастасия Андреевна',      '04.08.1995'),
           (13, 'Козловская Елена Евгеньевна',    '08.11.1994'),
           (13, 'Потапнин Кирилл Олегович',       '02.03.1994'),
(13, 'Равковская Ольга Николаевна',    '04.06.1994'),
           (13, 'Ходоронок Александра Вадимовна', '09.11.1994'),
           (13, 'Рамук Владислав Юрьевич',        '04.07.1994'),
           (14, 'Неруганенок Мария Владимировна', '03.01.1993'),
           (14, 'Цыганок Анна Петровна',          '12.09.1993'),
           (14, 'Масилевич Оксана Игоревна',      '12.06.1993'),
           (14, 'Алексиевич Елизавета Викторовна','09.02.1993'),
           (14, 'Ватолин Максим Андреевич',       '04.07.1993'),
           (15, 'Синица Валерия Андреевна',       '08.01.1992'),
           (15, 'Кудряшова Алина Николаевна',     '12.05.1992'),
           (15, 'Мигулина Елена Леонидовна',      '08.11.1992'),
           (15, 'Шпиленя Алексей Сергеевич',      '12.03.1992'),
           (16, 'Астафьев Игорь Александрович',   '10.08.1995'),
           (16, 'Гайтюкевич Андрей Игоревич',     '02.05.1995'),
           (16, 'Рученя Наталья Александровна',   '08.01.1995'),
           (16, 'Тарасевич Анастасия Ивановна',   '11.09.1995'),
           (17, 'Жоглин Николай Владимирович',   '08.01.1994'),
           (17, 'Санько Андрей Дмитриевич',      '11.09.1994'),
           (17, 'Пещур Анна Александровна',      '06.04.1994'),
           (17, 'Бучалис Никита Леонидович',     '12.08.1994')
insert into STUDENT (IDGROUP,NAME, BDAY)
    values (18, 'Лавренчук Владислав Николаевич','07.11.1993'),
           (18, 'Власик Евгения Викторовна',     '04.06.1993'),
           (18, 'Абрамов Денис Дмитриевич',      '10.12.1993'),
           (18, 'Оленчик Сергей Николаевич',     '04.07.1993'),
           (18, 'Савинко Павел Андреевич',       '08.01.1993'),
           (18, 'Бакун Алексей Викторович',      '02.09.1993'),
           (19, 'Бань Сергей Анатольевич',       '11.12.1995'),
           (19, 'Сечейко Илья Александрович',    '10.06.1995'),
           (19, 'Кузмичева Анна Андреевна',      '09.08.1995'),
           (19, 'Бурко Диана Францевна',         '04.07.1995'),
           (19, 'Даниленко Максим Васильевич',   '08.03.1995'),
           (19, 'Зизюк Ольга Олеговна',          '12.09.1995'),
           (20, 'Шарапо Мария Владимировна',     '08.10.1994'),
           (20, 'Касперович Вадим Викторович',   '10.02.1994'),
           (20, 'Чупрыгин Арсений Александрович','11.11.1994'),
           (20, 'Воеводская Ольга Леонидовна',   '10.02.1994'),
           (20, 'Метушевский Денис Игоревич',    '12.01.1994'),
           (21, 'Ловецкая Валерия Александровна','11.09.1993'),
           (21, 'Дворак Антонина Николаевна',    '01.12.1993'),
           (21, 'Щука Татьяна Николаевна',       '09.06.1993'),
           (21, 'Коблинец Александра Евгеньевна','05.01.1993'),
           (21, 'Фомичевская Елена Эрнестовна',  '01.07.1993'),
           (22, 'Бесараб Маргарита Вадимовна',   '07.04.1992'),
           (22, 'Бадуро Виктория Сергеевна',     '10.12.1992'),
           (22, 'Тарасенко Ольга Викторовна',    '05.05.1992'),
           (22, 'Афанасенко Ольга Владимировна', '11.01.1992'),
           (22, 'Чуйкевич Ирина Дмитриевна',     '04.06.1992'),
           (23, 'Брель Алеся Алексеевна',        '08.01.1994'),
           (23, 'Кузнецова Анастасия Андреевна', '07.02.1994'),
           (23, 'Томина Карина Геннадьевна',     '12.06.1994'),
           (23, 'Дуброва Павел Игоревич',        '03.07.1994'),
           (23, 'Шпаков Виктор Андреевич',       '04.07.1994'),
           (24, 'Шнейдер Анастасия Дмитриевна',  '08.11.1993'),
           (24, 'Шыгина Елена Викторовна',       '02.04.1993'),
           (24, 'Клюева Анна Ивановна',          '03.06.1993'),
           (24, 'Доморад Марина Андреевна',      '05.11.1993'),
           (24, 'Линчук Михаил Александрович',   '03.07.1993'),
           (25, 'Васильева Дарья Олеговна',      '08.01.1995'),
           (25, 'Щигельская Екатерина Андреевна','06.09.1995'),
           (25, 'Сазонова Екатерина Дмитриевна', '08.03.1995'),
           (25, 'Бакунович Алина Олеговна',      '07.08.1995')
create table PROGRESS
 (  SUBJECT   char(10) constraint PROGRESS_SUBJECT_FK foreign key
references SUBJECT(SUBJECT),                
     IDSTUDENT integer  constraint PROGRESS_IDSTUDENT_FK foreign key         
                      references STUDENT(IDSTUDENT),        
     PDATE    date, 
     NOTE     integer check (NOTE between 1 and 10)
  )
insert into PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE)
    values  ('ОАиП', 1005,  '01.10.2013',8),
           ('ОАиП', 1006,  '01.10.2013',7),
           ('ОАиП', 1007,  '01.10.2013',5),
           ('ОАиП', 1008,  '01.10.2013',4)
insert into PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE)
    values   ('СУБД', 1009,  '01.12.2013',5),
           ('СУБД', 1010,  '01.12.2013',9),
           ('СУБД', 1011,  '01.12.2013',5),
           ('СУБД', 1012,  '01.12.2013',4)
insert into PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE)
    values ('КГ',   1013,  '06.5.2013',4),
           ('КГ',   1014,  '06.05.2013',7),
           ('КГ',   1015,  '06.05.2013',7),
           ('КГ',   1016,  '06.05.2013',9),
           ('КГ',   1017,  '06.05.2013',5),
           ('КГ',   1018,  '06.05.2013',6)

SELECT AUDITORIUM.AUDITORIUM_NAME, AUDITORIUM_TYPE.AUDITORIUM_TYPE
From AUDITORIUM inner join AUDITORIUM_TYPE
On AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE

SELECT AUDITORIUM.AUDITORIUM_NAME, AUDITORIUM_TYPE.AUDITORIUM_TYPE, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME
From AUDITORIUM inner join AUDITORIUM_TYPE
On AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE and AUDITORIUM_TYPE.AUDITORIUM_TYPENAME like '%компьютер%'

SELECT isnull (TEACHER.TEACHER_NAME, '***')[Преподаватель],
PULPIT.PULPIT_NAME
FROM PULPIT left outer join TEACHER
ON PULPIT.PULPIT = TEACHER.PULPIT

SELECT AUDITORIUM.AUDITORIUM_NAME, AUDITORIUM_TYPE.AUDITORIUM_TYPE
From AUDITORIUM cross join AUDITORIUM_TYPE
where AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE

