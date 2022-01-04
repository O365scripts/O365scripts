<#
.SYNOPSIS
(link)
.NOTES
.LINK
https://docs.microsoft.com/en-us/powershell/module/exchange/organization/enable-organizationcustomization?view=exchange-ps
https://docs.microsoft.com/en-us/powershell/module/exchange/get-organizationconfig?view=exchange-ps
https://docs.microsoft.com/en-us/powershell/module/exchange/set-organizationconfig?view=exchange-ps
https://docs.microsoft.com/en-us/microsoft-365/compliance/enable-unlimited-archiving?view=o365-worldwide
#>

<# Connect to EXO v2. #>
#Set-ExecutionPolicy RemoteSigned -Force -Confirm:$false;
#Install-Module ExchangeOnlineManagement -AllowClobber -Force -Confirm:$false;
$AdminUpn = "";
Connect-ExchangeOnline -UserPrincipalName $AdminUpn;

<# Hydrate tenant, one time only. #>
Enable-OrganizationCustomization;

<# Enable auto-expanding archiving for your entire organization. #>
Set-OrganizationConfig -AutoExpandingArchive;

<# Verify current organization configuration. #>
Get-OrganizationConfig;