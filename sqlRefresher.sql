use school;

CREATE TABLE Students (
StudentsID INT PRIMARY KEY,
FirstName VARCHAR(50),
LastName VARCHAR(50),
AGE INT,
GPA FLOAT
);

INSERT INTO Students (StudentsID, FirstName, LastName, Age, GPA)
VALUES
	(1, 'John', 'Doe', 20, 3.5),
    (1, 'Jane', 'Smith', 22, 3.8),
    (1, 'Alice', 'Johnson', 21, 3.9);
    
SELECT * FROM Students;

-- UPDATE Students
--  SET GPA = 4.0
--  WHERE StudentsID = 2;

SELECT * FROM Students
	ORDER BY GPA DESC;
    
-- constarints are rules that enforce data integrity

CREATE TABLE Employees (
	EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Department VARCHAR(50),
    Salary DECIMAL(10, 2) CHECK (Salary >= 0) 
);

INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary)
VALUES
	(1, 'John', 'Doe', 'English', 50000),
    (2, 'Jane', 'Smith', 'Math', 60000),
    (3, 'Alice', 'Johnson','English', 50000),
    (4, 'Michael', 'Mist', 'Business', 70000),
    (5, 'Ann', 'Annette', 'Counselling', 80000),
    (6, 'Brian', 'Bonne', 'Sports', 65000),
    (7, 'Terry', 'Cruise', 'Math', 60000);

SELECT * FROM Employees;

-- querying
SELECT * FROM Students
	WHERE Age > (SELECT AVG(AGE) FROM Students);

-- condition
SELECT FirstName, LastName,
	CASE
		WHEN GPA >= 3.5 THEN "Excellent"
		WHEN GPA >= 3.0 THEN "Good"
		ELSE "Needs Improvement"
	END AS Performance
From Students;

SELECT Department, AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY Department;

SELECT Department, COUNT(*) AS NumEmployees
FROM Employees
GROUP BY Department
HAVING COUNT(*) > 1;

CREATE TABLE Orders (
	OrderID INT PRIMARY KEY,
    OrderDate DATE,
    EmployeeID INT,
    
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

CREATE TABLE Customers (
	CustomerID INT PRIMARY KEY,
	CustomerName VARCHAR(100)
);

INSERT INTO Orders (OrderID, EmployeeID, OrderDate)
VALUES
	(1, 1, '2024-01-10'),
    (2, 3, '2024-02-10'),
    (3, 4, '2024-01-15'),
    (4, 2, '2024-01-13');

SELECT EmployeeID, FirstName, LastName
FROM Employees e
WHERE NOT EXISTS (
	SELECT 1
    FROM Orders o
    WHERE o.EmployeeID = e.EmployeeID
);

-- inner join - finds data in both tables
SELECT Orders.OrderID, Employees.FirstName
FROM Orders
INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID;

-- cross join - used to create all possible combinations of rows from both tables 
SELECT Orders.OrderID, Employees.EmployeeID
FROM Orders
CROSS JOIN Employees;

CREATE TABLE Courses (
	CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    Instructor VARCHAR(100)
);

INSERT INTO Courses (CourseID, CourseName, Instructor)
VALUES
	(1, 'Math', 'Eddy'),
    (2, 'Physics', 'John'),
    (3, 'History', 'Joy');
    
SELECT Students.FirstName, Students.LastName, Courses.CourseName
FROM Students
CROSS JOIN Courses;
