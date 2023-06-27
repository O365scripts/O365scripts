<#
.SYNOPSIS
Connect to Skype for Business Online PowerShell (Deprecated)
https://github.com/O365scripts/O365scripts/blob/master/Connection/O365ConnectSkypeForBusinessOnlineDeprecated.ps1

.NOTES
> The Skype for Business module has been deprecated.
> Use the Connect-MicrosoftTeams command if you wish to run Cs/CsOnline commands.
> Make sure the $PSVersionTable is at least 5.1, otherwise proceed with updating the Windows Management Framework.
> In some cases, local DNS will prevent connectivity to the proper endpoint which can be enforced by using the -OverrideAdminDomain flag.

.LINK
https://learn.microsoft.com/microsoftteams/teams-powershell-install
https://learn.microsoft.com/SkypeForBusiness/set-up-your-computer-for-windows-powershell/download-and-install-the-skype-for-business-online-connector
Previous:
https://learn.microsoft.com/SkypeForBusiness/set-up-your-computer-for-windows-powershell/set-up-your-computer-for-windows-powershell
https://learn.microsoft.com/SkypeForBusiness/troubleshoot/hybrid-conferencing/cant-connect-to-sfb-remote-powershell
#>

# Connect to Skype for Business Online via the previous SFB module.
$AdminUpn = ""
Import-Module SkypeOnlineConnector
$Session_Sfb = New-CsOnlineSession -UserName $AdminUpn
Import-PSSession $Session_Sfb

# Connect to Skype for Business Online and override endpoint.
$AdminUpn = ""; $Tenant = ""
Import-Module SkypeOnlineConnector
$Session_Sfb = New-CsOnlineSession -UserName $AdminUpn -OverrideAdminDomain "$Tenant.onmicrosoft.com"
Import-PSSession $session_Sfb

# Close SFB session and clear credentials?
Remove-PSSession $Session_Sfb; $Creds = $null;
