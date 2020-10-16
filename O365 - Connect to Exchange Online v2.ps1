<#
.SYNOPSIS
Connect to Exchange Online v2 PowerShell.

.NOTES
  > The EXO V2 module uses Modern authentication for all cmdlets.
  > You can't use Basic authentication in the EXO V2 module; however, you still need to configure the Basic authentication setting in WinRM.
  > The latest version of PowerShell that's currently supported for the EXO V2 module is PowerShell 5.1.
  > Support for PowerShell 6.0 or later is currently a work in progress and will be released soon.
  > This also implies that EXO PowerShell V2 module won't work in Linux or Mac as of now.

.LINK
https://docs.microsoft.com/en-us/powershell/exchange/exchange-online/exchange-online-powershell-v2/exchange-online-powershell-v2?view=exchange-ps
https://www.powershellgallery.com/packages/exchangeonlinemanagement/
https://docs.microsoft.com/en-us/powershell/module/exchange/connect-exchangeonline?view=exchange-ps
https://docs.microsoft.com/en-us/powershell/module/exchange/disconnect-exchangeonline?view=exchange-ps
#>

<# QUICKRUN: Install and Connect to EXO v2. #>
$Me = "admin@tenantname.onmicrosoft.com";
Set-ExecutionPolicy RemoteSigned;
Install-Module ExchangeOnlineManagement -Confirm:$false;
Import-Module ExchangeOnlineManagement;
Connect-ExchangeOnline -UserPrincipalName $me;

<# Connect to EXO v2. #>
$Me = "";
Connect-ExchangeOnline -UserPrincipalName $Me;


<# Connect to EXO v2 using stored credentials. #>
$Me = "";
$Creds = Get-Credential -UserName $Me -Message "Login:";
Connect-ExchangeOnline -Credential $Creds;

<# Connect to EXO v2 without using stored credentials. #>
$Me = "";
Connect-ExchangeOnline -Credential (Get-Credential -UserName $Me -Message "Login:");

<# Connect to EXO v2 and output full debug logs to desktop to. #>
$Me = "";
$PathLog = "$env:USERPROFILE\Desktop\";
Connect-ExchangeOnline -UserPrincipalName $Me -EnableErrorReporting -LogLevel All -LogDirectoryPath $PathLog;

<# Disconnect? #>
#$Creds = null;
#Disconnect-ExchangeOnline -Confirm:$false;



<#
INSTALLATION / TROUBLESHOOTING
#>

<# Install EXO v2 module as administrator. #>
#Install-Module ExchangeOnlineManagement -Confirm:$false;

<# Install EXO v2 module as a non-admin user? #>
#Install-Module ExchangeOnlineManagement -Scope CurrentUser -Confirm:$false;

<# Uninstall EXO v2 module? #>
#Remove-Module ExchangeOnlineManagement -Force -Confirm:$false;

<# Force Update PSGet? #>
#Install-Module PowerShellGet -Force -Confirm:$false;



<#
UNATTENDED CONNECTIONS
#>

<# Connect to EXO v2 using a public key certificate. #>
$Tenant = "tenantname"; $AppId = "";
$PathCert = "";
Connect-ExchangeOnline -AppId $AppId -CertificateFilePath $PathCert -Organization "$Tenant.onmicrosoft.com";

<# Connect to EXO v2 using a certificate thumbprint. #>
$Tenant = "tenantname"; $AppId = "";
$CertThumb = "";
Connect-ExchangeOnline -AppId $AppId -CertificateThumbprint $CertThumb -Organization "$Tenant.onmicrosoft.com";

<# Connect to EXO v2 using a certificate thumbprint. #>
$Tenant = "tenantname"; $AppId = "";
$Cert = "";
Connect-ExchangeOnline -AppId $AppId -Certificate $Cert -Organization "$Tenant.onmicrosoft.com";
