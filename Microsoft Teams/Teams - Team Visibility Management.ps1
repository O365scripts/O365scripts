<#
.SYNOPSIS
Teams Visibility Management
https://github.com/O365scripts/O365scripts/blob/master/Microsoft%20Teams/Teams%20-%20Team%20Visibility%20Management.ps1
.NOTES
	> A private channel cannot be set to public.
.LINK
https://docs.microsoft.com/en-us/powershell/module/teams/set-team?view=teams-ps
https://support.microsoft.com/en-us/office/make-a-public-team-private-in-teams-6f324fbc-6599-4612-8daa-ff5d35a746bf
#>

<# Connect to Teams. #>
#Set-ExecutionPolicy RemoteSigned -Force -Confirm:$false;
#Install-Module MicrosoftTeams -AllowClobbr -Force -Confirm:$false;
Import-Module MicrosoftTeams;
Connect-MicrosoftTeams;

<# Set the visibility of a Team to Public/Private. #>
$TeamMail = "team@domain.com";
$TeamId = (Get-Team -MailNickName $TeamMail).GroupId;
Set-Team -GroupId $TeamId -Visibility "Public";
Set-Team -GroupId $TeamId -Visibility "Private";

<# Confirm current visibility setting is set on a Team or Channel. #>
# ...
Get-Team -GroupId $TeamId;