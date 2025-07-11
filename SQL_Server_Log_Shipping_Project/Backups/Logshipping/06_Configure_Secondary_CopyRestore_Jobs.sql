IF (@@ERROR = 0 AND @LS_Add_RetCode = 0)
BEGIN
    -- Copy Job Schedule
    DECLARE @LS_SecondaryCopyJobScheduleUID AS uniqueidentifier;
    DECLARE @LS_SecondaryCopyJobScheduleID AS int;

    EXEC msdb.dbo.sp_add_schedule  
        @schedule_name = N'DefaultCopyJobSchedule',  
        @enabled = 1,  
        @freq_type = 4,              
        @freq_interval = 1,          
        @freq_subday_type = 4,       
        @freq_subday_interval = 25,  
        @freq_recurrence_factor = 0,  
        @active_start_date = 20250709,  
        @active_end_date = 99991231,  
        @active_start_time = 0,  
        @active_end_time = 235900,  
        @schedule_uid = @LS_SecondaryCopyJobScheduleUID OUTPUT,  
        @schedule_id = @LS_SecondaryCopyJobScheduleID OUTPUT;

    EXEC msdb.dbo.sp_attach_schedule  
        @job_id = @LS_Secondary_CopyJobId,  
        @schedule_id = @LS_SecondaryCopyJobScheduleID;

    -- Restore Job Schedule
    DECLARE @LS_SecondaryRestoreJobScheduleUID AS uniqueidentifier;
    DECLARE @LS_SecondaryRestoreJobScheduleID AS int;

    EXEC msdb.dbo.sp_add_schedule  
        @schedule_name = N'DefaultRestoreJobSchedule',  
        @enabled = 1,  
        @freq_type = 4,              
        @freq_interval = 1,          
        @freq_subday_type = 4,       
        @freq_subday_interval = 15,  
        @freq_recurrence_factor = 0,  
        @active_start_date = 20250709,  
        @active_end_date = 99991231,  
        @active_start_time = 0,  
        @active_end_time = 235900,  
        @schedule_uid = @LS_SecondaryRestoreJobScheduleUID OUTPUT,  
        @schedule_id = @LS_SecondaryRestoreJobScheduleID OUTPUT;

    EXEC msdb.dbo.sp_attach_schedule  
        @job_id = @LS_Secondary_RestoreJobId,  
        @schedule_id = @LS_SecondaryRestoreJobScheduleID;
END

-- Configure secondary database restore behavior
DECLARE @LS_Add_RetCode2 AS int;

IF (@@ERROR = 0 AND @LS_Add_RetCode = 0)
BEGIN
    EXEC @LS_Add_RetCode2 = master.dbo.sp_add_log_shipping_secondary_database  
        @secondary_database = N'BankingDB',  
        @primary_server = N'SHRAVYA_REDDY\S1',  
        @primary_database = N'BankingDB',  
        @restore_delay = 0,  
        @restore_mode = 1,           -- No recovery mode
        @disconnect_users = 0,  
        @restore_threshold = 45,  
        @threshold_alert_enabled = 1,  
        @history_retention_period = 5760,  
        @overwrite = 1;
END

-- Enable the Copy and Restore jobs
IF (@@ERROR = 0 AND @LS_Add_RetCode = 0)
BEGIN
    EXEC msdb.dbo.sp_update_job  
        @job_id = @LS_Secondary_CopyJobId,  
        @enabled = 1;

    EXEC msdb.dbo.sp_update_job  
        @job_id = @LS_Secondary_RestoreJobId,  
        @enabled = 1;
END
