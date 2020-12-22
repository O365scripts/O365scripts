<#
.NOTES
.LINK
https://docs.microsoft.com/en-us/powershell/module/exchange/enable-organizationcustomization?view=exchange-ps
#>

<# QUICKRUN: Install and Connect to EXO v2. #>
$Me = "admin@tenantname.onmicrosoft.com";
Set-ExecutionPolicy RemoteSigned;
Install-Module ExchangeOnlineManagement -Confirm:$false;
Import-Module ExchangeOnlineManagement;
Connect-ExchangeOnline -UserPrincipalName $me;

<# Force hydration of the tenant. #>
Enable-OrganizationCustomization
