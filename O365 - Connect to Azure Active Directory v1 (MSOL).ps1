<#
.SYNOPSIS
    Connect to MSOL.
.NOTES
    MSOL vs AZUREAD
    There are two versions of the PowerShell module that you use to connect to Office 365 and administer user accounts, groups, and licenses:
        Azure Active Directory PowerShell for Graph (cmdlets include AzureAD in their name)
        Microsoft Azure Active Directory Module for Windows PowerShell (cmdlets include MSol in their name)
    MSOL PS CORE
    PowerShell Core does not support the Microsoft Azure Active Directory Module for Windows PowerShell module and cmdlets with Msol in their name. 
    ENVIRONMENT
    The AzureEnvironment flag must be specified when connecting to a german, chinese or government tenant.
        AzureGermanyCloud
        AzureChinaCloud
        USGovernment
    TROUBLESHOOTING
    If you don't receive any errors, you connected successfully.
    There is no command to disconnect from this service (MSOL).
.LINK
    https://docs.microsoft.com/en-us/office365/enterprise/powershell/connect-to-office-365-powershell
    https://docs.microsoft.com/en-us/office365/enterprise/powershell/manage-office-365-with-office-365-powershell
    https://www.microsoft.com/en-us/download/details.aspx?id=54616
#>

<# Install module as administrator? #>
Install-Module MSOnline -Force -Confirm:$false;
<# Install module as user? #>
Install-Module MSOnline -Scope CurrentUser -Force -Confirm:$false;

<# Connect to MSOL. #>
    $me = "admin@domain.onmicrosoft.com";
Connect-MsolService;

<# Connect to MSOL without MFA. #>
    $me = "admin@domain.onmicrosoft.com";
$creds = Get-Credential -UserName $me -Message "Login:";
Connect-MsolService -Credential $creds;
<# Clear credential object? #>
$creds = null;

<# Connect to MSOL without MFA or storing credentials. #>
    $me = "admin@domain.onmicrosoft.com";
Connect-MsolService -Credential (Get-Credential -UserName $me -Message "Login:");
