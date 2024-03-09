use UNIVER;  

------------�������� � ���������� ������� AUDITORIUM_TYPE 

create table AUDITORIUM_TYPE 
(    AUDITORIUM_TYPE  char(10) constraint AUDITORIUM_TYPE_PK  primary key,  
      AUDITORIUM_TYPENAME  varchar(30)       
 )
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,  AUDITORIUM_TYPENAME )        values ('��',            '����������');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,  AUDITORIUM_TYPENAME )         values ('��-�',          '������������ �����');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME )         values ('��-�',          '���������� � ���. ����������');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,  AUDITORIUM_TYPENAME )          values  ('��-X',          '���������� �����������');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME )        values  ('��-��',   '����. ������������ �����');
                      
-------------�������� � ���������� ������� AUDITORIUM  
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

  ------�������� � ���������� ������� FACULTY
  create table FACULTY
  (    FACULTY      char(10)   constraint  FACULTY_PK primary key,
       FACULTY_NAME  varchar(50) default '???'
  );
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
------�������� � ���������� ������� PROFESSION
   create table PROFESSION
  (   PROFESSION   char(20) constraint PROFESSION_PK  primary key,
       FACULTY    char(10) constraint PROFESSION_FACULTY_FK foreign key 
                            references FACULTY(FACULTY),
       PROFESSION_NAME varchar(100),    QUALIFICATION   varchar(50)  
  );  
 insert into PROFESSION(FACULTY, PROFESSION, PROFESSION_NAME, QUALIFICATION)    values    ('��',  '1-40 01 02',   '�������������� ������� � ����������', '�������-�����������-�������������' );
 insert into PROFESSION(FACULTY, PROFESSION, PROFESSION_NAME, QUALIFICATION)    values    ('��',  '1-47 01 01', '������������ ����', '��������-��������' );
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)    values    ('��',  '1-36 06 01',  '��������������� ������������ � ������� ��������� ����������', '�������-��������������' );                     
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)  values    ('����',  '1-36 01 08',    '��������������� � ������������ ������� �� �������������� ����������', '�������-�������' );
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)      values    ('����',  '1-36 07 01',  '������ � �������� ���������� ����������� � ����������� ������������ ����������', '�������-�������' );
 insert into PROFESSION(FACULTY, PROFESSION, PROFESSION_NAME, QUALIFICATION)  values    ('���',  '1-75 01 01',      '������ ���������', '������� ������� ���������' );
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)   values    ('���',  '1-75 02 01',   '������-�������� �������������', '������� ������-��������� �������������' );
 insert into PROFESSION(FACULTY, PROFESSION,     PROFESSION_NAME, QUALIFICATION)   values    ('���',  '1-89 02 02',     '������ � ������������������', '���������� � ����� �������' );
 insert into PROFESSION(FACULTY, PROFESSION, PROFESSION_NAME, QUALIFICATION)  values    ('���',  '1-25 01 07',  '��������� � ���������� �� �����������', '���������-��������' );
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)      values    ('���',  '1-25 01 08',    '������������� ����, ������ � �����', '���������' );                      
 insert into PROFESSION(FACULTY, PROFESSION,     PROFESSION_NAME, QUALIFICATION)  values    ('����',  '1-36 05 01',   '������ � ������������ ������� ���������', '�������-�������' );
 insert into PROFESSION(FACULTY, PROFESSION,   PROFESSION_NAME, QUALIFICATION)   values    ('����',  '1-46 01 01',      '�������������� ����', '�������-��������' );
 insert into PROFESSION(FACULTY, PROFESSION,     PROFESSION_NAME, QUALIFICATION)      values    ('���',  '1-48 01 02',  '���������� ���������� ������������ �������, ���������� � �������', '�������-�����-��������' );                
 insert into PROFESSION(FACULTY, PROFESSION,   PROFESSION_NAME, QUALIFICATION)    values    ('���',  '1-48 01 05',    '���������� ���������� ����������� ���������', '�������-�����-��������' ); 
 insert into PROFESSION(FACULTY, PROFESSION,    PROFESSION_NAME, QUALIFICATION)  values    ('���',  '1-54 01 03',   '������-���������� ������ � ������� �������� �������� ���������', '������� �� ������������' ); 

------�������� � ���������� ������� PULPIT
  create table  PULPIT 
