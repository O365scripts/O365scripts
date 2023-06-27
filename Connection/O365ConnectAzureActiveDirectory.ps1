<#
.SYNOPSIS
Connect to Azure Active Directory v2.
https://github.com/O365scripts/O365scripts/blob/master/Connection/O365ConnectAzureActiveDirectory.ps1

.NOTES
In most cases, the regular AzureAD module should be used over the Preview one. Especially in production scenarios.

.LINK
Reference:
https://learn.microsoft.com/powershell/azure/active-directory/install-adv2
https://learn.microsoft.com/powershell/module/azuread/connect-azuread
https://learn.microsoft.com/powershell/module/azuread/disconnect-azuread
https://learn.microsoft.com/powershell/module/azuread/
#>

# Connect to Azure AD.
#Set-ExecutionPolicy RemoteSigned -Force -Confirm:$false
Install-Module AzureAD -AllowClobber -Force -Confirm:$false
#Update-Module AzureAD -Force -Confirm:$false
Import-Module AzureAD
$AdminUpn = ""
Connect-AzureAD -AccountId $AdminUpn

# Connect to Azure AD without MFA and use stored credentials.
$AdminUpn = ""
$Creds = Get-Credential -UserName $AdminUpn -Message "Login:"
Connect-AzureAD -AccountId $AdminUpn -Credential $Creds

# Azure AD/Preview module installed?
Get-Module AzureAD* -ListAvailable | Select Name,Version

# Install module as non-admin user?
Install-Module AzureAD -Scope "CurrentUser" -AllowClobber -Force -Confirm:$false
Install-Module AzureADPreview -Scope "CurrentUser" -AllowClobber -Force -Confirm:$false

# Update Azure AD/Preview module?
Update-Module AzureAD -Confirm:$false -Force
Update-Module AzureADPreview -Confirm:$false -Force

# Remove Azure AD/Preview module?
Uninstall-Module AzureAD -AllVersions -Confirm:$false -Force
Uninstall-Module AzureADPreview -AllVersions -Confirm:$false -Force

# Close session?
$Creds = $null; Disconnect-AzureAD
