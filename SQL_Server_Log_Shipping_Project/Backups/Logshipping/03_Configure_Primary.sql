DECLARE @LS_BackupJobId AS uniqueidentifier;
DECLARE @LS_PrimaryId AS uniqueidentifier;
DECLARE @SP_Add_RetCode AS int;

EXEC @SP_Add_RetCode = master.dbo.sp_add_log_shipping_primary_database  
    @database = N'BankingDB',  
    @backup_directory = N'C:\LS_SHARED1',                     -- Local folder on Primary server for backups
    @backup_share = N'\\SHRAVYA_REDDY\LS_SHARED1',           -- Network share for Secondary to access backups
    @backup_job_name = N'LSBackup_BankingDB',  
    @backup_retention_period = 4320, 
    @backup_compression = 2, 
    @backup_threshold = 60,  
    @threshold_alert_enabled = 1, 
    @history_retention_period = 5760,  
    @backup_job_id = @LS_BackupJobId OUTPUT,  
    @primary_id = @LS_PrimaryId OUTPUT,  
    @overwrite = 1;

-- Add alert job for monitoring
EXEC master.dbo.sp_add_log_shipping_alert_job;

-- Link primary to secondary
EXEC master.dbo.sp_add_log_shipping_primary_secondary  
    @primary_database = N'BankingDB',  
    @secondary_server = N'SHRAVYA_REDDY\S2',  
    @secondary_database = N'BankingDB',  
    @overwrite = 1;
