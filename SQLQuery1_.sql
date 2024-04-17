CREATE DATABASE HOSPITAL;
GO

USE HOSPITAL;
GO

CREATE TABLE DEpartments (
    Id INT PRIMARY KEY IDENTITY,
    Building INT NOT NULL CHECK (Building BETWEEN 1 AND 5),
    Financing MONEY NOT NULL DEFAULT 0,
    Floor INT NOT NULL CHECK (Floor >= 1),
    Name NVARCHAR(100) NOT NULL UNIQUE
);
GO

CREATE TABLE DIseases (
    Id INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(100) NOT NULL UNIQUE,
    Severity INT NOT NULL DEFAULT 1 CHECK (Severity >= 1)
);
GO

CREATE TABLE DOctors (
    Id INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(MAX) NOT NULL,
    Phone CHAR(10) NULL,
    Premium MONEY NOT NULL DEFAULT 0 CHECK (Premium >= 0),
    Salary MONEY NOT NULL CHECK (Salary > 0),
    Surname NVARCHAR(MAX) NOT NULL
);
GO

CREATE TABLE EXaminations (
    Id INT PRIMARY KEY IDENTITY,
    DayOfWeek INT NOT NULL CHECK (DayOfWeek BETWEEN 1 AND 7),
    EndTime TIME NOT NULL,
    Name NVARCHAR(100) NOT NULL UNIQUE,
    StartTime TIME NOT NULL CHECK (StartTime >= '08:00' AND StartTime <= '18:00')
);
GO

CREATE TABLE WArds (
    Id INT PRIMARY KEY IDENTITY,
    Building INT NOT NULL CHECK (Building BETWEEN 1 AND 5),
    Floor INT NOT NULL CHECK (Floor >= 1),
    Name NVARCHAR(20) NOT NULL UNIQUE
);
GO

INSERT INTO DEpartments (Building, Financing, Floor, Name)
VALUES 
    (1, 10000.00, 1, '�������'),
    (2, 15000.00, 2, '������'),
    (3, 12000.00, 1, 'ճ�����'),
    (4, 20000.00, 3, '���������'),
    (5, 18000.00, 2, '��������');
GO

INSERT INTO DIseases (Name, Severity)
VALUES 
    ('����', 2),
    ('�����', 3),
    ('��������', 4),
    ('�������', 2),
    ('�����', 3);
GO

INSERT INTO DOctors (Name, Phone, Premium, Salary, Surname)
VALUES 
    ('����', '1234567890', 5000.00, 20000.00, '������'),
    ('����', '0987654321', 3000.00, 18000.00, '�������'),
    ('���������', '9876543210', 6000.00, 25000.00, '�������'),
    ('�����', '0123456789', 4000.00, 22000.00, '���������'),
    ('�����', NULL, 3500.00, 19000.00, '��������');
GO

INSERT INTO EXaminations (DayOfWeek, EndTime, Name, StartTime)
VALUES 
    (1, '12:00', '������������', '10:00'),
    (3, '14:00', '���', '12:00'),
    (5, '16:00', '���', '14:00'),
    (2, '11:00', '����� ����', '09:00'),
    (4, '15:00', '�������', '13:00');
GO

INSERT INTO WArds (Building, Floor, Name)
VALUES 
    (1, 1, '101'),
    (2, 2, '202'),
    (3, 1, '301'),
    (4, 3, '403'),
    (5, 2, '502');
GO

--1. ������� ���������� ������� �����.
SELECT *
FROM WArds

--2. ������� ������� � �������� ���� ������.
SELECT Surname, Phone
FROM DOctors

--3. ������� ��� ����� ��� ����������, �� ������� ������������� ������.
SELECT DISTINCT Floor
FROM WArds

--4. ������� �������� ����������� ��� ������ �Name of Disease� � ������� �� ������� ��� ������ �Severity of Disease�.
SELECT Name AS 'Name of Disease', Severity AS 'Severity of Disease'
FROM DIseases

--5. ������������ ��������� FROM ��� ����� ���� ������ ���� ������, ��������� ��� ��� ����������.
SELECT *
FROM DEpartments AS D, 
DIseases AS Ds,
DOctors AS Drs

--6. ������� �������� ���������, ������������� � ������� 5 � ������� ���� �������������� ����� 30000.
SELECT Name
FROM DEpartments
WHERE Building = 5 AND Financing < 30000

--7. ������� �������� ���������, ������������� � 3-� ������� � ������ �������������� � ��������� �� 12000 �� 15000.
SELECT Name
FROM DEpartments
WHERE Building = 3 AND Financing BETWEEN 12000 AND 15000

--8. ������� �������� �����, ������������� � �������� 4 � 5 �� 1-� �����.
SELECT Name
FROM WArds
WHERE Building IN (4, 5) AND Floor = 1

--9. ������� ��������, ������� � ����� �������������� ���������, ������������� � �������� 3 ��� 6 � ������� ���� �������������� ������ 11000 ��� ������ 25000.
SELECT Name, Building, Financing
FROM DEpartments
WHERE Building IN (3, 6) AND (Financing < 11000 OR Financing > 25000)

--10. ������� ������� ������, ��� �������� (����� ������ � ��������) ��������� 1500.
SELECT Surname
FROM DOctors
WHERE Salary + Premium > 1500

--11. ������� ������� ������, � ������� �������� �������� ��������� ����������� ��������.
SELECT Surname
FROM DOctors
WHERE Salary / 2 > 3 * Premium

--12. ������� �������� ������������ ��� ����������, ���������� � ������ ��� ��� ������ � 12:00 �� 15:00.
SELECT DISTINCT Name
FROM EXaminations
WHERE DayOfWeek IN (1, 2, 3) AND StartTime >= '12:00' AND EndTime <= '15:00'

--13. ������� �������� � ������ �������� ���������, ������������� � �������� 1, 3, 8 ��� 10.
SELECT Name AS DepartmentName, Building AS WardBuilding
FROM DEpartments
WHERE Building IN (1, 3, 8, 10);

--14. ������� �������� ����������� ���� �������� �������, ����� 1-� � 2-�.
SELECT Name
FROM DIseases
WHERE Severity NOT IN (1, 2)

--15. ������� �������� ���������, ������� �� ������������� � 1-� ��� 3-� �������.
SELECT Name
FROM DEpartments
WHERE Building NOT IN (1, 3)

--16. ������� �������� ���������, ������� ������������� � 1-� ��� 3-� �������.
SELECT Name
FROM DEpartments
WHERE Building IN (1, 3)

--17. ������� ������� ������, ������������ �� ����� �N�.
SELECT Surname
FROM DOctors
WHERE Surname LIKE 'N%'