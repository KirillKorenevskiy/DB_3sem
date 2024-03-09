---------------------������� 1-------------------------

SELECT TEACHER [�������],
       TEACHER_NAME [���_�������],
       GENDER [���],
       PULPIT [�������]
FROM TEACHER
WHERE PULPIT = '����'
FOR XML PATH('Teachers'), ROOT('Department');


select TEACHER_NAME
from TEACHER join PULPIT 
on TEACHER.PULPIT = PULPIT.PULPIT
where PULPIT.PULPIT = '����' for xml RAW('�������'),
root('������_��������������'), elements;

---------------------������� 2-------------------------

SELECT AUDITORIUM_NAME [���������],
       AUDITORIUM_TYPENAME [���],
       AUDITORIUM_CAPACITY [�����������]
FROM AUDITORIUM
JOIN AUDITORIUM_TYPE ON AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE
WHERE AUDITORIUM_TYPE.AUDITORIUM_TYPE = '��'
FOR XML AUTO, ROOT('Auditoriums');

---------------------������� 3-------------------------

DECLARE @XMLData XML
SET @XMLData = '<Subjects>
  <Subject>
    <SubjectCode>���</SubjectCode>
    <SubjectName>���������</SubjectName>
    <PulpitCode>����</PulpitCode>
  </Subject>
  <Subject>
    <SubjectCode>����</SubjectCode>
    <SubjectName>�������������������</SubjectName>
    <PulpitCode>����</PulpitCode>
  </Subject>
  <Subject>
    <SubjectCode>���</SubjectCode>
    <SubjectName>������� ��� ���-��</SubjectName>
    <PulpitCode>����</PulpitCode>
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


---------------------������� 4-------------------------

DECLARE @PassportData XML
SET @PassportData = '<StudentPassport>
  <PassportSeries>AB</PassportSeries>
  <PassportNumber>1234567</PassportNumber>
  <PersonalNumber>987654321</PersonalNumber>
  <IssueDate>2023-12-01</IssueDate>
  <Address>�. ������, ��. �������, �. 10</Address>
</StudentPassport>'

INSERT INTO STUDENT (IDGROUP, NAME, BDAY, INFO)
VALUES (1, '������ ����', '2000-01-01', @PassportData)

SELECT * FROM STUDENT;

update STUDENT 
set INFO = '<StudentPassport>
  <PassportSeries>AB</PassportSeries>
  <PassportNumber>1234567</PassportNumber>
  <PersonalNumber>987654321</PersonalNumber>
  <IssueDate>2023-12-01</IssueDate>
  <Address>�. ������, ��. ������, �. 20</Address>
</StudentPassport>' 
where INFO.value('(/StudentPassport/Address)[1]', 'varchar(50)') = '�. ������, ��. �������, �. 10';


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


---------------------������� 5-------------------------


create xml schema collection Student as 
N'<?xml version="1.0" encoding="utf-16" ?>
<xs:schema attributeFormDefault="unqualified" 
           elementFormDefault="qualified"
           xmlns:xs="http://www.w3.org/2001/XMLSchema">
       <xs:element name="�������">  
       <xs:complexType><xs:sequence>
       <xs:element name="�������" maxOccurs="1" minOccurs="1">
       <xs:complexType>
       <xs:attribute name="�����" type="xs:string" use="required" />
       <xs:attribute name="�����" type="xs:unsignedInt" use="required"/>
       <xs:attribute name="����"  use="required" >  
       <xs:simpleType>  <xs:restriction base ="xs:string">
   <xs:pattern value="[0-9]{2}.[0-9]{2}.[0-9]{4}"/>
   </xs:restriction> 	</xs:simpleType>
   </xs:attribute> </xs:complexType> 
   </xs:element>
   <xs:element maxOccurs="3" name="�������" type="xs:unsignedInt"/>
   <xs:element name="�����">   <xs:complexType><xs:sequence>
   <xs:element name="������" type="xs:string" />
   <xs:element name="�����" type="xs:string" />
   <xs:element name="�����" type="xs:string" />
   <xs:element name="���" type="xs:string" />
   <xs:element name="��������" type="xs:string" />
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
      INFO   xml(STUDENT),    -- �������������� ������� XML-����
      FOTO  varbinary
  );

INSERT INTO STUDENT_T (INFO)
VALUES (N'
<�������>
    <������� �����="AB" �����="123456" ����="01.01.2023" />
    <�������>1234567890</�������>
    <�������>3753345502</�������>
    <�����>
        <������>������</������>
        <�����>������</�����>
        <�����>���������</�����>
        <���>1</���>
        <��������>101</��������>
    </�����>
</�������>'
);

select * from STUDENT_T;