(   PULPIT   char(20)  constraint PULPIT_PK  primary key,
    PULPIT_NAME  varchar(100), 
    FACULTY   char(10)   constraint PULPIT_FACULTY_FK foreign key 
                         references FACULTY(FACULTY) 
);  
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY )
  values  ('����', '�������������� ������ � ���������� ','��'  );
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
    values  ('��', '�����������','���')      ;    
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
   values  ('��', '��������������','���')  ;         
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
  values  ('�����', '���������� � ����������������','���')   ;             
insert into PULPIT   (PULPIT,  PULPIT_NAME, FACULTY)
   values  ('����', '������ ������� � ������������','���') ;
insert into PULPIT   (PULPIT,  PULPIT_NAME, FACULTY)
   values  ('���', '������� � ������������������','���')         ;     
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
   values  ('������','������������ �������������� � ������-��������� �������������','���')   ;       
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
   values  ('��', '���������� ����', '����')    ;                      
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
   values  ('�����','������ ����� � ���������� �������������','����')  ;
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
   values  ('���','���������� �������������������� �����������', '����')  ; 
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
values  ('�����','���������� � ������� ������� �� ���������','����')   ; 
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
values  ('��', '������������ �����','���') ;
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
 values  ('���','���������� ����������� ���������','���');             
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
 values  ('�������','���������� �������������� ������� � ����� ���������� ���������� ','����') ;
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
    values  ('�����','��������� � ��������� ���������� �����������','����')    ;                                           
insert into PULPIT   (PULPIT,    PULPIT_NAME, FACULTY)
values  ('����',    '������������� ������ � ����������','���') ;  
insert into PULPIT   (PULPIT,    PULPIT_NAME, FACULTY)
  values  ('����',   '����������� � ��������� ������������������','���')   ;
insert into PULPIT   (PULPIT,    PULPIT_NAME, FACULTY)
   values  ('������', '����������, �������������� �����, ������� � ������', '���') ;    
             
