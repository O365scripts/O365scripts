<#
.SYNOPSIS
Connect to Exchange Online PowerShell.
https://github.com/O365scripts/O365scripts/blob/master/Connection/O365ConnectExchangeOnline.ps1

.NOTES
- The EXO v2 module uses Modern authentication for all cmdlets.
- You can't use Basic authentication in the EXO V2 module; however, you still need to configure the Basic authentication setting in WinRM.
- The latest version of PowerShell that's currently supported for the EXO V2 module is PowerShell 5.1.

LINK
https://learn.microsoft.com/powershell/exchange/exchange-online/exchange-online-powershell-v2/exchange-online-powershell-v2
https://www.powershellgallery.com/packages/exchangeonlinemanagement/
https://learn.microsoft.com/powershell/module/exchange/connect-exchangeonline
https://learn.microsoft.com/powershell/module/exchange/disconnect-exchangeonline
#>

# Connect to EXO.
#Set-ExecutionPolicy RemoteSigned -Force -Confirm:$false
#Install-Module PowerShellGet -Force -Confirm:$false
Install-Module ExchangeOnlineManagement -AllowClobber -Force -Confirm:$false
#Update-Module ExchangeOnlineManagement -Force -Confirm:$false
Import-Module ExchangeOnlineManagement
$AdminUpn = ""
Connect-ExchangeOnline -UserPrincipalName $AdminUpn

# Connect to EXO without MFA.
$AdminUpn = ""; $Creds = Get-Credential -UserName $AdminUpn -Message "Login:"
Connect-ExchangeOnline -Credential $Creds

# Connect to EXO without MFA and without caching credentials.
Connect-ExchangeOnline -Credential (Get-Credential -UserName $AdminUpn -Message "Login:")

# Connect to EXO and send full debug logs to the Downloads folder.
$AdminUpn = ""; $PathLogExo = "$env:USERPROFILE\Downloads\"
Connect-ExchangeOnline -UserPrincipalName $AdminUpn -EnableErrorReporting -LogLevel All -LogDirectoryPath $PathLogExo

# Disconnect?
$Creds = $null; Disconnect-ExchangeOnline -Confirm:$false

# Install EXO module as a non-admin user?
Install-Module ExchangeOnlineManagement -Scope CurrentUser -Confirm:$false

# Confirm EXO module version(s) installed?
Get-Module ExchangeOnlineManagement -ListAvailable | Select Version

# Update the EXO module.
Update-Module ExchangeOnlineManagement -Force -Confirm:$false

# Force Update PSGet?
Install-Module PowerShellGet -Force -Confirm:$false

# Uninstall EXO module?
Uninstall-Module ExchangeOnlineManagement -AllVersions -Force -Confirm:$false -WhatIf

# Connect to EXO GCCH.
Connect-ExchangeOnline -ExchangeEnvironmentName O365USGovGCCHigh

# Connect to EXO DOD.
Connect-ExchangeOnline -ExchangeEnvironmentName O365USGovDoD

# Connect to EXO Germany.
Connect-ExchangeOnline -ExchangeEnvironmentName O365GermanyCloud

# Connect to EXO China.
Connect-ExchangeOnline -ExchangeEnvironmentName O365China

# Connect to EXO using a public key certificate.
$Tenant = "tenantname"; $AppId = ""; $PathCert = ""
Connect-ExchangeOnline -AppId $AppId -CertificateFilePath $PathCert -Organization "$Tenant.onmicrosoft.com"

# Connect to EXO using a certificate thumbprint.
$Tenant = ""; $AppId = ""; $CertThumb = ""
Connect-ExchangeOnline -AppId $AppId -CertificateThumbprint $CertThumb -Organization "$Tenant.onmicrosoft.com"

# Connect to EXO using a certificate thumbprint.
$Tenant = ""; $AppId = ""; $Cert = ""
Connect-ExchangeOnline -AppId $AppId -Certificate $Cert -Organization "$Tenant.onmicrosoft.com"
