DECLARE @LS_Secondary_CopyJobId AS uniqueidentifier;
DECLARE @LS_Secondary_RestoreJobId AS uniqueidentifier;
DECLARE @LS_Secondary_SecondaryId AS uniqueidentifier;
DECLARE @LS_Add_RetCode AS int;

EXEC @LS_Add_RetCode = master.dbo.sp_add_log_shipping_secondary_primary  
    @primary_server = N'SHRAVYA_REDDY\S1',  
    @primary_database = N'BankingDB',  
    @backup_source_directory = N'\\SHRAVYA_REDDY\LS_SHARED1',    -- backup share from primary
    @backup_destination_directory = N'C:\LS_SHARED2',             -- local folder on secondary for copy
    @copy_job_name = N'LSCopy\S1_BankingDB',  
    @restore_job_name = N'LSRestore\S1_BankingDB',  
    @file_retention_period = 4320,  
    @overwrite = 1,  
    @copy_job_id = @LS_Secondary_CopyJobId OUTPUT,  
    @restore_job_id = @LS_Secondary_RestoreJobId OUTPUT,  
    @secondary_id = @LS_Secondary_SecondaryId OUTPUT;
