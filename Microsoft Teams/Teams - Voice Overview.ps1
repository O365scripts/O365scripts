<#
.SYNOPSIS
Teams/Skype Voice User Overview
(link)
.NOTES
.LINK
#>

<# Connect to Teams. #>
#Set-ExecutionPolicy RemoteSigned -Force -Confirm:$false;
#Install-Module MicrosoftTeams -AllowClobber -Force -Confirm:$false;
Import-Module MicrosoftTeams;
Connect-MicrosoftTeams;

<# Conferencing. #>
Get-CsOnlineDialinConferencingTenantConfiguration;
Get-CsOnlineDialInConferencingTenantSettings;
Get-CsOnlineDialInConferencingBridge;
Get-CsOnlineDialinConferencingPolicy;
Get-CsTeamsAudioConferencingPolicy

<# User Count. #>
$NumUsers = (Get-CsOnlineUser).Count;
$NumVoiceUsers = (Get-CsOnlineVoiceUser).Count;
$NumAudioConfUsers = (Get-CsOnlineDialInConferencingUser).Count;
Write-Host -NoNewLine "# of Users: "; Write-Host -Fore Yellow $NumUsers;
Write-Host -NoNewLine "# of Voice Users: "; Write-Host -Fore Yellow $NumAudioConfUsers;
Write-Host -NoNewLine "# of Conferencing Users: "; Write-Host -Fore Yellow $NumVoiceUsers;

<# #>
Get-CsOnlineSipDomain;

<# Direct Routing? #>
Get-CsOnlinePSTNGateway;
Get-CsOnlineVoiceRoute;
Get-CsOnlineVoiceRoutingPolicy;
Get-CsOnlinePstnUsage;
Get-CsTeamsTranslationRule

<# #>
Get-CsTeamsMeetingPolicy;
Get-CsTeamsCallingPolicy;
#Get-CsTeamsAppPermissionPolicy;
Get-CsTeamsCallHoldPolicy
Get-CsTeamsCallParkPolicy
Get-CsTeamsComplianceRecordingApplication
#Get-CsTeamsCortanaPolicy
Get-CsTeamsGuestCallingConfiguration
Get-CsTeamsEmergencyCallingPolicy
Get-CsTeamsGuestMeetingConfiguration
Get-CsTeamsMobilityPolicy

Get-CsOnlineTelephoneNumber
Get-CsTeamsTranslationRule
Get-CsTeamsVdiPolicy
Get-CsTeamsVideoInteropServicePolicy
Get-CsTeamsWorkLoadPolicy
Get-CsTeamsNetworkRoamingPolicy
Get-CsTeamsShiftsPolicy
