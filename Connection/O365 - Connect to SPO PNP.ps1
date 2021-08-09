<#
.SYNOPSIS
Connect to SharePoint Online PnP

.NOTES
SharePoint Patterns and Practices (PnP) contains a library of PS commands (PnP PowerShell) that allows you to perform complex provisioning and artifact management actions towards SharePoint.
The commands use CSOM and can work against both SharePoint Online as SharePoint On-Premises.

.LINK
https://docs.microsoft.com/en-us/powershell/sharepoint/sharepoint-pnp/sharepoint-pnp-cmdlets?view=sharepoint-ps   
https://docs.microsoft.com/en-us/powershell/module/sharepoint-pnp/connect-pnponline?view=sharepoint-ps
https://docs.microsoft.com/en-us/powershell/module/sharepoint-pnp/?view=sharepoint-ps
#>

<# Install SharePoint Online PnP module as admin? #>
Install-Module SharePointPnPPowerShellOnline -Force;
<# Install SharePoint Online PnP module as user? #>
Install-Module SharePointPnPPowerShellOnline -Scope CurrentUser -Force;


<# Connect to a SPO Site using SharePoint Online PnP. #>
$tenant = "tenantname";
$pnp_site = "https://${tenant}.sharepoint.com/sites/TeamSiteName";
Connect-PnPOnline -Url $pnp_site;

<# Connect to a ODFB Site using SharePoint Online PnP. #>
$tenant = "";
$pnp_site = "https://${tenant}.sharepoint.com/personal/user_domain_com/";   
Connect-PnPOnline -Url $pnp_site;


<# Connect to SharePoint Online PnP using stored credentials. #>
$me = "admin@tenantname.onmicrosoft.com";
$tenant = "tenantname";
$pnp_site = "https://${tenant}.sharepoint.com/";
$creds = Get-Credential -UserName $me -Message "Login:";
Connect-PnPOnline -Url $pnp_site -Credentials $creds;
#$creds = $null;


<# Disconnect session? #>
Disconnect-PnPOnline;

