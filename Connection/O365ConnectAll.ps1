<#
.SYNOPSIS
Connect to the most common Office 365 PowerShell services.
https://github.com/O365scripts/O365scripts/blob/master/Connection/O365ConnectAll.ps1

.NOTES
- Use the sections below as needed to build a multi-service connection script.
- Adjust the $AdminUpn value with the address of the admin account, leave blank for regular prompt.
- Adjust the $Tenant value with the initial tenant name (without the .onmicrosoft.com).
- Note that Exchange Online and Security & Compliance can't be connected at the same time (use one or the other).

.LINK
https://learn.microsoft.com/microsoft-365/enterprise/connect-to-all-microsoft-365-services-in-a-single-windows-powershell-window
#>

$AdminUpn = ""
$Tenant = "tenantname"

# System.
#Set-ExecutionPolicy RemoteSigned -Force -Confirm:$false
#[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
#Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
#Install-Module PowerShellGet -Force -Confirm:$false
Update-Module PowerShellGet -Force -Confirm:$false


# Connect to Azure AD.
Install-Module AzureAD -Force -Confirm:$false
Update-Module AzureAD -Force -Confirm:$false
Import-Module AzureAD
Connect-AzureAD -AccountId $AdminUpn

# Connect to AIP.
Install-Module AIPService -Force -Confirm:$false
Update-Module AIPService -Force -Confirm:$false
Import-Module AIPService
Connect-AIPService -UserPrincipalName $AdminUpn
#Connect-AipService -Credential $AdminUpn

# Connect to EXO.
Install-Module ExchangeOnlineManagement -Force -Confirm:$false
Update-Module ExchangeOnlineManagement -Force -Confirm:$false
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -UserPrincipalName $AdminUpn

# Connect to MSOL.
Install-Module MSOnline -Force -Confirm:$false
Update-Module MSOnline -Force -Confirm:$false
Import-Module MSOnline
Connect-MsolService

# Connect to Security & Compliance.
#Install-Module ExchangeOnlineManagement -Force -Confirm:$false
Update-Module ExchangeOnlineManagement -Force -Confirm:$false
Import-Module ExchangeOnlineManagement
Connect-IPPSSession -UserPrincipalName $AdminUpn

# Connect to SharePoint Online.
Install-Module Microsoft.Online.SharePoint.PowerShell -Force -Confirm:$false
Update-Module Microsoft.Online.SharePoint.PowerShell -Force -Confirm:$false
Import-Module Microsoft.Online.SharePoint.PowerShell
Connect-SPOService -Url "https://${Tenant}-admin.sharepoint.com"

# Connect to Teams.
Install-Module MicrosoftTeams -Force -Confirm:$false
Update-Module MicrosoftTeams -Force -Confirm:$false
Import-Module MicrosoftTeams
Connect-MicrosoftTeams
