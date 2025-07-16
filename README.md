# SQL Server Log Shipping and Reverse Log Shipping for High Availability in Banking System

---

## Technologies Used :

- **Database:** Microsoft SQL Server 2022  
- **Language:** T-SQL (Transact-SQL)  
- **Management Tool:** SQL Server Management Studio (SSMS)  
- **Backup & Recovery:** SQL Server Agent, SQL Server Jobs  
- **Monitoring Tools:** SQL Server Log Shipping Monitor, Custom Stored Procedures  

## Project Overview :

This project demonstrates a high-availability **Log Shipping and Reverse Log Shipping** setup using **Microsoft SQL Server 2022** to simulate a robust **Online Banking Transaction System**.

**Log Shipping** is a disaster recovery technique where **transaction log backups** from a **primary server** are automatically copied and restored to a **secondary server**, maintaining a warm standby replica of the database.

**Reverse Log Shipping** extends this concept by allowing failback—making the secondary server act as a new primary and syncing logs in the opposite direction, thus ensuring **bi-directional data synchronization** and high resilience.

## Objectives :

- Establish **continuous transaction log synchronization** from primary to secondary to ensure high data availability.  
-  Configure **reverse log shipping** to support seamless failover and failback.  
-  Automate **backup**, **copy**, and **restore** operations using **SQL Server Agent Jobs**.  
-  Enable real-time **monitoring** through SQL Server’s built-in tools and custom stored procedures.  
-  Provide a detailed **documentation set** for setup, testing, and troubleshooting.  

## Key Features :

-  **Database Schema :** Includes 7 interconnected tables modeling real-world banking operations.  
-  **Automation :** Scheduled jobs for full backups, transaction log backups, file copying, and restores.  
-  **Reverse Log Shipping Support :** Full scripting for primary-to-secondary and secondary-to-primary transitions.  
-  **Monitoring and Reporting :** Using SQL Server Log Shipping Monitor and custom queries.  
-  **Troubleshooting Toolkit :** Includes solutions for **LSN mismatches**, **job failures**, and other common issues.  
-  **Security-First Design :** Uses secure SQL logins, agent credentials, and restricted access to backup folders.  

##  Database Tables Overview :

| Table Name           | Description                                                                 |
|----------------------|-----------------------------------------------------------------------------|
| **Customers**        | Stores customer details like full name, contact info, and address.         |
| **Accounts**         | Tracks customer accounts including type and balance.                       |
| **Transactions**     | Logs all deposits, withdrawals, and transfers with timestamp.              |
| **Branches**         | Contains metadata about bank branches such as location and manager.       |
| **Cards**            | Maintains records of debit/credit cards issued to customers.              |
| **TransactionStatus**| Lists statuses (Pending, Completed, Failed) for transaction auditing.     |
| **LoginActivity**    | Logs login attempts, IPs, timestamps, and outcomes (success/failure).      |

---

## Sample Functional Queries :

-- Retrieve all customers
```sql
SELECT * FROM Customers;
```
-- Get accounts and balances for a specific customer
```sql
SELECT AccountID, AccountType, Balance 
FROM Accounts 
WHERE CustomerID = 20;
```
-- List recent transactions for a specific account
```sql
SELECT TOP 10 TransactionID, TransactionDate, Amount, StatusID 
FROM Transactions 
WHERE AccountID = 15 
ORDER BY TransactionDate DESC;
```

-- Retrieve branch details
```sql
SELECT * FROM Branches;
```

-- Get active cards for a customer
```sql
SELECT * FROM Cards 
WHERE CustomerID = 1 AND CardStatus = 'Active';
```

-- View all transaction statuses
```sql
SELECT * FROM TransactionStatus;
```

-- Check recent login activities for audit
```sql
SELECT TOP 20 CustomerID, LoginTime, IPAddress, LoginResult 
FROM LoginActivity 
ORDER BY LoginTime DESC;
```

## Monitoring Stored Procedures :

-- View overall log shipping monitor status
```sql
EXEC master.dbo.sp_help_log_shipping_monitor;
```

-- View configuration details of primary database for log shipping
```sql
EXEC master.dbo.sp_help_log_shipping_primary_database 
    @database = 'BankingDB';
```

-- View configuration details of secondary database for log shipping
```sql
EXEC master.dbo.sp_help_log_shipping_secondary_database 
    @secondary_database = 'BankingDB';
```

## Security and Access Control :

To ensure a secure and controlled Log Shipping environment, the following **security measures** are implemented:

-  **SQL Server Authentication** is used to establish all database connections securely.
-  **SQL Server Agent Jobs** are executed under **dedicated service accounts** with **read/write** access to the **network-shared backup folder**.
-  Access to **backup directories** is strictly restricted to **authorized service accounts** on both **primary** and **secondary servers**.
-  Only users with **Database Administrator (DBA)** or **System Administrator** privileges are permitted to configure or monitor the log shipping infrastructure.

These configurations maintain **data integrity**, prevent unauthorized access, and ensure that **log backups and restores** happen smoothly across servers.

## Testing & Validation :

To validate the effectiveness and consistency of the **Log Shipping and Reverse Log Shipping** configuration, the following **real-world testing scenarios** were performed:

-  **Simulated multiple transactions** (e.g., inserting records into the `Transactions` table) on the **primary server**.
-  Verified that **transaction log backups** were **successfully created**, **copied**, and **restored** on the **secondary server** without errors.
-  Used `RESTORE FILELISTONLY` and queried **SQL Server system tables** like `msdb.dbo.backupset` to verify that the **Log Sequence Numbers (LSNs)** were intact and followed a consistent chain.
-  Simulated a **failover** scenario by recovering the secondary server using `WITH RECOVERY`, validated application access, and confirmed **data consistency** post-failback.

These tests confirm that the setup is **resilient**, **automated**, and **suitable for high-availability production environments**.

## Troubleshooting :

Below is a list of **common issues** encountered during Log Shipping and **recommended solutions**:

| Issue                      | Recommended Solution                                                                 |
|----------------------------|--------------------------------------------------------------------------------------|
| **LSN Mismatch Error**   | Ensure that **no log backup is skipped**, and that all logs are restored in exact sequence. |
| **SQL Agent Job Failure**| Review **job history logs**, check for failed steps, and ensure that **network shares** are accessible. |
| **Stuck in Restoring**   | This is **expected behavior** unless you run a `RESTORE DATABASE ... WITH RECOVERY` command to finalize the restore. |
| **Copy Job Issues**      | Ensure that **shared folder paths** are correct and accessible by **both servers**. Test path access manually if needed. |

These guidelines help proactively resolve issues and reduce downtime.

## Conclusion :

This project showcases a **complete disaster recovery and high-availability solution** using **SQL Server Log Shipping and Reverse Log Shipping** in a **Banking Transaction Database** context.

It demonstrates hands-on expertise in:

-  **Database Design** and **Entity Modeling**
-  **Automated Backup/Restore Scripting**
-  **Primary-to-Secondary Log Shipping Setup**
-  **Secondary-to-Primary Reverse Shipping Configuration**
-  **Real-Time Monitoring** via SQL Server tools and system stored procedures
-  **Troubleshooting and Performance Validation**

Through structured testing, security configuration, and job scheduling, this project mirrors real-world enterprise **DBA responsibilities**, making it a **perfect portfolio project** for roles involving **SQL Server Administration**, **Disaster Recovery Planning**, or **Enterprise Database Management**.

---
