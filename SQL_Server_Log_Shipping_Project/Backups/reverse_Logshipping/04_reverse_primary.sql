DECLARE @LS_BackupJobId AS uniqueidentifier;
DECLARE @LS_PrimaryId AS uniqueidentifier;
DECLARE @SP_Add_RetCode AS int;

EXEC @SP_Add_RetCode = master.dbo.sp_add_log_shipping_primary_database  
	@database = N'BankingDB',  
	@backup_directory = N'c:\Rev_LS1',  
	@backup_share = N'\\SHRAVYA_REDDY\Rev_LS1',  
	@backup_job_name = N'LSBackup_Rev_BankingDB',  
	@backup_retention_period = 4320,  
	@backup_compression = 2,  
	@backup_threshold = 60,  
	@threshold_alert_enabled = 1,  
	@history_retention_period = 5760,  
	@backup_job_id = @LS_BackupJobId OUTPUT,  
	@primary_id = @LS_PrimaryId OUTPUT,  
	@overwrite = 1;
