<#
.SYNOPSIS
Connect to MSOL.
https://github.com/O365scripts/O365scripts/blob/master/Connection/O365%20-%20Connect%20to%20Microsoft%20Online%20(MSOL%20v1).ps1
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
Reference:
https://docs.microsoft.com/en-us/office365/enterprise/powershell/connect-to-office-365-powershell
https://docs.microsoft.com/en-us/office365/enterprise/powershell/manage-office-365-with-office-365-powershell
https://docs.microsoft.com/en-us/powershell/azure/active-directory/install-msonlinev1?view=azureadps-1.0
#>

<# Connect to MSOL. #>
#Set-ExecutionPolicy RemoteSigned -Force -Confirm:$false;
#Install-Module MSOnline -Scope CurrentUser -AllowClobber -Force -Confirm:$false;
Import-Module MSOnline;
Connect-MsolService;

<# Connect to MSOL without MFA. #>
$AdminUpn = ""; $Creds = Get-Credential -UserName $AdminUpn -Message "Login:";
Connect-MsolService -Credential $Creds;

<# Connect to MSOL without using MFA and without caching credentials. #>
$AdminUpn = ""; Connect-MsolService -Credential (Get-Credential -UserName $AdminUpn -Message "Login:");

<# Install the MSOL module as a regular user. #>
Install-Module MSOnline -Scope CurrentUser -AllowClobber -Force -Confirm:$false;

<# Completely uninstall the MSOL module. #>
Uninstall-Module MSOnline -AllVersions -Force -Confirm:$false -ErrorAction SilentlyContinue;
