<#
.SYNOPSIS
.NOTES
.LINK
#>

<# QUICKRUN: Install and connect to the Teams module. #>
Set-ExecutionPolicy RemoteSigned;
Install-Module MicrosoftTeams -Force -Confirm:$false;
Import-Module MicrosoftTeams;
$Me = "";
Connect-MicrosoftTeams -AccountId $Me;


<# Get the members of a specific Team and copy them over to another one. #>
$CopyOwners = $true;
$CopyMembers = $true;
$CopyGuests = $true;

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

<# Confirmation? #>
Get-TeamUser -GroupId $DestTeamId;
