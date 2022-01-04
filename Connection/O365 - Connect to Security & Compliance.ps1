<#
.SYNOPSIS
Connect to Security & Compliance PowerShell.
https://github.com/O365scripts/O365scripts/blob/master/Connection/O365%20-%20Connect%20to%20Security%26Compliance.ps1
.NOTES
.LINK
Reference:
https://docs.microsoft.com/en-us/powershell/module/exchange/connect-ippssession?view=exchange-ps
#>

<# Connect to Security & Compliance. #>
#Set-ExecutionPolicy RemoteSigned -Force -Confirm:$false;
#Install-Module MicrosoftTeams -AllowClobber -Force -Confirm:$false;
Import-Module ExchangeOnlineManagement;
$AdminUpn = "";
Connect-IPPSSession -UserPrincipalName $AdminUpn;

<# Connect to Security & Compliance without MFA. #>
$AdminUpn = ""; $Creds = Get-Credential -UserName $AdminUpn -Message "Login";
Connect-IPPSSession -UserPrincipalName $AdminUpn -Credential $Creds;

<# Connect to Security & Compliance without MFA and without caching credentials. #>
Connect-IPPSSession -UserPrincipalName $AdminUpn -Credential (Get-Credential -UserName $AdminUpn -Message "Login");
