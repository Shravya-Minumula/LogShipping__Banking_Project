DECLARE @LS_Secondary__CopyJobId AS uniqueidentifier;
DECLARE @LS_Secondary__RestoreJobId AS uniqueidentifier;
DECLARE @LS_Secondary__SecondaryId AS uniqueidentifier;
DECLARE @LS_Add_RetCode AS int;

EXEC @LS_Add_RetCode = master.dbo.sp_add_log_shipping_secondary_primary  
	@primary_server = N'SHRAVYA_REDDY\S2',  
	@primary_database = N'BankingDB',  
	@backup_source_directory = N'\\SHRAVYA_REDDY\Rev_LS1',  
	@backup_destination_directory = N'c:\Rev_LS2',  
	@copy_job_name = N'LSCopy_Rev_S2_BankingDB',  
	@restore_job_name = N'LSRestore_Rev_S2_BankingDB',  
	@file_retention_period = 4320,  
	@overwrite = 1,  
	@copy_job_id = @LS_Secondary__CopyJobId OUTPUT,  
	@restore_job_id = @LS_Secondary__RestoreJobId OUTPUT,  
	@secondary_id = @LS_Secondary__SecondaryId OUTPUT;
