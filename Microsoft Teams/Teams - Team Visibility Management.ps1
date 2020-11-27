<#
.SYNOPSIS
.NOTES
.LINK
https://docs.microsoft.com/en-us/powershell/module/teams/set-team?view=teams-ps
#>

<# Set the visibility of a Team to Public/Private. #>
$TeamMail = "team@domain.com";
$TeamId = (Get-Team -MailNickName $TeamMail).GroupId;
Set-Team -GroupId $TeamId -Visibility "Public";
Set-Team -GroupId $TeamId -Visibility "Private";
