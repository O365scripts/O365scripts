<#
.SYNOPSIS
Manage the upgrade status of the tenant and users.

.NOTES
Skype for Business Online will be retired on July 31, 2021.
You can 
.LINK
https://docs.microsoft.com/en-us/microsoftteams/skype-for-business-online-retirement
https://docs.microsoft.com/en-us/microsoftteams/teams-and-skypeforbusiness-coexistence-and-interoperability
https://docs.microsoft.com/en-us/powershell/module/skype/grant-csteamsupgradepolicy?view=skype-ps
https://docs.microsoft.com/en-us/powershell/module/skype/get-csteamsupgradestatus?view=skype-ps
https://docs.microsoft.com/en-us/MicrosoftTeams/upgrade-plan-journey-evaluate-environment
https://docs.microsoft.com/en-us/microsoftteams/upgrade-assisted
#>

<# Connect to Teams. #>
#Set-ExecutionPolicy RemoteSigned;
#Install-Module MicrosoftTeams -Force -Confirm:$false;
Import-Module MicrosoftTeams;
Connect-MicrosoftTeams;


<# Confirm the current tenant upgrade status. #>
Get-CsTeamsUpgradeStatus;


<# Upgrade tenant to Teams. #>
Grant-CsTeamsUpgradePolicy -PolicyName "UpgradeToTeams" -Global;


<# Upgrade a specific user to Teams. #>
$User = "";
Grant-CsTeamsUpgradePolicy -PolicyName "UpgradeToTeams" -Identity $User;

<# Confirm the current Upgrade mode of a specific user. #>
$User = "";
Get-CsOnlineUser -Identity $User | select UserPrincipalName,TeamsUpgradeEffectiveMode;


<# Upgrade all users to Teams. #>
Get-CsOnlineUser | % {Grant-CsTeamsUpgradePolicy -Identity $_.Identity -PolicyName "UpgradeToTeams" -ErrorAction SilentlyContinue;}


<# Interactive selection of the Upgrade mode to assign on all users. #>
$ListTeamUpgradeModes = ("Islands","Allows a single user to evaluate both clients side by side. Chats and calls can land in either client, so users must always run both clients.","IslandsWithNotify","SfBOnly","SfBOnlyWithNotify","SfBOnlyWithNotify","SfBWithTeamsCollabWithNotify","SfBWithTeamsCollabAndMeetings","SfBWithTeamsCollabAndMeetingsWithNotify","Global";
$UpgradeMode = $ListTeamUpgradeModes | Out-GridView -OutputMode Single -Title "Select a Teams Upgrade Mode.";
Get-CsOnlineUser | % {Grant-CsTeamsUpgradePolicy -Identity $_.Identity -PolicyName "UpgradeToTeams" -ErrorAction SilentlyContinue;}

<# Change the upgrade status on all users not currently upgraded. #>
$ListUserNotUpgraded = Get-CsOnlineUser | Where {$_.TeamsUpgradeEffectiveMode -ne "TeamsOnly"};
$ListUserNotUpgraded | % {Grant-CsTeamsUpgradePolicy -Identity $_.Identity -PolicyName UpgradeToTeams -ErrorAction SilentlyContinue;}
$ListUserNotUpgraded | Export-Csv "CsOnlineUserNotUpgradedToTeams.csv" -Encoding utf8 -NoTypeInformation;

<# Confirm the current Upgrade mode of all individual users. #>
$ListUser = Get-CsOnlineUser | select UserPrincipalName,TeamsUpgradeEffectiveMode;
$ListUser | Out-GridView;
$ListUser | Export-Csv "CsOnlineUserTeamsUpgrade.csv" -Encoding utf8 -NoTypeInformation;
