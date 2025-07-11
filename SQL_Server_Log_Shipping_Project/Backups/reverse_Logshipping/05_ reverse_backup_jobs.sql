IF (@@ERROR = 0 AND @SP_Add_RetCode = 0)
BEGIN
	DECLARE @LS_BackUpScheduleUID AS uniqueidentifier;
	DECLARE @LS_BackUpScheduleID AS int;

	EXEC msdb.dbo.sp_add_schedule  
		@schedule_name = N'LSBackupSchedule_SHRAVYA_REDDY\S21',  
		@enabled = 1,  
		@freq_type = 4,  
		@freq_interval = 1,  
		@freq_subday_type = 4,  
		@freq_subday_interval = 20,  ---every 20 minutes
		@active_start_date = 20250709,  
		@active_end_date = 99991231,  
		@active_start_time = 0,  
		@active_end_time = 235900,  
		@schedule_uid = @LS_BackUpScheduleUID OUTPUT,  
		@schedule_id = @LS_BackUpScheduleID OUTPUT;

	EXEC msdb.dbo.sp_attach_schedule  
		@job_id = @LS_BackupJobId,  
		@schedule_id = @LS_BackUpScheduleID;

	EXEC msdb.dbo.sp_update_job  
		@job_id = @LS_BackupJobId,  
		@enabled = 1;
END

EXEC master.dbo.sp_add_log_shipping_alert_job;

EXEC master.dbo.sp_add_log_shipping_primary_secondary  
	@primary_database = N'BankingDB',  
	@secondary_server = N'SHRAVYA_REDDY\S1',  
	@secondary_database = N'BankingDB',  
	@overwrite = 1;
