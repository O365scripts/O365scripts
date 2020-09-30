<#
.SYNOPSIS
Connect to Skype for Business Online PowerShell

.NOTES
 > The latest MicrosoftTeams module now includes the New-CsOnlineSession which can be used to connect to SFBO.
 > This means you do not need to download and install the Skype for Business setup from: 
 > Make sure the $PSVersionTable is at least 5.1, otherwise proceed with updating the Windows Management Framework.
 > In some cases, local DNS will prevent connectivity to the proper endpoint which can be enforced by using the -OverrideAdminDomain flag.

.LINK
https://docs.microsoft.com/en-us/microsoftteams/teams-powershell-install
https://docs.microsoft.com/en-us/SkypeForBusiness/troubleshoot/hybrid-conferencing/cant-connect-to-sfb-remote-powershell
https://docs.microsoft.com/en-us/SkypeForBusiness/set-up-your-computer-for-windows-powershell/set-up-your-computer-for-windows-powershell

Previous:
https://www.microsoft.com/en-us/download/details.aspx?id=39366
https://docs.microsoft.com/en-us/SkypeForBusiness/set-up-your-computer-for-windows-powershell/download-and-install-the-skype-for-business-online-connector
#>

<# QUICKRUN: Install the Teams module and connect to SFBO. #>
$me = "admin@mytenant.onmicrosoft.com";
$tenant = "mytenant";
Install-Module MicrosoftTeams -Force -Confirm:$false;
$session_sfb = New-CsOnlineSession -OverrideAdminDomain "$tenant.onmicrosoft.com";
Import-PSSession $session_sfb -AllowClobber;

<# Connect to Skype for Business Online. #>
$me = "";
#Import-Module SkypeOnlineConnector;
$session_sfb = New-CsOnlineSession -UserName $me;
Import-PSSession $session_sfb -AllowClobber;


<# Connect to Skype for Business Online and override endpoint. #>
$me = "admin@mytenant.onmicrosoft.com";
$tenant = "mytenant";
Import-Module MicrosoftTeams;
$session_sfb = New-CsOnlineSession -OverrideAdminDomain "$tenant.onmicrosoft.com";
Import-PSSession $session_sfb -AllowClobber;

<# Close SFB session and clear credentials? #>
#Remove-PSSession $session_sfb;
#$creds = $null;

<# Connect to Skype for Business Online without MFA enabled but store credentials. #>
$me = "";
$creds = Get-Credential -UserName $me -Message "Login:";
#Import-Module SkypeOnlineConnector;
$session_sfb = New-CsOnlineSession -UserName $me -Credential $creds;
Import-PSSession $session_sfb;

<# Connect to Skype for Business Online without MFA and witout storing credentials. #>
$me = "";
#Import-Module SkypeOnlineConnector;
$session_sfb = New-CsOnlineSession -UserName $me -Credential (Get-Credential -UserName $me -Message "Login:");
Import-PSSession $session_sfb;


<# TROUBLESHOOTING #>
<#
PS version up to date? #>
Basic authentatication enabled?
#>
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

