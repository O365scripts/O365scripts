<#
.SYNOPSIS
Teams Visibility Management
.NOTES
.LINK
https://docs.microsoft.com/en-us/powershell/module/teams/set-team?view=teams-ps
https://support.microsoft.com/en-us/office/make-a-public-team-private-in-teams-6f324fbc-6599-4612-8daa-ff5d35a746bf
#>

<# Set the visibility of a Team to Public/Private. #>
$TeamMail = "team@domain.com";
$TeamId = (Get-Team -MailNickName $TeamMail).GroupId;
Set-Team -GroupId $TeamId -Visibility "Public";
Set-Team -GroupId $TeamId -Visibility "Private";
