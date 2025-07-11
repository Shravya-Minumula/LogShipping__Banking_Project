# SQL SERVER LOG SHIPPING AND REVERSE LOG SHIPPING FOR HIGH AVAILABILITY IN BANKING SYSTEM

# Technologies Used :

Database: Microsoft SQL Server 2022  
Language: T-SQL (Transact-SQL)  
Management Tool: SQL Server Management Studio (SSMS)  
Backup & Recovery: SQL Server Agent, SQL Server Jobs  
Monitoring: SQL Server Log Shipping Monitor, Custom Stored Procedures  

# Project Overview :

This project implements a **Log Shipping** and **Reverse Log Shipping** solution on a Microsoft SQL Server database designed to simulate
an **Online Banking Transaction System**. Log shipping is a high-availability and disaster recovery technique that automates the backup 
of transaction logs on a primary server and restores them on a secondary server to maintain a warm standby.

The database consists of seven tables representing key banking entities and operations. Reverse log shipping is implemented to enable 
failback and bidirectional synchronization, which provides greater flexibility and reliability in disaster recovery scenarios.

# Objectives :

- Establish continuous synchronization of transaction logs from primary to secondary servers to ensure data availability.  
- Configure reverse log shipping to support failover and failback, allowing the secondary server to become primary and vice versa.  
- Automate backup, copy, and restore jobs via SQL Server Agent for hands-free disaster recovery.  
- Enable monitoring of log shipping status and performance through SQL Server built-in tools and custom procedures.  
- Provide clear scripts and documentation to configure, test, and troubleshoot log shipping environments effectively.  

# Key Features :

- Database Schema: Seven essential tables modeling a realistic banking environment.  
- Automated Jobs: Scheduled full, transaction log backups, copy jobs, and restore jobs for primary and secondary servers.  
- Reverse Log Shipping: Scripts to enable log shipping in both directions, enhancing availability.  
- Monitoring: Utilization of SQL Server Log Shipping Monitor and custom monitoring stored procedures.  
- Error Handling & Troubleshooting: Guidelines and scripts to handle common issues like LSN mismatches and job failures.  
- Security: Proper permissions for SQL Server Agent accounts and secure network share access for log file transfers.  

# Database Tables Overview :

| Table Name           | Description                                                                                      |
|----------------------|------------------------------------------------------------------------------------------------|
| `Customers`          | Stores customer personal details such as name, contact info, and address.                       |
| `Accounts`           | Represents different bank accounts held by customers, including account types and balances.    |
| `Transactions`       | Logs all financial transactions linked to accounts, including deposits, withdrawals, and transfers. |
| `Branches`           | Contains details about bank branches, including location, contact information, and manager.    |
| `Cards`              | Stores information about debit and credit cards issued to customers, including card status.    |
| `TransactionStatus`  | Tracks the status of transactions (e.g., Pending, Completed, Failed) for auditing and tracking.|
| `LoginActivity`      | Logs customer login attempts, including timestamps, IP addresses, and success/failure status.  |

## Detailed Functional Queries :

This section provides essential queries used in the project for data retrieval, backup, restore, and monitoring the log shipping process.

-- Retrieve all customers

**SELECT * FROM Customers;**

-- Get accounts and balances for a specific customer

**SELECT AccountID, AccountType, Balance 
FROM Accounts 
WHERE CustomerID = 20;**

-- List recent transactions for a specific account

**SELECT TOP 10 TransactionID, TransactionDate, Amount, StatusID 
FROM Transactions 
WHERE AccountID = 15 
ORDER BY TransactionDate DESC;**

-- Retrieve branch details

**SELECT * FROM Branches;**

-- Get active cards for a customer

**SELECT * FROM Cards 
WHERE CustomerID = 1 AND CardStatus = 'Active';**

-- View all transaction statuses

**SELECT * FROM TransactionStatus;**

-- Check recent login activities for audit

**SELECT TOP 20 CustomerID, LoginTime, IPAddress, LoginResult 
FROM LoginActivity 
ORDER BY LoginTime DESC;**

-- View overall monitoring status of log shipping

**EXEC master.dbo.sp_help_log_shipping_monitor;**

-- View configuration details of primary database for log shipping

**EXEC master.dbo.sp_help_log_shipping_primary_database 
    @database = 'BankingDB';**

-- View configuration details of secondary database for log shipping

**EXEC master.dbo.sp_help_log_shipping_secondary_database 
    @secondary_database = 'BankingDB';**

# Security and Access Control :

- SQL Server Authentication is used for all database connections.
- SQL Server Agent jobs run under service accounts with read/write access to shared backup folders.
- Access to backup directories is limited to authorized service accounts on both primary and secondary servers.
- Permissions to configure and monitor log shipping are restricted to DBAs and system administrators only.

# Testing & Validation :

The log shipping and reverse log shipping setup was validated by:

- Performing multiple transactions on the primary server (inserting rows in `Transactions`).
- Monitoring whether transaction logs were correctly backed up, copied, and restored on the secondary server.
- Using `RESTORE FILELISTONLY` and `msdb` system tables to verify the log sequence chain.
- Simulating failover by recovering the secondary server and confirming data consistency.

# Troubleshooting :

- **LSN Mismatch Error:** Ensure no logs are skipped; restore in exact backup sequence.
- **Job Failure:** Check SQL Agent job history, and confirm folder/network access permissions.
- **Stuck in Restoring State:** This is expected unless `WITH RECOVERY` is used.
- **Copy Job Issues:** Make sure shared folders are accessible from both servers.

# Conclusion :

This project demonstrates a full-cycle setup of Log Shipping and Reverse Log Shipping in SQL Server using a banking database simulation. It includes all critical DBA tasks — database design, backup, disaster recovery, monitoring, and job automation — making it a valuable hands-on showcase of high availability practices in real-world enterprise environments.






