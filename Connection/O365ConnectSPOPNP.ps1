<#
.SYNOPSIS
Connect to SharePoint Online PnP.

.NOTES
- The SharePointPnPPowerShellOnline module has been deprecated and the PnP.PowerShell module should be used instead.
- You will have to consent/register the PnP Management Shell Multi-Tenant Azure AD Application in your own tenant once using Register-PnPManagementShellAccess.

.LINK
https://pnp.github.io/powershell/articles/connecting.html
https://docs.microsoft.com/en-us/powershell/module/sharepoint-pnp/?view=sharepoint-ps
https://docs.microsoft.com/en-us/powershell/module/sharepoint-pnp/connect-pnponline?view=sharepoint-ps
https://docs.microsoft.com/en-us/powershell/sharepoint/sharepoint-pnp/sharepoint-pnp-cmdlets?view=sharepoint-ps   
#>

# Connect to SharePoint PnP.
#Set-ExecutionPolicy RemoteSigned -Force -Confirm:$false
Install-Module PnP.PowerShell -AllowClobber -Force -Confirm:$false
#Update-Module PnP.PowerShell -Force -Confirm:$false
Import-Module PnP.PowerShell
#Register-PnPManagementShellAccess
$Tenant = ""
$PnpSite = ""
#   $PnpSite = "https://${Tenant}.sharepoint.com/"
#   $PnpSite = "https://${Tenant}.sharepoint.com/sites/SiteName"
#   $PnpSite = "https://${Tenant}-admin.sharepoint.com/"
#   $PnpSite = "https://${Tenant}-my.sharepoint.com/personal/user_domain_com"
Connect-PnPOnline -Url $PnpSite -Interactive

# Confirm which PNP module version(s) is present?
Get-InstalledModule PnP.PowerShell -ErrorAction SilentlyContinue | Select Name,Version
Get-InstalledModule SharePointPnPPowerShell* -ErrorAction SilentlyContinue | Select Name,Version

# Update the PNP module.
Update-Module PnP.PowerShell -Force -Confirm:$false

# Install the PNP module as regular user?
Install-Module PnP.PowerShell -Scope CurrentUser -AllowClobber -Force -Confirm:$false

# Remove all previous versions of the old PNP module.
Get-InstalledModule SharePointPnPPowerShell* | % {Uninstall-Module -Name $_.Name -AllVersions -Force -Confirm:$false -WhatIf}
#Uninstall-Module SharePointPnPPowerShellOnline -AllVersions -Force -Confirm:$false
#Uninstall-Module SharePointPnPPowerShell2019 -AllVersions -Force -Confirm:$false
#Uninstall-Module SharePointPnPPowerShell2016 -AllVersions -Force -Confirm:$false
#Uninstall-Module SharePointPnPPowerShell2013 -AllVersions -Force -Confirm:$false

# Connect to PNP and cache credentials (no MFA).
$AdminUpn = ""
$Tenant = ""
$PnpSite = ""
$Creds = Get-Credential -UserName $AdminUpn -Message "Login"
Connect-PnPOnline -Url $PnpSite -Credentials $Creds
#$Creds = $null; Disconnect-PnPOnline

# Connect to PNP without caching credentials (no MFA).
Connect-PnPOnline -Url $PnpSite -Credentials (Get-Credential -UserName $AdminUpn -Message "Login")

# Install the old PNP module (deprecated).
Install-Module SharePointPnPPowerShellOnline -Force -Confirm:$false -WhatIf
Install-Module SharePointPnPPowerShell2019 -Force -Confirm:$false -WhatIf
Install-Module SharePointPnPPowerShell2016 -Force -Confirm:$false -WhatIf
Install-Module SharePointPnPPowerShell2013 -Force -Confirm:$false -WhatIf