------�������� � ���������� ������� TEACHER
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
                       values  ('�����',    '�������� ��������� ��������', '�', '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('�����',    '���������� ������� ����������', '�', '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('�����',    '�������� ������ ��������', '�', '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('���',     '����� ��������� ����������', '�', '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('���',     '��������� ����� ��������', '�', '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                      values  ('���',     '����� ������� ��������', '�', '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('���',     '����� ������� �������������',  '�', '����');                     
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('���',     '����� ����� �������������',  '�',   '����');                                                                                           
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
             values  ('������',   '���������� ��������� �������������', '�','�����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('���',     '��������� ������� �����������', '�', '�����');                       
insert into  TEACHER    (TEACHER,  TEACHER_NAME,GENDER, PULPIT )
                       values  ('������',   '����������� ��������� ��������', '�', '����');
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
                       values  ('������',   '���������� �������� ����������', '�', '��'); 
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('�����',   '�������� ������ ����������', '�', '��'); 

------�������� � ���������� ������� SUBJECT_T
create table SUBJECT_T
    (     SUBJECT_T  char(10) constraint SUBJECT_PK  primary key, 
           SUBJECT_NAME varchar(100) unique,
           PULPIT  char(20) constraint SUBJECT_PULPIT_FK foreign key 
                         references PULPIT(PULPIT)   
     )
 insert into SUBJECT_T   (SUBJECT_T,   SUBJECT_NAME, PULPIT )
                       values ('����',   '������� ���������� ������ ������', '����');
insert into SUBJECT_T   (SUBJECT_T,   SUBJECT_NAME,  PULPIT)
                       values ('��',     '���� ������','����');
insert into SUBJECT_T   (SUBJECT_T,   SUBJECT_NAME,  PULPIT )
                       values ('���',    '�������������� ����������','����');
insert into SUBJECT_T   (SUBJECT_T,   SUBJECT_NAME,  PULPIT )
                       values ('����',  '������ �������������� � ����������������', '����');
insert into SUBJECT_T   (SUBJECT_T,   SUBJECT_NAME,  PULPIT )
                       values ('��',     '������������� ������ � ������������ ��������', '����');
insert into SUBJECT_T   (SUBJECT_T,   SUBJECT_NAME,  PULPIT )
                       values ('���',    '���������������� ������� ����������', '����');
insert into SUBJECT_T   (SUBJECT_T,   SUBJECT_NAME,  PULPIT )
                       values ('����',  '������������� ������ ��������� ����������', '����');
insert into SUBJECT_T   (SUBJECT_T,   SUBJECT_NAME,  PULPIT )
                       values ('���',     '�������������� �������������� ������', '����');
insert into SUBJECT_T   (SUBJECT_T,   SUBJECT_NAME,  PULPIT )
                       values ('��',      '������������ ��������� ','����');
insert into SUBJECT_T   (SUBJECT_T,   SUBJECT_NAME,  PULPIT )
           values ('�����',   '��������. ������, �������� � �������� �����', '�����');
insert into SUBJECT_T   (SUBJECT_T,   SUBJECT_NAME,  PULPIT )
                       values ('���',     '������������ �������������� �������', '����');
insert into SUBJECT_T   (SUBJECT_T,   SUBJECT_NAME, PULPIT )
                       values ('���',     '����������� ��������. ������������', '�����');
insert into SUBJECT_T   (SUBJECT_T,   SUBJECT_NAME, PULPIT)
                       values ('��',   '���������� ����������', '����');
insert into SUBJECT_T   (SUBJECT_T,   SUBJECT_NAME,PULPIT )
                      values ('��',   '�������������� ����������������','����');  
insert into SUBJECT_T   (SUBJECT_T,   SUBJECT_NAME, PULPIT )
               values ('����', '���������� ������ ���',  '����');                   
insert into SUBJECT_T   (SUBJECT_T,   SUBJECT_NAME,PULPIT )
               values ('���',  '��������-��������������� ����������������', '����');
insert into SUBJECT_T   (SUBJECT_T,   SUBJECT_NAME, PULPIT )
                       values ('��', '��������� ������������������','����');
insert into SUBJECT_T   (SUBJECT_T,   SUBJECT_NAME, PULPIT )
                       values ('��', '������������� ������','����');
insert into SUBJECT_T   (SUBJECT_T,   SUBJECT_NAME, PULPIT )
                       values ('������OO','�������� ������ ������ � ���� � ���. ������.','��');
insert into SUBJECT_T   (SUBJECT_T,   SUBJECT_NAME, PULPIT )
                       values ('�������','������ ������-��������� � ������������� ���������',  '������');
insert into SUBJECT_T   (SUBJECT_T,   SUBJECT_NAME,PULPIT )
                       values ('��', '���������� �������� ','��');
insert into SUBJECT_T   (SUBJECT_T,   SUBJECT_NAME,PULPIT )
                       values ('��',    '�����������', '�����') ;
insert into SUBJECT_T   (SUBJECT_T,   SUBJECT_NAME, PULPIT )
                       values ('��',    '������������ �����', '��')   ;
insert into SUBJECT_T   (SUBJECT_T,   SUBJECT_NAME,PULPIT )
                       values ('���',    '���������� ��������� �������','�������') ;
insert into SUBJECT_T   (SUBJECT_T,   SUBJECT_NAME, PULPIT )
                       values ('���',    '������ ��������� ����','��');
insert into SUBJECT_T   (SUBJECT_T,   SUBJECT_NAME,PULPIT )
                       values ('����',   '���������� � ������������ �������������', '�����') ;
insert into SUBJECT_T   (SUBJECT_T,   SUBJECT_NAME,PULPIT )
                       values ('����',   '���������� ���������� �������� ���������� ','�������');
insert into SUBJECT_T   (SUBJECT_T,   SUBJECT_NAME, PULPIT )
                       values ('���',    '���������� ������������','�������') ;                                                                                                                                                          
  
------�������� � ���������� ������� GROUPS
create table GROUPS 
(   IDGROUP  integer  identity(1,1) constraint GROUP_PK  primary key,              
    FACULTY   char(10) constraint  GROUPS_FACULTY_FK foreign key         
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
                ('���','1-25 01 08', 2012); ---32 ��       
                          
------�������� � ���������� ������� STUDENT
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
    values (2, '����� ������� ��������',         '12.07.1994'),
           (2, '������� �������� ����������',    '06.03.1994'),
           (2, '�������� ����� �����������',     '09.11.1994'),
           (2, '������� ����� ���������',        '04.10.1994'),
           (2, '��������� ��������� ����������', '08.01.1994'),
           (3, '������� ������ ���������',       '02.08.1993'),
           (3, '������� ��� ����������',         '07.12.1993'),
           (3, '������� ����� �����������',      '02.12.1993'),
           (4, '������� ������ �����������',     '08.03.1992'),
           (4, '������� ����� �������������',    '02.06.1992'),
           (4, '�������� ����� �����������',     '11.12.1992'),
           (4, '�������� ������� �������������', '11.05.1992'),
           (4, '����������� ������� ��������',   '09.11.1992'),
           (4, '�������� ������� ����������',    '01.11.1992'),
           (5, '�������� ����� ������������',    '08.07.1995'),
           (5, '������ ������� ����������',      '02.11.1995'),
           (5, '������ ��������� �����������',   '07.05.1995'),
           (5, '����� ��������� ���������',      '04.08.1995'),
           (6, '���������� ����� ����������',    '08.11.1994'),
           (6, '�������� ������ ��������',       '02.03.1994'),
           (6, '���������� ����� ����������',    '04.06.1994'),
           (6, '��������� ���������� ���������', '09.11.1994'),
           (6, '����� ��������� �������',        '04.07.1994'),
           (7, '����������� ����� ������������', '03.01.1993'),
           (7, '������� ���� ��������',          '12.09.1993'),
           (7, '��������� ������ ��������',      '12.06.1993'),
           (7, '���������� ��������� ����������','09.02.1993'),
           (7, '������� ������ ���������',       '04.07.1993'),
           (8, '������ ������� ���������',       '08.01.1992'),
           (8, '��������� ����� ����������',     '12.05.1992'),
           (8, '�������� ����� ����������',      '08.11.1992'),
           (8, '������� ������� ���������',      '12.03.1992'),
           (9, '�������� ����� �������������',   '10.08.1995'),
           (9, '���������� ������ ��������',     '02.05.1995'),
           (9, '������ ������� �������������',   '08.01.1995'),
           (9, '��������� ��������� ��������',   '11.09.1995'),
           (10, '������ ������� ������������',   '08.01.1994'),
           (10, '������ ������ ����������',      '11.09.1994'),
           (10, '����� ���� �������������',      '06.04.1994'),
           (10, '������� ������ ����������',     '12.08.1994');
insert into STUDENT (IDGROUP,NAME, BDAY)
    values (11, '��������� ��������� ����������','07.11.1993'),
           (11, '������ ������� ����������',     '04.06.1993'),
           (11, '������� ����� ����������',      '10.12.1993'),
           (11, '������� ������ ����������',     '04.07.1993'),
           (11, '������� ����� ���������',       '08.01.1993'),
           (11, '����� ������� ����������',      '02.09.1993'),
           (12, '���� ������ �����������',       '11.12.1995'),
           (12, '������� ���� �������������',    '10.06.1995'),
           (12, '��������� ���� ���������',      '09.08.1995'),
           (12, '����� ����� ���������',         '04.07.1995'),
           (12, '��������� ������ ����������',   '08.03.1995'),
           (12, '����� ����� ��������',          '12.09.1995'),
           (13, '������ ����� ������������',     '08.10.1994'),
           (13, '���������� ����� ����������',   '10.02.1994'),
           (13, '�������� ������� �������������','11.11.1994'),
           (13, '���������� ����� ����������',   '10.02.1994'),
           (13, '����������� ����� ��������',    '12.01.1994'),
           (14, '�������� ������� �������������','11.09.1993'),
           (14, '������ �������� ����������',    '01.12.1993'),
           (14, '���� ������� ����������',       '09.06.1993'),
           (14, '�������� ���������� ����������','05.01.1993'),
           (14, '����������� ����� ����������',  '01.07.1993'),
           (15, '������� ��������� ���������',   '07.04.1992'),
           (15, '������ �������� ���������',     '10.12.1992'),
           (15, '��������� ����� ����������',    '05.05.1992'),
           (15, '���������� ����� ������������', '11.01.1992'),
           (15, '�������� ����� ����������',     '04.06.1992'),
           (16, '����� ����� ����������',        '08.01.1994'),
           (16, '��������� ��������� ���������', '07.02.1994'),
           (16, '������ ������ �����������',     '12.06.1994'),
           (16, '������� ����� ��������',        '03.07.1994'),
           (16, '������ ������ ���������',       '04.07.1994'),
           (17, '������� ��������� ����������',  '08.11.1993'),
           (17, '������ ����� ����������',       '02.04.1993'),
           (17, '������ ���� ��������',          '03.06.1993'),
           (17, '������� ������ ���������',      '05.11.1993'),
           (17, '������ ������ �������������',   '03.07.1993'),
           (18, '��������� ����� ��������',      '08.01.1995'),
           (18, '���������� ��������� ���������','06.09.1995'),
           (18, '�������� ��������� ����������', '08.03.1995'),
           (18, '��������� ����� ��������',      '07.08.1995');

------�������� � ���������� ������� PROGRESS
create table PROGRESS
 (  SUBJECT_T   char(10) constraint PROGRESS_SUBJECT_FK foreign key
                      references SUBJECT_T(SUBJECT_T),                
     IDSTUDENT integer  constraint PROGRESS_IDSTUDENT_FK foreign key         
                      references STUDENT(IDSTUDENT),        
     PDATE    date, 
     NOTE     integer check (NOTE between 1 and 10)
  )
insert into PROGRESS (SUBJECT_T, IDSTUDENT, PDATE, NOTE)
    values  ('����', 1001,  '01.10.2013',8),
           ('����', 1002,  '01.10.2013',7),
           ('����', 1003,  '01.10.2013',5),
           ('����', 1005,  '01.10.2013',4);
insert into PROGRESS (SUBJECT_T, IDSTUDENT, PDATE, NOTE)
    values   ('����', 1014,  '01.12.2013',5),
           ('����', 1015,  '01.12.2013',9),
           ('����', 1016,  '01.12.2013',5),
           ('����', 1017,  '01.12.2013',4);
insert into PROGRESS (SUBJECT_T, IDSTUDENT, PDATE, NOTE)
    values ('��',   1018,  '06.5.2013',4),
           ('��',   1019,  '06.05.2013',7),
           ('��',   1020,  '06.05.2013',7),
           ('��',   1021,  '06.05.2013',9),
           ('��',   1022,  '06.05.2013',5),
           ('��',   1023,  '06.05.2013',6);


---------------------------������� 1-------------------------

SELECT FACULTY.FACULTY_NAME, PULPIT.PULPIT_NAME
FROM FACULTY, PULPIT
WHERE FACULTY.FACULTY = PULPIT.FACULTY
AND FACULTY.FACULTY IN (
SELECT PROFESSION.FACULTY
FROM PROFESSION
WHERE PROFESSION.PROFESSION_NAME LIKE '%����������%'
or PROFESSION.PROFESSION_NAME LIKE '%����������%'
);

---------------------------������� 2-------------------------

SELECT FACULTY.FACULTY_NAME, PULPIT.PULPIT_NAME
FROM FACULTY JOIN PULPIT 
ON FACULTY.FACULTY = PULPIT.FACULTY
AND FACULTY.FACULTY IN (
SELECT PROFESSION.FACULTY
FROM PROFESSION
WHERE PROFESSION.PROFESSION_NAME LIKE '%����������%'
or PROFESSION.PROFESSION_NAME LIKE '%����������%'
);

---------------------------������� 3-------------------------

SELECT DISTINCT FACULTY.FACULTY_NAME, PULPIT.PULPIT_NAME
FROM FACULTY INNER JOIN PULPIT ON
 FACULTY.FACULTY = PULPIT.FACULTY
 INNER JOIN PROFESSION ON
 PROFESSION.FACULTY = FACULTY.FACULTY
 WHERE(PROFESSION.PROFESSION_NAME LIKE '%����������%'
 or PROFESSION.PROFESSION_NAME LIKE '%����������%')

---------------------------������� 4-------------------------

SELECT AUDITORIUM_TYPE, AUDITORIUM_CAPACITY
FROM AUDITORIUM A
WHERE AUDITORIUM_CAPACITY = (SELECT TOP(1) AUDITORIUM_CAPACITY 
FROM AUDITORIUM AA
WHERE AA.AUDITORIUM_TYPE = A.AUDITORIUM_TYPE
ORDER BY AUDITORIUM_CAPACITY DESC
)
ORDER BY AUDITORIUM_CAPACITY DESC

---------------------------������� 5-------------------------

SELECT FACULTY FROM FACULTY
WHERE NOT EXISTS (SELECT * FROM PULPIT 
WHERE FACULTY.FACULTY = PULPIT.FACULTY)
insert into FACULTY (FACULTY, FACULTY_NAME)
values ('N','NX')
---------------------------������� 6-------------------------

SELECT
(SELECT AVG(NOTE) 
FROM PROGRESS 
WHERE PROGRESS.SUBJECT_T = '����') AS AVG_OAIP,
(SELECT AVG(NOTE) 
FROM PROGRESS 
WHERE PROGRESS.SUBJECT_T = '��') AS AVG_BD,
(SELECT AVG(NOTE) 
FROM PROGRESS 
WHERE PROGRESS.SUBJECT_T = '����') AS AVG_SUBD;

---------------------------������� 7-------------------------

SELECT PROGRESS.IDSTUDENT, PROGRESS.NOTE 
FROM PROGRESS
WHERE NOTE >=ALL (SELECT NOTE FROM PROGRESS);

---------------------------������� 8-------------------------

SELECT PROGRESS.IDSTUDENT, PROGRESS.NOTE 
FROM PROGRESS
WHERE NOTE >=ANY (SELECT NOTE FROM PROGRESS WHERE NOTE >=8);


---------------------------��� ����� ��-----------------------
---------------------------������� 1-------------------------
use KOR3_myBase;

SELECT ������.��������_����_�������, ������.��������_�����_�������
FROM ������, ������, ������_�������
WHERE ������.������_ID = ������_�������.������_ID
AND ������.������_ID = ������_�������.������_ID
AND ������.������_ID IN (
    SELECT ������_�������.������_ID
    FROM ������_�������
    WHERE ������_�������.����� > 50000
);

---------------------------������� 4-------------------------

SELECT ������.��������_����_�������, ������.������
FROM ������
WHERE ������.������ = (SELECT TOP(1) ������.������ FROM ������
WHERE ������.��������_����_������� = ������.��������_����_�������
ORDER BY ������.������ DESC
)
ORDER BY ������.������ DESC;

---------------------------������� 5-------------------------

SELECT ������.��������_����_�������, ������.������
FROM ������
WHERE NOT EXISTS (SELECT * FROM ������_�������
WHERE ������_�������.������_ID = ������.������_ID
)

---------------------------������� 6-------------------------

SELECT
(SELECT AVG(������) 
FROM ������) AS AVG_������,
(SELECT AVG(�����) 
FROM ������_�������) AS AVG_�����

---------------------------������� 7-------------------------

SELECT ������_�������.������_�������_ID, ������_�������.�����
FROM ������_�������
WHERE ������_�������.����� >= ALL (SELECT ����� FROM ������_�������);

---------------------------������� 8-------------------------

SELECT ������_�������.������_�������_ID, ������_�������.�����
FROM ������_�������
WHERE ������_�������.����� >=ANY (SELECT ����� FROM ������_������� WHERE ������_�������.����� > 5000);




----------------------------------������������ ������ 6-----------------------------

---------------------------������� 1,2-------------------------


SELECT A.AUDITORIUM_TYPE, AAT.AUDITORIUM_TYPENAME,
SUM(A.AUDITORIUM_CAPACITY) [���],
AVG(A.AUDITORIUM_CAPACITY) [avg],
COUNT(*) [kolvo],
MAX(A.AUDITORIUM_CAPACITY) [max],
MIN(A.AUDITORIUM_CAPACITY) [min]
FROM AUDITORIUM A JOIN AUDITORIUM_TYPE AAT
ON A.AUDITORIUM_TYPE = AAT.AUDITORIUM_TYPE
GROUP BY A.AUDITORIUM_TYPE, AAT.AUDITORIUM_TYPENAME


---------------------------������� 3-------------------------

SELECT *
FROM (
    SELECT
        CASE
            WHEN P.NOTE BETWEEN 1 AND 4 THEN '�����'
            WHEN P.NOTE BETWEEN 5 AND 7 THEN '������'
            ELSE '�������'
        END AS [������],
        COUNT(*) AS [���-��]
    FROM PROGRESS P
    GROUP BY
        CASE
            WHEN P.NOTE BETWEEN 1 AND 4 THEN '�����'
            WHEN P.NOTE BETWEEN 5 AND 7 THEN '������'
            ELSE '�������'
        END
) AS T
ORDER BY
    CASE [������]
        WHEN '�����' THEN 3
        WHEN '������' THEN 2
        WHEN '�������' THEN 1
        ELSE 0
    END;


---------------------------������� 4,5-------------------------


SELECT
F.FACULTY_NAME AS Faculty,
P.PROFESSION_NAME AS Profession,
ROUND(AVG(CAST(PR.NOTE AS DECIMAL(10, 2))), 2) AS AVGEXam
FROM FACULTY F
INNER JOIN PROFESSION P ON F.FACULTY = P.FACULTY
INNER JOIN GROUPS G ON P.PROFESSION = G.PROFESSION
INNER JOIN STUDENT S ON G.IDGROUP = S.IDGROUP
INNER JOIN PROGRESS PR ON S.IDSTUDENT = PR.IDSTUDENT
WHERE PR.SUBJECT_T IN ('����', '����')
GROUP BY F.FACULTY_NAME, P.PROFESSION_NAME
ORDER BY AVGEXam DESC;


---------------------------������� 6-------------------------

SELECT
P.PROFESSION_NAME AS Profession,
PR.SUBJECT_T AS SUBJ,
ROUND(AVG(CAST(PR.NOTE AS DECIMAL(10, 2))), 2) AS AVGExam
FROM FACULTY F
FULL OUTER JOIN PROFESSION P ON F.FACULTY = P.FACULTY
FULL OUTER JOIN GROUPS G ON P.PROFESSION = G.PROFESSION
FULL OUTER JOIN STUDENT S ON G.IDGROUP = S.IDGROUP
FULL OUTER JOIN PROGRESS PR ON S.IDSTUDENT = PR.IDSTUDENT
WHERE F.FACULTY = '���'
GROUP BY P.PROFESSION_NAME, PR.SUBJECT_T
ORDER BY AVGExam DESC;


---------------------------������� 7-------------------------

SELECT SUBJECT_T AS Discipline, COUNT(*) AS StudentsCount
FROM PROGRESS
WHERE NOTE IN (8, 9)
GROUP BY SUBJECT_T
HAVING COUNT(*) > 0
ORDER BY StudentsCount DESC;


---------------------------��� ����� ��------------------------
---------------------------������� 1,2-------------------------
use KOR3_myBase;

SELECT ������.��������_����_�������, ������_�������.�����,
AVG(������_�������.�����) [avg],
COUNT(*) [kolvo],
MAX(������_�������.�����) [max],
MIN(������_�������.�����) [min]
FROM ������ JOIN ������_�������
ON ������.������_ID = ������_�������.������_ID
GROUP BY ������.��������_����_�������, ������_�������.�����


---------------------------������� 3-------------------------


SELECT *
FROM (
    SELECT
        CASE
            WHEN ������_�������.����� BETWEEN 1000 AND 10000 THEN '�������'
            WHEN ������_�������.����� BETWEEN 10000 AND 250000 THEN '���������'
            ELSE '����� �����'
        END AS [������],
        COUNT(*) AS [���-��]
    FROM ������_�������
    GROUP BY
        CASE
            WHEN ������_�������.����� BETWEEN 1000 AND 10000 THEN '�������'
            WHEN ������_�������.����� BETWEEN 10000 AND 250000 THEN '���������'
            ELSE '����� �����'
        END
) AS T
ORDER BY
    CASE [������]
        WHEN '�����' THEN 3
        WHEN '������' THEN 2
        WHEN '�������' THEN 1
        ELSE 0
    END;


---------------------------������� 4,5-------------------------


SELECT
������.��������_����_������� AS ��������,
������_�������.����� AS �����,
ROUND(AVG(CAST(PR.NOTE AS DECIMAL(10, 2))), 2) AS AVGEXam
FROM FACULTY F
INNER JOIN PROFESSION P ON F.FACULTY = P.FACULTY
INNER JOIN GROUPS G ON P.PROFESSION = G.PROFESSION
INNER JOIN STUDENT S ON G.IDGROUP = S.IDGROUP
INNER JOIN PROGRESS PR ON S.IDSTUDENT = PR.IDSTUDENT
WHERE PR.SUBJECT_T IN ('����', '����')
GROUP BY F.FACULTY_NAME, P.PROFESSION_NAME
ORDER BY AVGEXam DESC;

---------------------------������� 6-------------------------


SELECT
P.PROFESSION_NAME AS Profession,
PR.SUBJECT_T AS SUBJ,
ROUND(AVG(CAST(PR.NOTE AS DECIMAL(10, 2))), 2) AS AVGExam
FROM FACULTY F
FULL OUTER JOIN PROFESSION P ON F.FACULTY = P.FACULTY
FULL OUTER JOIN GROUPS G ON P.PROFESSION = G.PROFESSION
FULL OUTER JOIN STUDENT S ON G.IDGROUP = S.IDGROUP
FULL OUTER JOIN PROGRESS PR ON S.IDSTUDENT = PR.IDSTUDENT
WHERE F.FACULTY = '���'
GROUP BY P.PROFESSION_NAME, PR.SUBJECT_T
ORDER BY AVGExam DESC;


---------------------------������� 7-------------------------


SELECT ������_�������.����� AS �����, COUNT(*) AS Counte
FROM ������_�������
WHERE ����� IN (200000, 500000)
GROUP BY ������_�������.�����
HAVING COUNT(*) > 0
ORDER BY Counte DESC;




----------------------------------������������ ������ 7-----------------------------

use UNIVER;
SELECT F.FACULTY, G.PROFESSION, PR.SUBJECT_T, AVG(PR.NOTE) 
FROM FACULTY F JOIN
GROUPS G ON F.FACULTY=G.FACULTY JOIN
STUDENT S ON S.IDGROUP=G.IDGROUP JOIN
PROGRESS PR ON PR.IDSTUDENT=S.IDSTUDENT
WHERE F.FACULTY ='����'
GROUP BY F.FACULTY, G.PROFESSION, PR.SUBJECT_T


SELECT F.FACULTY, G.PROFESSION, PR.SUBJECT_T, AVG(PR.NOTE) 
FROM FACULTY F JOIN
GROUPS G ON F.FACULTY=G.FACULTY JOIN
STUDENT S ON S.IDGROUP=G.IDGROUP JOIN
PROGRESS PR ON PR.IDSTUDENT=S.IDSTUDENT
WHERE F.FACULTY ='����'
GROUP BY ROLLUP (F.FACULTY, G.PROFESSION, PR.SUBJECT_T)


SELECT F.FACULTY, G.PROFESSION, PR.SUBJECT_T, AVG(PR.NOTE) 
FROM FACULTY F JOIN
GROUPS G ON F.FACULTY=G.FACULTY JOIN
STUDENT S ON S.IDGROUP=G.IDGROUP JOIN
PROGRESS PR ON PR.IDSTUDENT=S.IDSTUDENT
WHERE F.FACULTY ='����'
GROUP BY CUBE (F.FACULTY, G.PROFESSION, PR.SUBJECT_T)


(SELECT p.PROFESSION_NAME, p.QUALIFICATION, d.SUBJECT_NAME, AVG(pr.NOTE) AS AVERAGE_GRADE
FROM GROUPS g
JOIN STUDENT s ON g.IDGROUP = s.IDGROUP
JOIN PROGRESS pr ON s.IDSTUDENT = pr.IDSTUDENT
JOIN SUBJECT_T d ON pr.SUBJECT_T = d.SUBJECT_T
JOIN PROFESSION p ON p.PROFESSION = g.PROFESSION
WHERE p.FACULTY = '���'
GROUP BY p.PROFESSION_NAME, p.QUALIFICATION, d.SUBJECT_NAME)
UNION --INTERSECT --EXCEPT
(SELECT p.PROFESSION_NAME, p.QUALIFICATION, d.SUBJECT_NAME, AVG(pr.NOTE) AS AVERAGE_GRADE
FROM GROUPS g
JOIN STUDENT s ON g.IDGROUP = s.IDGROUP
JOIN PROGRESS pr ON s.IDSTUDENT = pr.IDSTUDENT
JOIN SUBJECT_T d ON pr.SUBJECT_T = d.SUBJECT_T
JOIN PROFESSION p ON p.PROFESSION = g.PROFESSION
WHERE p.FACULTY = '����'
GROUP BY p.PROFESSION_NAME, p.QUALIFICATION, d.SUBJECT_NAME);


---------------------------��� ����� ��------------------------

use KOR3_myBase;

SELECT ��������_����_�������, ��������_�����_�������, SUM(�����) AS �����_�����
FROM ������_�������
JOIN ������ ON ������_�������.������_ID = ������.������_ID
JOIN ������ ON ������_�������.������_ID = ������.������_ID
GROUP BY ROLLUP (��������_����_�������, ��������_�����_�������);


SELECT ��������_����_�������, ��������_�����_�������, SUM(�����) AS �����_�����
FROM ������_�������
JOIN ������ ON ������_�������.������_ID = ������.������_ID
JOIN ������ ON ������_�������.������_ID = ������.������_ID
GROUP BY CUBE (��������_����_�������, ��������_�����_�������);


SELECT ������_ID, ������_ID, SUM(�����) AS �����_�����
FROM ������_�������
GROUP BY CUBE (������_ID, ������_ID);



----------------------------------������������ ������ 9-----------------------------











