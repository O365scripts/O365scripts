<#
.NOTES
.LINK
https://docs.microsoft.com/en-us/powershell/module/skype/grant-csteamsupgradepolicy?view=skype-ps
#>

<# Upgrade Tenant to Teams. #>
Grant-CsTeamsUpgradePolicy -PolicyName "UpgradeToTeams" -Global;

<# Upgrade one specific user to Teams. #>
$User = "";
Grant-CsTeamsUpgradePolicy -PolicyName "UpgradeToTeams" -Identity $User;

<# Upgrade all users to Teams. #>
Get-CsOnlineUser | % {Grant-CsTeamsUpgradePolicy -Identity $_.Identity -PolicyName "UpgradeToTeams" -ErrorAction SilentlyContinue;}

<# Select the Upgrade mode to assign on all users. #>
$ListTeamUpgradeModes = ("Islands","Allows a single user to evaluate both clients side by side. Chats and calls can land in either client, so users must always run both clients.","IslandsWithNotify","SfBOnly","SfBOnlyWithNotify","SfBOnlyWithNotify","SfBWithTeamsCollabWithNotify","SfBWithTeamsCollabAndMeetings","SfBWithTeamsCollabAndMeetingsWithNotify","Global";
$UpgradeMode = $ListTeamUpgradeModes | Out-GridView -OutputMode Single -Title "Select a Teams Upgrade Mode.";
Get-CsOnlineUser | % {Grant-CsTeamsUpgradePolicy -Identity $_.Identity -PolicyName "UpgradeToTeams" -ErrorAction SilentlyContinue;}
