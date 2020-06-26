<#
.SYNOPSIS
Document Library Recycle Bin Item Management

.NOTES
Be careful!

.LINK
https://docs.microsoft.com/en-us/powershell/module/sharepoint-pnp/get-pnprecyclebinitem?view=sharepoint-ps
https://docs.microsoft.com/en-us/powershell/module/sharepoint-pnp/clear-pnprecyclebinitem?view=sharepoint-ps
#>

$me = "";
$tenant = "tenantname";

$url = "https://${tenant}.sharepoint.com/sites/teamsite";
$url = "https://${tenant}-my.sharepoint.com/personal/user_domain";
$url = "";

<# Connect with SPO PnP to a SPO/ODFB site Connect with or without MFA. #>
Connect-PnPOnline -Url $url;
<# Connect without MFA using stored credentials. #>
Connect-PnPOnline -Url $url -Credentials $creds;
<# Connect without MFA and without storin credentials. #>
Connect-PnPOnline -Url $url -Credentials (Get-Credential -UserName $me -Message "Login:"));


<# WARNING: Purge all items in the 1st (2nd too??) stage recycle bins! #>
Get-PnPRecycleBinItem | Clear-PnPRecycleBinItem -Force

<# WARNING: Purge X number of most recent/oldest items. #>
Get-PnPRecycleBinItem | Select -Last 0 | Clear-PnPRecycleBinItem -Force
Get-PnPRecycleBinItem | Select -First 0 | Clear-PnPRecycleBinItem -Force

<# #>
...
