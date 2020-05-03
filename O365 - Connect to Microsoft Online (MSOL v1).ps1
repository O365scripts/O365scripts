<#
.SYNOPSIS
    Connect to MSOL.

.NOTES
 > There are two versions of the PowerShell module that you use to connect to Office 365 and administer user accounts, groups, and licenses:
	+ Microsoft Azure Active Directory Module for Windows PowerShell (cmdlets include MSol in their name, v1)
	+ Azure Active Directory PowerShell for Graph (cmdlets include AzureAD in their name, v2)
 > The AzureEnvironment flag must be specified when connecting to a german, chinese or government tenant.
	+ AzureGermanyCloud
	+ AzureChinaCloud
	+ USGovernment
 > PowerShell Core does not support the MSOL module.
 > There is no command to disconnect from MSOL.

.LINK
https://docs.microsoft.com/en-us/office365/enterprise/powershell/connect-to-office-365-powershell
https://docs.microsoft.com/en-us/office365/enterprise/powershell/manage-office-365-with-office-365-powershell
https://www.microsoft.com/en-us/download/details.aspx?id=54616
#>

<# Install the MSOL module as administrator? #>
Install-Module MSOnline -Force -Confirm:$false;
<# Install the MSOL module as user? #>
Install-Module MSOnline -Scope CurrentUser -Force -Confirm:$false;
<# Force reinstallation of the MSOL module? #>
Remove-Module MSOnline -Force -Confirm:$false -ErrorAction SilentlyContinue; Install-Module MSOnline -Force -Confirm:$false;

<# Connect to MSOL with or without using MFA? #>
Connect-MsolService;

<# Connect to MSOL without using MFA but cache credentials? #>
$me = "admin@domain.onmicrosoft.com";
$creds = Get-Credential -UserName $me -Message "Login:";
Connect-MsolService -Credential $creds;
<#$creds = null#>

<# Connect to MSOL without using MFA and without caching credentials? #>
$me = "admin@domain.onmicrosoft.com";
Connect-MsolService -Credential (Get-Credential -UserName $me -Message "Login:");
