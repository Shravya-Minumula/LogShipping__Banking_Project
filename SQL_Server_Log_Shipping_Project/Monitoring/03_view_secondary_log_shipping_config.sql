-- View configuration details for secondary
EXEC master.dbo.sp_help_log_shipping_secondary_database 
    @secondary_database = 'BankingDB';