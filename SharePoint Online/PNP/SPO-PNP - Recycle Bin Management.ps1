<#
.SYNOPSIS
Document Library Recycle Bin Item Management

.NOTES
Be careful!

.LINK
https://docs.microsoft.com/en-us/powershell/module/sharepoint-pnp/get-pnprecyclebinitem?view=sharepoint-ps
https://docs.microsoft.com/en-us/powershell/module/sharepoint-pnp/clear-pnprecyclebinitem?view=sharepoint-ps
https://docs.microsoft.com/en-us/powershell/module/sharepoint-pnp/restore-pnprecyclebinitem?view=sharepoint-ps

#>

$tenant = "tenantname";

$url = "https://${tenant}.sharepoint.com/sites/teamsite";
$url = "https://${tenant}-my.sharepoint.com/personal/user_domain";
$url = "";

<# Connect with SPO PnP to a SPO/ODFB site Connect with or without MFA. #>
Connect-PnPOnline -Url $url;
<# Connect without MFA using stored credentials. #>
Connect-PnPOnline -Url $url -Credentials $creds;
<# Connect without MFA and without storing credentials. #>
$me = "";
Connect-PnPOnline -Url $url -Credentials (Get-Credential -UserName $me -Message "Login:"));


<# List Items in Recycle Bin (1st + 2nd stage) #>
Get-PnPRecycleBinItem
Get-PnPRecycleBinItem -FirstStage
Get-PnPRecycleBinItem -SecondStage


<# Restore a specific item to it's original location. #>
$file_id = "";
Restore-PnpRecycleBinItem -Identity $file_id;
Restore-PnpRecycleBinItem -Identity $file_id -Force;

<# Find deleted items of a specific file type. #>
Get-PnPRecycleBinItem -FirstStage | ? LeafName -like "*.docx" -or LeafName -like "*.doc";
Get-PnPRecycleBinItem -FirstStage | ? LeafName -like "*.xlsx" -or LeafName -like "*.xls";

<# Number of items in the 2nd stage bin? #>
(Get-PnPRecycleBinItem -FirstStage).Count
(Get-PnPRecycleBinItem -SecondStage).Count


<# Select a single 1st stage deleted item of a specific filetype and restore it back to it's original location. #>
Get-PnPRecycleBinItem -FirstStage | ? LeafName -like "*.xlsx" -or LeafName -like "*.xls" | Out-GridView -OutputMode Single | Restore-PnpRecycleBinItem -Force;

<# Restore all files with a specific extension back to their original location. #>
Get-PnPRecycleBinItem -FirstStage | ? LeafName -like "*.xlsx" -or LeafName -like "*.xls" | Restore-PnpRecycleBinItem -Force;

<# WARNING: Purge the last/first X deleted items. #>
Get-PnPRecycleBinItem | Select -Last 1 | Clear-PnPRecycleBinItem -Force;
Get-PnPRecycleBinItem | Select -First 1 | Clear-PnPRecycleBinItem -Force;

<# WARNING: Purge all deleted items! #>
Get-PnPRecycleBinItem | Clear-PnPRecycleBinItem -Force;

<# #>
...
