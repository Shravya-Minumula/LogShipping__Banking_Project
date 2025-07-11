---RESTORE FULL BACKUP on Secondary (S2)
RESTORE DATABASE BankingDB
FROM DISK = 'C:\LS_SHARED1\Banking_full.bak'
WITH NORECOVERY,
MOVE 'BankingDB' TO 'C:\LS_SHARED2\BankingDB.mdf',
MOVE 'BankingDB_log' TO 'C:\LS_SHARED2\BankingDB_log.ldf';

---RESTORE LOG BACKUP on Secondary (S2)
RESTORE LOG BankingDB
FROM DISK = 'C:\LS_SHARED1\BankingDB_Log.trn'
WITH NORECOVERY;
