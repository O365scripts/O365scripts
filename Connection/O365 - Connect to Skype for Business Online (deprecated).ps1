<#
.SYNOPSIS
Connect to Skype for Business Online PowerShell

.NOTES
 > The latest MicrosoftTeams module now includes the New-CsOnlineSession which can be used to connect to SFBO.
 > This means you do not need to download and install the Skype for Business EXE setup to connect.
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


<# Connect to SFBO using the previous Teams module version.
Verify if the the v2.0 Teams module is present and uninstall it if necessary.
Make sure to restart PS if you do need to uninstall it.
Install the previous 1.1.6 version since the 2.0 does not have the New-CsOnlineSession command and then connect.
#>
Get-Module MicrosoftTeams -ListAvailable | Select Version;
#Uninstall-Module MicrosoftTeams -AllVersions;
#Install-Module MicrosoftTeams -RequiredVersion 1.1.6;
Import-Module MicrosoftTeams -RequiredVersion 1.1.6;
$Session_Sfb = New-CsOnlineSession -OverrideAdminDomain "contoso.onmicrosoft.com";
Import-PSSession $Session_Sfb;


<# QUICKRUN: Install the Teams module and connect to SFBO. #>
#Set-ExecutionPolicy RemoteSigned;
#Install-Module MicrosoftTeams -Force -Confirm:$false;
Import-Module MicrosoftTeams;
$Session_Sfb = New-CsOnlineSession -OverrideAdminDomain "contoso.onmicrosoft.com";
Import-PSSession $Session_Sfb;


<# Connect to Skype for Business Online via Teams module. #>
Import-Module MicrosoftTeams;
#Import-Module SkypeOnlineConnector;
$Session_Sfb = New-CsOnlineSession;
Import-PSSession $Session_Sfb -AllowClobber;

<# Connect to Skype for Business Online via the previous SFB module. #>
$Me = "";
Import-Module SkypeOnlineConnector;
$session_sfb = New-CsOnlineSession -UserName $me;
Import-PSSession $Session_Sfb;

<# Connect to Skype for Business Online and override endpoint. #>
$Me = "";
$Tenant = "mytenant";
$session_sfb = New-CsOnlineSession -OverrideAdminDomain "$tenant.onmicrosoft.com";
Import-PSSession $session_sfb;

<# Close SFB session and clear credentials? #>
#Remove-PSSession $session_sfb;
#$Creds = $null;

<# Connect to Skype for Business Online without MFA enabled but store credentials. #>
$me = "";
$Creds = Get-Credential -UserName $me -Message "Login:";
#Import-Module SkypeOnlineConnector;
$Session_Sfb = New-CsOnlineSession -UserName $me -Credential $creds;
Import-PSSession $Session_Sfb;

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

