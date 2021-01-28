<#
.SYNOPSIS
Manage the upgrade status of the tenant and users.
.NOTES
.LINK
https://docs.microsoft.com/en-us/powershell/module/skype/grant-csteamsupgradepolicy?view=skype-ps
https://docs.microsoft.com/en-us/powershell/module/skype/get-csteamsupgradestatus?view=skype-ps
https://docs.microsoft.com/en-us/MicrosoftTeams/upgrade-plan-journey-evaluate-environment
#>

<# QUICKRUN: Install the Teams module and connect to SFBO. #>
$Tenant = "mytenant";
#nstall-Module MicrosoftTeams -Force -Confirm:$false;
Import-Module MicrosoftTeams;
$Session_Sfb = New-CsOnlineSession -OverrideAdminDomain "$Tenant.onmicrosoft.com";
Import-PSSession $Session_Sfb -AllowClobber;

<# Upgrade Tenant to Teams. #>
Grant-CsTeamsUpgradePolicy -PolicyName "UpgradeToTeams" -Global;

<# Confirm the current tenant upgrade status. #>
Get-CsTeamsUpgradeStatus

<# Upgrade one specific user to Teams. #>
$User = "";
Grant-CsTeamsUpgradePolicy -PolicyName "UpgradeToTeams" -Identity $User;

<# Confirm the current Upgrade mode on a specific user. #>
Get-CsOnlineUser -Identity $User | select UserPrincipalName,TeamsUpgradeEffectiveMode;

<# Upgrade all users to Teams. #>
Get-CsOnlineUser | % {Grant-CsTeamsUpgradePolicy -Identity $_.Identity -PolicyName "UpgradeToTeams" -ErrorAction SilentlyContinue;}

<# Interactive selection of the Upgrade mode to assign on all users. #>
$ListTeamUpgradeModes = ("Islands","Allows a single user to evaluate both clients side by side. Chats and calls can land in either client, so users must always run both clients.","IslandsWithNotify","SfBOnly","SfBOnlyWithNotify","SfBOnlyWithNotify","SfBWithTeamsCollabWithNotify","SfBWithTeamsCollabAndMeetings","SfBWithTeamsCollabAndMeetingsWithNotify","Global";
$UpgradeMode = $ListTeamUpgradeModes | Out-GridView -OutputMode Single -Title "Select a Teams Upgrade Mode.";
Get-CsOnlineUser | % {Grant-CsTeamsUpgradePolicy -Identity $_.Identity -PolicyName "UpgradeToTeams" -ErrorAction SilentlyContinue;}

<# Confirm the current Upgrade mode of all individual users. #>
Get-CsOnlineUser | select UserPrincipalName,TeamsUpgradeEffectiveMode | Out-GridView;
