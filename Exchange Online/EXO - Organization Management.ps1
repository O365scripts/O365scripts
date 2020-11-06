<#
.NOTES
.LINK
https://docs.microsoft.com/en-us/powershell/module/exchange/organization/enable-organizationcustomization?view=exchange-ps
https://docs.microsoft.com/en-us/powershell/module/exchange/get-organizationconfig?view=exchange-ps
https://docs.microsoft.com/en-us/powershell/module/exchange/set-organizationconfig?view=exchange-ps
https://docs.microsoft.com/en-us/microsoft-365/compliance/enable-unlimited-archiving?view=o365-worldwide
#>

<# QUICKRUN: Install and Connect to EXO v2. #>
$Me = "admin@tenantname.onmicrosoft.com";
#Set-ExecutionPolicy RemoteSigned;
Install-Module ExchangeOnlineManagement -Confirm:$false;
Import-Module ExchangeOnlineManagement;
Connect-ExchangeOnline -UserPrincipalName $Me;

<# Hydrate tenant, one time only. #>
Enable-OrganizationCustomization;

<# Enable auto-expanding archiving for your entire organization. #>
Set-OrganizationConfig -AutoExpandingArchive;

<# Verify current organization configuration. #>
Get-OrganizationConfig;

<# Export Organization Configuration to file. #>
Get-OrganizationConfig | Out-File -Encoding utf8 -FilePath "$env:USERPROFILE\Desktop\Get-OrganizationConfig_$(Get-Date -Format "yyyyMMddHHmmss).txt";
