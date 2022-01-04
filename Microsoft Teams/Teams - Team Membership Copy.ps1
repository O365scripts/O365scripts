<#
.SYNOPSIS
Copy the current membership of a team onto another.
https://github.com/O365scripts/O365scripts/blob/master/Microsoft%20Teams/Teams%20-Team%20to%20Team%20Member%20Copy.ps1
.NOTES
	> This is a basic example of copying existing members from one team to another.
	> It does not do remove existing members of destination team not present in source team (ie: replication).
.LINK
#>

<# Connect to Teams. #>
#Set-ExecutionPolicy RemoteSigned -Force -Confirm:$false;
#Install-Module MicrosoftTeams -AllowClobbr -Force -Confirm:$false;
Import-Module MicrosoftTeams;
Connect-MicrosoftTeams;

<# Interactive: Select source team to pull members from and add in destination team. #>
$CopyOwners = $true; $CopyMembers = $true; $CopyGuests = $true;
$SourceTeamId = (Get-Team | Out-GridView -OutputMode Single).GroupId;
$DestTeamId = (Get-Team | Where {$_.GroupId -ne $SourceTeamId} | Out-GridView -OutputMode Single).GroupId;
if ($CopyOwners -eq $true) {
	$ListOwners = Get-TeamUser -GroupId $SourceTeamId -Role Owner;
	$ListOwners | % {Add-TeamUser -GroupId $DestTeamId -User $_.UserId -Role Owner}
}
if ($CopyMembers -eq $true) {
	$ListMembers = Get-TeamUser -GroupId $SourceTeamId -Role Member;
	$ListMembers | % {Add-TeamUser -GroupId $DestTeamId -User $_.UserId}
}
if ($CopyGuests -eq $true) {
	$ListGuests = Get-TeamUser -GroupId $SourceTeamId -Role Guest;
	$ListGuests | % {Add-TeamUser -GroupId $DestTeamId -User $_.UserId}
}

<# Confirm? #>
Get-TeamUser -GroupId $SourceTeamId;
Get-TeamUser -GroupId $DestTeamId;

Get-Team -GroupId $SourceTeamId;
Get-Team -GroupId $DestTeamId;