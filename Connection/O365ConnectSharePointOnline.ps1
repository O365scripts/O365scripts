<#
.SYNOPSIS
Connecting to SharePoint Online
https://github.com/O365scripts/O365scripts/blob/master/Connection/O365ConnectSharePointOnline.ps1

.NOTES
Connect-SPOService
    You must be a SharePoint Online global administrator to run the cmdlet.
    Only a single SharePoint Online service connection is maintained from any single Windows PowerShell session.
    In other words, this is a per-organization administrator connection.
    Running the Connect-SPOService cmdlet twice implicitly disconnects the previous connection.
    The Windows PowerShell session will be set to serve the new SharePoint Online global administrator specified.
    A delegated partner administrator has to swap connections for different organizations within the same Windows PowerShell session.

.LINK
https://learn.microsoft.com/powershell/sharepoint/sharepoint-online/connect-sharepoint-online
#>

# Connect to SharePoint Online.
#Set-ExecutionPolicy RemoteSigned -Force -Confirm:$false
Install-Module Microsoft.Online.SharePoint.PowerShell -AllowClobber -Force -Confirm:$false
#Update-Module Microsoft.Online.SharePoint.PowerShell -Force -Confirm:$false
Import-Module Microsoft.Online.SharePoint.PowerShell
$Tenant = "tenantname"
Connect-SPOService -Url "https://${Tenant}-admin.sharepoint.com"

# Module installed?
Get-Module -Name Microsoft.Online.SharePoint.PowerShell -ListAvailable | Select Name,Version

# Install SharePoint Online module as administrator.
Install-Module Microsoft.Online.SharePoint.PowerShell -Force -Confirm:$false

# Install SharePoint Online module as user?
Install-Module Microsoft.Online.SharePoint.PowerShell -Scope CurrentUser -Force -Confirm:$false

# Update SharePoint Online module.
Update-Module Microsoft.Online.SharePoint.PowerShell -Force -Confirm:$false

# Connect to SharePoint Online.
$tenant = "tenantname";
Connect-SPOService -Url "https://${tenant}-admin.sharepoint.com";

# Connect to SharePoint Online using stored credentials.
$AdminUpn = "admin@tenantname.onmicrosoft.com"
$Tenant = "tenantname"
$Creds = Get-Credential -UserName $AdminUpn -Message "Login:"
Connect-SPOService -Url "https://${Tenant}-admin.sharepoint.com" -Credential $Creds
#$creds = $null

# Connect to SharePoint Online without storing credentials.
$AdminUpn = "admin@tenantname.onmicrosoft.com"
$Tenant = "tenantname"
Connect-SPOService -Url "https://${Tenant}-admin.sharepoint.com" -Credential (Get-Credential -UserName $AdminUpn -Message "Login:")
