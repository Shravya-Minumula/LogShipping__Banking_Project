---FULL BACKUP from Primary (S1)
BACKUP DATABASE BankingDB
TO DISK = 'C:\LS_SHARED1\BankingDB_Full.bak'
WITH INIT, FORMAT;

---LOG BACKUP from Primary (S1)
BACKUP LOG BankingDB
TO DISK = 'C:\LS_SHARED1\BankingDB_Log.trn'
WITH INIT;
