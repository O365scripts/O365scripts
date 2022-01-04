<#
.SYNOPSIS
Connecting to SharePoint Online

.NOTES
Connect-SPOService
    You must be a SharePoint Online global administrator to run the cmdlet.
    Only a single SharePoint Online service connection is maintained from any single Windows PowerShell session.
    In other words, this is a per-organization administrator connection.
    Running the Connect-SPOService cmdlet twice implicitly disconnects the previous connection.
    The Windows PowerShell session will be set to serve the new SharePoint Online global administrator specified.
    A delegated partner administrator has to swap connections for different organizations within the same Windows PowerShell session.

.LINK
https://docs.microsoft.com/en-us/powershell/sharepoint/sharepoint-online/connect-sharepoint-online?view=sharepoint-ps
#>

<# Install SharePoint Online module as administrator? #>
Install-Module Microsoft.Online.SharePoint.PowerShell;
<# Install SharePoint Online module as user? #>
Install-Module Microsoft.Online.SharePoint.PowerShell -Scope CurrentUser;
<# Module installed? #>
Get-Module -Name Microsoft.Online.SharePoint.PowerShell -ListAvailable | Select Name,Version;


<# Connect to SharePoint Online. #>
$tenant = "tenantname";
Connect-SPOService -Url "https://${tenant}-admin.sharepoint.com";

<# Connect to SharePoint Online using stored credentials. #>
$me = "admin@tenantname.onmicrosoft.com";
$tenant = "tenantname";
$creds = Get-Credential -UserName $me -Message "Login:";
Connect-SPOService -Url "https://${tenant}-admin.sharepoint.com" -Credential $creds;
#$creds = $null;

<# Connect to SharePoint Online without storing credentials. #>
$me = "admin@tenantname.onmicrosoft.com";
$tenant = "tenantname";
Connect-SPOService -Url "https://${tenant}-admin.sharepoint.com" -Credential (Get-Credential -UserName $me -Message "Login:");
