 =============================================
 Azure SQL Database Migration Script
 Author: Samuel McLaurin
 =============================================

 --- VARIABLES ---
$ResourceGroup    = "DBA-Portfolio-RG"
$Location         = "EastUS"
$ServerName       = "sam-sql-server-demo"
$AdminUser        = "sqladmin"
$AdminPassword    = "YourSecurePassword123!"
$DatabaseName     = "InventoryDB-Azure"
$Edition          = "Standard"

 --- LOGIN TO AZURE ---
Connect-AzAccount

 --- CREATE RESOURCE GROUP ---
New-AzResourceGroup `
    -Name $ResourceGroup `
    -Location $Location

 --- CREATE SQL SERVER ---
New-AzSqlServer `
    -ResourceGroupName $ResourceGroup `
    -ServerName $ServerName `
    -Location $Location `
    -SqlAdministratorCredentials `
        (New-Object PSCredential($AdminUser,
        (ConvertTo-SecureString $AdminPassword -AsPlainText -Force)))

 --- CREATE DATABASE ---
New-AzSqlDatabase `
    -ResourceGroupName $ResourceGroup `
    -ServerName $ServerName `
    -DatabaseName $DatabaseName `
    -Edition $Edition `
    -RequestedServiceObjectiveName "S1"

Write-Host "Azure SQL Database deployed successfully." -ForegroundColor Green
