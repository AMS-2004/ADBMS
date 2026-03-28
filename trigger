mysql> use e;
Database changed
mysql> create table Accounts(id int primary key,balance decimal(10,2));
Query OK, 0 rows affected (0.51 sec)

mysql> create table Customer(customer_id int primary key AUTO_INCREMENT, name VARCHAR(100),city VARCHAR(100),
    ->  credits DECIMAL(10,2)
    -> );
Query OK, 0 rows affected (0.85 sec)

mysql> CREATE TABLE Employees ( emp_id INT PRIMARY KEY AUTO_INCREMENT,name VARCHAR(100),department VARCHAR(100),salary DECIMAL(10,2));
Query OK, 0 rows affected (0.79 sec)

mysql> CREATE TABLE Emp_salary (emp_id INT PRIMARY KEY, emp_name VARCHAR(100), no_of_working_days INT, designation VARCHAR(100));
Query OK, 0 rows affected (0.61 sec)

mysql> CREATE TABLE Bill (customer_id INT PRIMARY KEY, name VARCHAR(100), pre_reading INT, cur_reading INT, unit INT, amount DECIMAL(10,2));
Query OK, 0 rows affected (0.85 sec)

mysql> CREATE TABLE Employee (employee_id INT PRIMARY KEY, name VARCHAR(100), department VARCHAR(100), salary DECIMAL(10,2));
Query OK, 0 rows affected (0.59 sec)

mysql> CREATE TABLE Emp_history (employee_id INT, name VARCHAR(100), department VARCHAR(100), salary DECIMAL(10,2), date_of_deletion TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
Query OK, 0 rows affected (0.49 sec)

mysql> CREATE TABLE emp_details (emp_id INT PRIMARY KEY AUTO_INCREMENT, FIRST_NAME VARCHAR(100), LAST_NAME VARCHAR(100), JOB_ID VARCHAR(100));
Query OK, 0 rows affected (0.85 sec)

mysql> CREATE TABLE student_marks (student_id INT PRIMARY KEY, name VARCHAR(100), sub1 INT, sub2 INT, sub3 INT, sub4 INT, sub5 INT, total INT, per_marks DECIMAL(5,2), grade VARCHAR(50));
Query OK, 0 rows affected (1.05 sec)

mysql> show tables;
+---------------+
| Tables_in_e   |
+---------------+
| Accounts      |
| Bill          |
| Customer      |
| Emp_history   |
| Emp_salary    |
| Employee      |
| Employees     |
| emp_details   |
| student_marks |
+---------------+
9 rows in set (0.00 sec)

mysql> INSERT INTO Accounts VALUES (123, 5000); INSERT INTO Accounts VALUES (124, 2000);
Query OK, 1 row affected (0.09 sec)

Query OK, 1 row affected (0.14 sec)

mysql> INSERT INTO Customer (name, city, credits) VALUES ('John', 'New York', 6000); INSERT INTO Customer (name, city, credits) VALUES ('Alice', 'London', 3500); INSERT INTO Customer (name, city, credits) VALUES ('Bob', 'Paris', 800);
Query OK, 1 row affected (0.11 sec)

Query OK, 1 row affected (0.13 sec)

Query OK, 1 row affected (0.19 sec)

mysql> INSERT INTO Employees (name, department, salary) VALUES ('John', 'HR', 40000); INSERT INTO Employees (name, department, salary) VALUES ('John', 'IT', 50000); INSERT INTO Employees (name, department, salary) VALUES ('Alice', 'Finance', 45000);
Query OK, 1 row affected (0.09 sec)

Query OK, 1 row affected (0.09 sec)

Query OK, 1 row affected (0.09 sec)

mysql> INSERT INTO Emp_salary VALUES (1, 'John', 20, 'Assistant Professor'); INSERT INTO Emp_salary VALUES (2, 'Alice', 25, 'Clerk'); INSERT INTO Emp_salary VALUES (3, 'Bob', 22, 'Programmer');
Query OK, 1 row affected (0.10 sec)

Query OK, 1 row affected (0.09 sec)

Query OK, 1 row affected (0.08 sec)

mysql> INSERT INTO Bill VALUES (1, 'John', 100, 200, NULL, NULL); INSERT INTO Bill VALUES (2, 'Alice', 150, 300, NULL, NULL); INSERT INTO Bill VALUES (3, 'Bob', 200, 400, NULL, NULL);
Query OK, 1 row affected (0.08 sec)

Query OK, 1 row affected (0.09 sec)

Query OK, 1 row affected (0.09 sec)

mysql> INSERT INTO Employee VALUES (1, 'John', 'IT', 50000); INSERT INTO Employee VALUES (2, 'Alice', 'HR', 45000);
Query OK, 1 row affected (0.07 sec)

Query OK, 1 row affected (0.10 sec)

mysql> INSERT INTO emp_details (FIRST_NAME, LAST_NAME, JOB_ID) VALUES (' John ', ' Doe ', 'engineer');
Query OK, 1 row affected (0.08 sec)

mysql> INSERT INTO student_marks (student_id, name, sub1, sub2, sub3, sub4, sub5) VALUES (1, 'John', 70, 75, 80, 65, 85); INSERT INTO student_marks (student_id, name, sub1, sub2, sub3, sub4, sub5) VALUES (2, 'Alice', 70, 80, 65, 75, 85);
Query OK, 1 row affected (0.10 sec)

Query OK, 1 row affected (0.36 sec)

mysql> delimiter //
mysql> CREATE PROCEDURE WithdrawAmount(IN account_id INT, IN
    -> withdraw_amount DECIMAL(10,2))
    -> BEGIN
    -> DECLARE current_balance DECIMAL(10,2);
    -> DECLARE account_exists INT;
    -> SELECT COUNT(*) INTO account_exists FROM Accounts
    -> WHERE id = account_id;
    -> IF account_exists = 0 THEN
    -> SIGNAL SQLSTATE '45000'
    -> SET MESSAGE_TEXT = 'Account does not exist.';
    -> ELSE
    -> SELECT balance INTO current_balance FROM Accounts
    -> WHERE id = account_id;
    -> IF current_balance - withdraw_amount < 1000 THEN
    -> SIGNAL SQLSTATE '45000'
    -> SET MESSAGE_TEXT = 'Insufficient balance. The balance after withdrawal
    '> must be at least 1000.';
    -> ELSE
    -> UPDATE Accounts SET balance = balance - withdraw_amount
    -> WHERE id = account_id;
    -> SIGNAL SQLSTATE '02000'
    -> SET MESSAGE_TEXT = 'Withdrawal successful.';
    -> END IF;
    -> END IF;
    -> END //
Query OK, 0 rows affected (0.12 sec)

mysql> CALL WithdrawAmount(123, 500.00) ;
    -> 
    -> 
    -> ^C

^C
mysql> CALL WithdrawAmount(123, 500.00) ;
    -> 

^C
mysql> CALL WithdrawAmount(123,500.00) ;
    -> 500
    -> 234
    -> ^C

^C
mysql> CALL WithdrawAmount(123, 500.00) //
ERROR 1643 (02000): Withdrawal successful.
mysql> 

