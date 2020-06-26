<#
.SYNOPSIS
Teams Channel Management

.NOTES
The Teams Preview module is required to be able to use the TeamChannelUser commands.

.LINK
https://docs.microsoft.com/en-us/powershell/module/teams/get-team?view=teams-ps
https://docs.microsoft.com/en-us/powershell/module/teams/Get-TeamChannelUser?view=teams-ps
https://docs.microsoft.com/en-us/powershell/module/teams/Add-TeamChannelUser?view=teams-ps
https://docs.microsoft.com/en-us/powershell/module/teams/Remove-TeamChannelUser?view=teams-ps

https://docs.microsoft.com/en-us/microsoftteams/install-prerelease-teams-powershell-module
#>


<# Uninstall previous Teams module, add the repo and install the Teams preview module? #>
Uninstall-Module -Name MicrosoftTeams;
Register-PSRepository -Name PSGalleryInt -SourceLocation "https://www.poshtestgallery.com/" -InstallationPolicy Trusted;
Install-Module -Name MicrosoftTeams -Repository PSGalleryInt -Force;

<# Connect to Teams. #>
$me = "";
Connect-MicrosoftTeams -AccountId $me;



<# Interactive: Get the GroupId of a single Team. #>
$team_id = (Get-Team | Out-GridView -OutputMode Single).GroupId;

<# Interactive: Get the details of one or multiple channels of a specifc Team. #>
$list_chan = Get-TeamChannel -GroupId $team_id | Out-GridView -PassThru ;
#$list_chan = Get-TeamChannel -GroupId $team_id -MembershipType "Private" | Out-GridView -PassThru ;
#$list_chan = Get-TeamChannel -GroupId $team_id -MembershipType "Public" | Out-GridView -PassThru ;

<# Pass through the list of selected channels to remove and readd members. #>
$list_chan | % {
	$list_chanusers = Get-TeamChannelUser -GroupId $team_id -DisplayName $_.DisplayName;
	<# Debug? #><#
	Write-Host -NoNewline "Channel DisplayName: "; Write-Host -Fore Yellow $_.DisplayName;
	Write-Host "Channel Users: ";
	$list_chanusers;

	$path_csv = "Teams Channel Members Output " + $_DisplayName + ".csv";
	$list_chanusers | Export-Csv -NoTypeInformation -Path $path_csv;
	#>
	$chan_display = $_.DisplayName;
	if ($list_chanusers -is [system.array])
		{
		foreach ($u in $list_chanusers)
			{
			if ($u.Role -ne "Owner")
				{
				Write-Host -NoNewline "Removing and readding <";
					Write-Host -NoNewline -Fore Yellow $u.User;
					Write-Host -NoNewline "> from the <";
					Write-Host -NoNewline -Fore Yellow $chan_display;
					Write-Host "> channel.";
				#Remove-TeamChannelUser -GroupId $team_id -DisplayName $chan_display -User $u.user -ErrorAction Continue;
				#Add-TeamChannelUser -GroupId $team_id -DisplayName $chan_display -User $u.user -ErrorAction Continue;
				}
			}
		#$chan_display = "";
		}
	}
