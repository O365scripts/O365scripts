<#
.SYNOPSIS
Manage the upgrade status of the tenant and users.
https://github.com/O365scripts/O365scripts/blob/master/Microsoft%20Teams/.ps1
.NOTES
	> Skype for Business Online is officialy retired since July 31, 2021.
	> In some cases, the tenant may be upgraded but not all the individual users so you may need to bulk force everyone to be upgraded.
.LINK
Reference:
https://docs.microsoft.com/en-us/microsoftteams/skype-for-business-online-retirement
https://docs.microsoft.com/en-us/microsoftteams/teams-and-skypeforbusiness-coexistence-and-interoperability
https://docs.microsoft.com/en-us/powershell/module/skype/grant-csteamsupgradepolicy?view=skype-ps
https://docs.microsoft.com/en-us/powershell/module/skype/get-csteamsupgradestatus?view=skype-ps
https://docs.microsoft.com/en-us/MicrosoftTeams/upgrade-plan-journey-evaluate-environment
https://docs.microsoft.com/en-us/microsoftteams/upgrade-assisted
#>

<# Connect to Teams. #>
#Set-ExecutionPolicy RemoteSigned -Force -Confirm:$false;
#Install-Module MicrosoftTeams -AllowClobber -Force -Confirm:$false;
Import-Module MicrosoftTeams;
Connect-MicrosoftTeams;

<# Confirm the current tenant upgrade status (may fail to return anything). #>
Get-CsTeamsUpgradeStatus;

<# Upgrade tenant to Teams. #>
Grant-CsTeamsUpgradePolicy -PolicyName "UpgradeToTeams" -Global;

<# Upgrade a specific user to Teams. #>
$User = "";
Grant-CsTeamsUpgradePolicy -PolicyName "UpgradeToTeams" -Identity $User;

<# Confirm the current Upgrade mode of a specific user. #>
Get-CsOnlineUser -Identity $User | Select UserPrincipalName,TeamsUpgradeEffectiveMode;

<# Get the list of users not upgraded. #>
Get-CsOnlineUser | Where {$_.TeamsUpgradeEffectiveMode -ne "TeamsOnly"} | Select UserPrincipalName,TeamsUpgradeEffectiveMode;

<# Upgrade all users to Teams. #>
$Status = "TeamsOnly";
$Filter = 'TeamsUpgradeEffectiveMode -eq "{0}"' -f $Status
Get-CsOnlineUser -Filter $Filter
Get-CsOnlineUser | Where {$_.TeamsUpgradeEffectiveMode -ne "TeamsOnly"} | % { `
	Write-Host -NoNewLine "Attempting to upgrade user "; Write-Host -NoNewline $_.DisplayName;
	Write-Host -NoNewline " <"; Write-Host -NoNewline -Fore Yellow $_.UserPrincipalName; Write-Host ">.";
	Grant-CsTeamsUpgradePolicy -Identity $_.Identity -PolicyName "UpgradeToTeams" -ErrorAction SilentlyContinue;
}

<# Interactive selection of the Upgrade mode to assign on all users. #>
$ListTeamUpgradeModes = ("Islands","Allows a single user to evaluate both clients side by side. Chats and calls can land in either client, so users must always run both clients.","IslandsWithNotify","SfBOnly","SfBOnlyWithNotify","SfBOnlyWithNotify","SfBWithTeamsCollabWithNotify","SfBWithTeamsCollabAndMeetings","SfBWithTeamsCollabAndMeetingsWithNotify","Global");
$UpgradeMode = $ListTeamUpgradeModes | Out-GridView -OutputMode Single -Title "Select a Teams Upgrade Mode.";
Get-CsOnlineUser | % {Grant-CsTeamsUpgradePolicy -Identity $_.Identity -PolicyName "UpgradeToTeams" -ErrorAction SilentlyContinue;}

<# Change the upgrade status on all users not currently upgraded. #>
$ListUserNotUpgraded = Get-CsOnlineUser | Where {$_.TeamsUpgradeEffectiveMode -ne "TeamsOnly"};
$ListUserNotUpgraded | % {Grant-CsTeamsUpgradePolicy -Identity $_.Identity -PolicyName UpgradeToTeams -ErrorAction SilentlyContinue;}
$ListUserNotUpgraded | Export-Csv "CsOnlineUserNotUpgradedToTeams.csv" -Encoding utf8 -NoTypeInformation;

<# #>
$ListUserUpgraded = Get-CsOnlineUser | Where {$_.TeamsUpgradeEffectiveMode -eq "TeamsOnly"};
$ListUserUpgraded | Select UserPrincipalName,InterpretedUserType,ObjectId;

<# Confirm the current Upgrade mode of all individual users. #>
$ListUser = Get-CsOnlineUser | select UserPrincipalName,TeamsUpgradeEffectiveMode;
$ListUser | Out-GridView;
$ListUser | Export-Csv "CsOnlineUserTeamsUpgrade.csv" -Encoding utf8 -NoTypeInformation;
