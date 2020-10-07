<#
.SYNOPSIS
Connect to Security & Compliance.
.NOTES
.LINK
https://docs.microsoft.com/en-us/powershell/module/exchange/connect-ippssession?view=exchange-ps
#>

<# QUICKRUN: Install and Connect to S&C via the EXO v2 module. #>
#Set-ExecutionPolicy RemoteSigned;
$Me = "admin@mytenant.onmicrosoft.com";
#Install-Module ExchangeOnlineManagement -Confirm:$false -Force;
Import-Module ExchangeOnlineManagement;
Connect-IPPSSession -UserPrincipalName $Me;

<# Connect to Security & Compliance. #>
$Me = "";
Connect-IPPSSession -UserPrincipalName $Me;

<# Connect to Security & Compliance using stored creds. #>
$Me = "";
$Creds = Get-Credential -UserName $Me -Message "Login";
Connect-IPPSSession -UserPrincipalName $Me -Credential $Creds;

<# Connect to Security & Compliance without storing creds. #>
$Me = "";
Connect-IPPSSession -UserPrincipalName $Me -Credential (Get-Credential -UserName $Me -Message "Login");
