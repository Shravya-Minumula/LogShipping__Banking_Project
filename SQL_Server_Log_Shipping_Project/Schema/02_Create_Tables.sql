---Create Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY,
    FullName NVARCHAR(100),
    Email NVARCHAR(100),
    Phone VARCHAR(20),
    Address NVARCHAR(200),
    CreatedAt DATETIME DEFAULT GETDATE()
);

---Create Branches Table
CREATE TABLE Branches (
    BranchID INT PRIMARY KEY IDENTITY,
    BranchName NVARCHAR(100),
    Address NVARCHAR(200),
    Phone VARCHAR(20)
);

---Create Accounts Table
CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY IDENTITY,
    CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID),
    BranchID INT NOT NULL DEFAULT 1,
    AccountNumber VARCHAR(20) UNIQUE,
    AccountType VARCHAR(20),
    Balance DECIMAL(18,2),
    CreatedAt DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Accounts_Branches FOREIGN KEY (BranchID) REFERENCES Branches(BranchID)
);

---Create Transcations Table
CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY IDENTITY,
    AccountID INT FOREIGN KEY REFERENCES Accounts(AccountID),
    TransactionType VARCHAR(20), -- 'Credit' or 'Debit'
    Amount DECIMAL(18,2),
    TransactionDate DATETIME DEFAULT GETDATE(),
    Description NVARCHAR(200)
);

---Create Cards Table
CREATE TABLE Cards (
    CardID INT PRIMARY KEY IDENTITY,
    AccountID INT NOT NULL FOREIGN KEY REFERENCES Accounts(AccountID),
    CardNumber VARCHAR(20) UNIQUE,
    CardType VARCHAR(20), -- Debit or Credit
    ExpiryDate DATE,
    CVV VARCHAR(4)
);

---Create Transcationstatus Table
CREATE TABLE TransactionStatus (
    StatusID INT PRIMARY KEY IDENTITY,
    StatusName NVARCHAR(50) -- e.g., 'Pending', 'Completed', 'Failed'
);

---Create Loginactivity Table
CREATE TABLE LoginActivity (
    LoginID INT PRIMARY KEY IDENTITY,
    CustomerID INT NOT NULL FOREIGN KEY REFERENCES Customers(CustomerID),
    LoginTime DATETIME DEFAULT GETDATE(),
    LoginTimestamp DATETIME,
    LoginStatus VARCHAR(20),
    IPAddress VARCHAR(50),
    DeviceInfo NVARCHAR(200)
);
