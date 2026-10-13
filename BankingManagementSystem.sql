
CREATE DATABASE BankingDB;

USE BankingDB;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    phone VARCHAR(15)
);

INSERT INTO Customers (customer_name, city, phone)
VALUES
('Ravi', 'Hyderabad', '9876543210'),
('Sita', 'Vijayawada', '9876543211'),
('Kiran', 'Hyderabad', '9876543212'),
('Priya', 'Chennai', '9876543213');


SELECT * FROM Customers;
SELECT customer_name
FROM Customers
WHERE city = 'Hyderabad';

CREATE TABLE Accounts (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    account_type VARCHAR(20) NOT NULL,
    balance DECIMAL(12, 2) NOT NULL DEFAULT 0.00,

    FOREIGN KEY (customer_id)
    REFERENCES Customers(customer_id)
);

INSERT INTO Accounts
    (customer_id, account_type, balance)
VALUES
    (1, 'Savings', 25000.00),
    (2, 'Savings', 40000.00),
    (3, 'Current', 15000.00),
    (1, 'Current', 10000.00);
SELECT * FROM Accounts;


SELECT
    Customers.customer_name,
    Accounts.account_type,
    Accounts.balance
FROM Customers
INNER JOIN Accounts
ON Customers.customer_id = Accounts.customer_id;


SELECT
    c.customer_name,
    a.account_type,
    a.balance
FROM Customers c
INNER JOIN Accounts a
ON c.customer_id = a.customer_id
WHERE c.customer_name = 'Ravi';
UPDATE Accounts
SET balance = 45000.00
WHERE account_id = 2;

DELETE FROM Accounts
WHERE account_id = 3;



USE BankingDB;

CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT NOT NULL,
    transaction_type VARCHAR(20) NOT NULL,
    amount DECIMAL(12, 2) NOT NULL,
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id)
        REFERENCES Accounts(account_id)
);
INSERT INTO Transactions
    (account_id, transaction_type, amount)
VALUES
    (1, 'Deposit', 5000.00),
    (2, 'Withdraw', 2000.00),
    (1, 'Withdraw', 1000.00);
    SELECT * FROM Transactions;
    
    
    SELECT
    t.transaction_id,
    c.customer_name,
    t.account_id,
    t.transaction_type,
    t.amount,
    t.transaction_date
FROM Transactions t
INNER JOIN Accounts a
    ON t.account_id = a.account_id
INNER JOIN Customers c
    ON a.customer_id = c.customer_id
ORDER BY t.transaction_id;



SELECT
    c.customer_name,
    t.transaction_type,
    t.amount
FROM Transactions t
INNER JOIN Accounts a
    ON t.account_id = a.account_id
INNER JOIN Customers c
    ON a.customer_id = c.customer_id
WHERE c.customer_name = 'Ravi';


SELECT * FROM Accounts;
SELECT * FROM Transactions;
UPDATE Accounts
SET balance = balance + 5000
WHERE account_id = 1;



SELECT
    transaction_id,
    account_id,
    transaction_type,
    amount,
    transaction_date
FROM Transactions
ORDER BY transaction_date DESC;


UPDATE Accounts
SET balance = balance - 1000
WHERE account_id = 1;


SELECT account_id, balance
FROM Accounts
WHERE account_id = 1;


START TRANSACTION;

UPDATE Accounts
SET balance = balance + 1000
WHERE account_id = 1;

INSERT INTO Transactions
    (account_id, transaction_type, amount)
VALUES
    (1, 'Deposit', 1000);

COMMIT;
