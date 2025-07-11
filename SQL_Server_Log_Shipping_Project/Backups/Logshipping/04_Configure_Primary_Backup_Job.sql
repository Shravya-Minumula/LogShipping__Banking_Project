IF (@@ERROR = 0 AND @SP_Add_RetCode = 0)
BEGIN
    DECLARE @LS_BackUpScheduleUID AS uniqueidentifier;
    DECLARE @LS_BackUpScheduleID AS int;

    EXEC msdb.dbo.sp_add_schedule  
        @schedule_name = N'LSBackupSchedule_S1',  
        @enabled = 1,  
        @freq_type = 4,               
        @freq_interval = 1,           
        @freq_subday_type = 4,       
        @freq_subday_interval = 25,   -- every 25 minutes
        @freq_recurrence_factor = 0,  
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
