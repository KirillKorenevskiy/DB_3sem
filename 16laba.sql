---------------------ЗАДАНИЕ 1-------------------------

SELECT TEACHER [УЧИТЕЛЬ],
       TEACHER_NAME [ИМЯ_УЧИТЕЛЯ],
       GENDER [ПОЛ],
       PULPIT [КАФЕДРА]
FROM TEACHER
WHERE PULPIT = 'ИСиТ'
FOR XML PATH('Teachers'), ROOT('Department');


select TEACHER_NAME
from TEACHER join PULPIT 
on TEACHER.PULPIT = PULPIT.PULPIT
where PULPIT.PULPIT = 'ИСиТ' for xml RAW('Кафедра'),
root('Список_преподавателей'), elements;

---------------------ЗАДАНИЕ 2-------------------------

SELECT AUDITORIUM_NAME [АУДИТОРИЯ],
       AUDITORIUM_TYPENAME [ТИП],
       AUDITORIUM_CAPACITY [ВМЕСТИМОСТЬ]
FROM AUDITORIUM
JOIN AUDITORIUM_TYPE ON AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE
WHERE AUDITORIUM_TYPE.AUDITORIUM_TYPE = 'ЛК'
FOR XML AUTO, ROOT('Auditoriums');

---------------------ЗАДАНИЕ 3-------------------------

DECLARE @XMLData XML
SET @XMLData = '<Subjects>
  <Subject>
    <SubjectCode>ОПИ</SubjectCode>
    <SubjectName>ОПППИИИИИ</SubjectName>
    <PulpitCode>ИСиТ</PulpitCode>
  </Subject>
  <Subject>
    <SubjectCode>ВРПО</SubjectCode>
    <SubjectName>ВВВВВВВВРРРРРРППООО</SubjectName>
    <PulpitCode>ИСиТ</PulpitCode>
  </Subject>
  <Subject>
    <SubjectCode>ИБГ</SubjectCode>
    <SubjectName>История бел гос-ти</SubjectName>
    <PulpitCode>ИСиТ</PulpitCode>
  </Subject>
</Subjects>'

DECLARE @hDoc INT
EXEC sp_xml_preparedocument @hDoc OUTPUT, @XMLData

INSERT INTO SUBJECT_T (SUBJECT_T, SUBJECT_NAME, PULPIT)
SELECT SubjectCode, SubjectName, PulpitCode
FROM OPENXML(@hDoc, '/Subjects/Subject', 2)
WITH (
  SubjectCode char(10),
  SubjectName varchar(100),
  PulpitCode char(20)
)
EXEC sp_xml_removedocument @hDoc

SELECT * FROM SUBJECT_T;


---------------------ЗАДАНИЕ 4-------------------------

DECLARE @PassportData XML
SET @PassportData = '<StudentPassport>
  <PassportSeries>AB</PassportSeries>
  <PassportNumber>1234567</PassportNumber>
  <PersonalNumber>987654321</PersonalNumber>
  <IssueDate>2023-12-01</IssueDate>
  <Address>г. Москва, ул. Пушкина, д. 10</Address>
</StudentPassport>'

INSERT INTO STUDENT (IDGROUP, NAME, BDAY, INFO)
VALUES (1, 'Иванов Иван', '2000-01-01', @PassportData)

SELECT * FROM STUDENT;

update STUDENT 
set INFO = '<StudentPassport>
  <PassportSeries>AB</PassportSeries>
  <PassportNumber>1234567</PassportNumber>
  <PersonalNumber>987654321</PersonalNumber>
  <IssueDate>2023-12-01</IssueDate>
  <Address>г. Москва, ул. Ленина, д. 20</Address>
</StudentPassport>' 
where INFO.value('(/StudentPassport/Address)[1]', 'varchar(50)') = 'г. Москва, ул. Пушкина, д. 10';


SELECT 
  IDSTUDENT,
  NAME,
  BDAY,
  INFO.query('/StudentPassport/PassportSeries').value('.', 'nvarchar(10)') AS PassportSeries,
  INFO.query('/StudentPassport/PassportNumber').value('.', 'nvarchar(20)') AS PassportNumber,
  INFO.query('/StudentPassport/PersonalNumber').value('.', 'nvarchar(20)') AS PersonalNumber,
  INFO.query('/StudentPassport/IssueDate').value('.', 'date') AS IssueDate,
  INFO.query('/StudentPassport/Address').value('.', 'nvarchar(100)') AS Address
FROM STUDENT


---------------------ЗАДАНИЕ 5-------------------------


create xml schema collection Student as 
N'<?xml version="1.0" encoding="utf-16" ?>
<xs:schema attributeFormDefault="unqualified" 
           elementFormDefault="qualified"
           xmlns:xs="http://www.w3.org/2001/XMLSchema">
       <xs:element name="студент">  
       <xs:complexType><xs:sequence>
       <xs:element name="паспорт" maxOccurs="1" minOccurs="1">
       <xs:complexType>
       <xs:attribute name="серия" type="xs:string" use="required" />
       <xs:attribute name="номер" type="xs:unsignedInt" use="required"/>
       <xs:attribute name="дата"  use="required" >  
       <xs:simpleType>  <xs:restriction base ="xs:string">
   <xs:pattern value="[0-9]{2}.[0-9]{2}.[0-9]{4}"/>
   </xs:restriction> 	</xs:simpleType>
   </xs:attribute> </xs:complexType> 
   </xs:element>
   <xs:element maxOccurs="3" name="телефон" type="xs:unsignedInt"/>
   <xs:element name="адрес">   <xs:complexType><xs:sequence>
   <xs:element name="страна" type="xs:string" />
   <xs:element name="город" type="xs:string" />
   <xs:element name="улица" type="xs:string" />
   <xs:element name="дом" type="xs:string" />
   <xs:element name="квартира" type="xs:string" />
   </xs:sequence></xs:complexType>  </xs:element>
   </xs:sequence></xs:complexType>
   </xs:element>
</xs:schema>';



drop table STUDENT;

create table STUDENT_T 
(    IDSTUDENT integer  identity(1000,1)  primary key,
      IDGROUP integer  foreign key  references GROUPS(IDGROUP),        
      NAME nvarchar(100), 
      BDAY  date,
      STAMP timestamp,
      INFO   xml(STUDENT),    -- типизированный столбец XML-типа
      FOTO  varbinary
  );

INSERT INTO STUDENT_T (INFO)
VALUES (N'
<студент>
    <паспорт серия="AB" номер="123456" дата="01.01.2023" />
    <телефон>1234567890</телефон>
    <телефон>3753345502</телефон>
    <адрес>
        <страна>Россия</страна>
        <город>Москва</город>
        <улица>Примерная</улица>
        <дом>1</дом>
        <квартира>101</квартира>
    </адрес>
</студент>'
);

select * from STUDENT_T;


