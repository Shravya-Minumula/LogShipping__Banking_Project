---Restore that backup on original primary (S1) WITH NORECOVERY
RESTORE DATABASE BankingDB
FROM DISK = 'C:\LS_SHARED1\Reverse_Full.bak'
WITH NORECOVERY, REPLACE;
