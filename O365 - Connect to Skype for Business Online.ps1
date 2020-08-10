<#
.SYNOPSIS
Connect to Skype for Business Online PowerShell

.NOTES
 > Download Skype for Business PowerShell module: https://www.microsoft.com/en-us/download/details.aspx?id=39366
 > Adjust the $me variable with your global admin's address.
 > Make sure the $PSVersionTable is at least 5.1, otherwise proceed with updating the Windows Management Framework.
 > In some cases, local DNS will prevent connectivity to the proper endpoint which can be enforced by using the -OverrideAdminDomain flag.

.LINK
https://www.microsoft.com/en-us/download/details.aspx?id=39366
https://docs.microsoft.com/en-us/SkypeForBusiness/set-up-your-computer-for-windows-powershell/download-and-install-the-skype-for-business-online-connector
https://docs.microsoft.com/en-us/SkypeForBusiness/set-up-your-computer-for-windows-powershell/set-up-your-computer-for-windows-powershell
https://docs.microsoft.com/en-us/SkypeForBusiness/troubleshoot/hybrid-conferencing/cant-connect-to-sfb-remote-powershell
#>

<# Connect to Skype for Business Online. #>
$me = "admin@tenantname.onmicrosoft.com";
Import-Module SkypeOnlineConnector;
$session_sfb = New-CsOnlineSession -UserName $me;
Import-PSSession $session_sfb;


<# Connect to Skype for Business Online and override endpoint. #>
$me = "admin@tenantname.onmicrosoft.com";
$tenant = "tenantname";
Import-Module SkypeOnlineConnector;
$session_sfb = New-CsOnlineSession -UserName $me -OverrideAdminDomain "$tenant.onmicrosoft.com";
Import-PSSession $session_sfb;


<# Close SFB session and clear credentials? #>
Remove-PSSession $session_sfb;
$creds = $null;


<# Connect to Skype for Business Online without MFA enabled but store credentials. #>
$me = "";
$creds = Get-Credential -UserName $me -Message "Login:";
Import-Module SkypeOnlineConnector;
$session_sfb = New-CsOnlineSession -UserName $me -Credential $creds;
Import-PSSession $session_sfb;


<# Connect to Skype for Business Online without MFA and witout storing credentials. #>
$me = "";
Import-Module SkypeOnlineConnector;
$session_sfb = New-CsOnlineSession -UserName $me -Credential (Get-Credential -UserName $me -Message "Login:");
Import-PSSession $session_sfb;


<# TROUBLESHOOTING #>

<# PS version up to date? #>
<# Basic authentatication enabled? #>

<# Skype for Business module installed? #>
Get-Module SkypeOnlineConnector -ListAvailable;

<# Import SFB module directly from expected path? #>
Import-Module ($env:ProgramFiles + "\\Common Files\\Skype for Business Online\\Modules\\SkypeOnlineConnector\\SkypeOnlineConnector.psd1");

<# #>

$session_sfb = New-CsOnlineSession -UserName $me `
    -OverrideAdminUri "$tenant.onmicrosoft.com" ` # DNS issues?
    -Credential (Get-Credential -UserName $me -Message "Login:") ` # MFA disabled.
    -SessionOption (New-PSSessionOption -IdleTimeoutMSec (30 *60*1000)) ` # Custom timeout?
    ;

