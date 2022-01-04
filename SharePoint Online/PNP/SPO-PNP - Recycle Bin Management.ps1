<#
.SYNOPSIS
SharePoint Online Document Library Recycle Bin Item Management
https://github.com/O365scripts/O365scripts/blob/master/SharePoint%20Online/PNP/SPO-PNP%20-%20Recycle%20Bin%20Management.ps1
.NOTES
Be careful!
.LINK
https://docs.microsoft.com/en-us/powershell/module/sharepoint-pnp/get-pnprecyclebinitem?view=sharepoint-ps
https://docs.microsoft.com/en-us/powershell/module/sharepoint-pnp/clear-pnprecyclebinitem?view=sharepoint-ps
https://docs.microsoft.com/en-us/powershell/module/sharepoint-pnp/restore-pnprecyclebinitem?view=sharepoint-ps
#>

<# QUICKRUN: Install and connect to PNP. #>
#Set-ExecutionPolicy RemoteSigned -Force -Confirm:$false;
#Install-Module PnP.PowerShell -AllowClobber -Force -Confirm:$false;
Import-Module PnP.PowerShell;
#Register-PnPManagementShellAccess;
$Tenant = "";
#$PnpSite = "https://${Tenant}.sharepoint.com/";
#$PnpSite = "https://${Tenant}.sharepoint.com/sites/SiteName";
#$PnpSite = "https://${Tenant}-my.sharepoint.com/personal/user_domain_com";
$PnpSite = "";
Connect-PnPOnline -Url $PnpSite -Interactive;

<# List Items in Recycle Bin (1st + 2nd stage) #>
Get-PnPRecycleBinItem;
Get-PnPRecycleBinItem -FirstStage;
Get-PnPRecycleBinItem -SecondStage;

<# Find deleted items of a specific file type. #>
Get-PnPRecycleBinItem -FirstStage | ? LeafName -like "*.docx" -or LeafName -like "*.doc";
Get-PnPRecycleBinItem -FirstStage | ? LeafName -like "*.xlsx" -or LeafName -like "*.xls";
Get-PnPRecycleBinItem -FirstStage | ? LeafName -like "*.pdf";

<# Number of items in the 2nd stage bin? #>
(Get-PnPRecycleBinItem -FirstStage).Count
(Get-PnPRecycleBinItem -SecondStage).Count

<#  a single 1st stage deleted item of a specific filetype and restore it back to it's original location. #>
$ListBinItems = Get-PnPRecycleBinItem -FirstStage | ? LeafName -like "*.xlsx" -or LeafName -like "*.xls" | Out-GridView -PassThru;
$ListBinItems | % {Restore-PnpRecycleBinItem -Force};

<# Restore a specific item to it's original location. #>
$BinItemId = "";
Restore-PnpRecycleBinItem -Identity $BinItemId -Force;

<# Restore all files with a specific extension back to their original location. #>
Get-PnPRecycleBinItem -FirstStage | ? LeafName -like "*.xlsx" -or LeafName -like "*.xls" | Restore-PnpRecycleBinItem -Force;

<# WARNING: Purge the last/first X deleted items. #>
Get-PnPRecycleBinItem | Select -Last 1 | Clear-PnPRecycleBinItem -Force;
Get-PnPRecycleBinItem | Select -First 1 | Clear-PnPRecycleBinItem -Force;

<# WARNING: Purge all deleted items! #>
Get-PnPRecycleBinItem | Clear-PnPRecycleBinItem -Force;
