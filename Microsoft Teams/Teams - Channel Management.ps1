<#
.SYNOPSIS
Teams Channel Management
https://github.com/O365scripts/O365scripts/blob/master/Microsoft%20Teams/Teams%200Team%20Channel%20Management.ps1
.NOTES
	> The Teams Preview module is required to be able to use the TeamChannelUser commands (still applies?).
.LINK
Reference:
https://docs.microsoft.com/en-us/powershell/module/teams/get-team?view=teams-ps
https://docs.microsoft.com/en-us/powershell/module/teams/Get-TeamChannelUser?view=teams-ps
https://docs.microsoft.com/en-us/powershell/module/teams/Add-TeamChannelUser?view=teams-ps
https://docs.microsoft.com/en-us/powershell/module/teams/Remove-TeamChannelUser?view=teams-ps
https://docs.microsoft.com/en-us/microsoftteams/install-prerelease-teams-powershell-module
#>

<# Uninstall previous Teams module, add the repo and install the Teams preview module? #>
#Uninstall-Module -Name MicrosoftTeams -Force -Confirm:$false;
#Register-PSRepository -Name PSGalleryInt -SourceLocation "https://www.poshtestgallery.com/" -InstallationPolicy Trusted;
#Install-Module -Name MicrosoftTeams -Repository PSGalleryInt -Force;

<# Connect to Teams. #>
#Set-ExecutionPolicy RemoteSigned -Force -Confirm:$false;
#Install-Module MicrosoftTeams -AllowClobber -Force -Confirm:$false;
Import-Module MicrosoftTeams;
Connect-MicrosoftTeams;

<# Interactive: Get the GroupId of a single Team. #>
$TeamId = (Get-Team | Out-GridView -OutputMode Single).GroupId;

<# Interactive: Get the details of one or multiple channels of a specifc Team. #>
$ListChan = Get-TeamChannel -GroupId $TeamId | Out-GridView -PassThru ;
#$list_chan = Get-TeamChannel -GroupId $team_id -MembershipType "Private" | Out-GridView -PassThru ;
#$list_chan = Get-TeamChannel -GroupId $team_id -MembershipType "Public" | Out-GridView -PassThru ;

<# Pass through the list of selected channels to remove and readd members. #>
$ListChan | % {
	$ListChanUsers = Get-TeamChannelUser -GroupId $TeamId -DisplayName $_.DisplayName;
	<# Debug? #><#
	Write-Host -NoNewline "Channel DisplayName: "; Write-Host -Fore Yellow $_.DisplayName;
	Write-Host "Channel Users: "; $ListChanUsers;
	$PathCsv = "Teams Channel Members Output " + $_.DisplayName + ".csv";
	$ListChanUsers | Export-Csv -NoTypeInformation -Path $PathCsv;
	#>
	$ChanDisplay = $_.DisplayName;
	if ($ListChanUsers -is [system.array])
		{
		foreach ($u in $ListChanUsers)
			{
			if ($u.Role -ne "Owner")
				{
				Write-Host -NoNewline "Removing and readding <";
					Write-Host -NoNewline -Fore Yellow $u.User;
					Write-Host -NoNewline "> from the <";
					Write-Host -NoNewline -Fore Yellow $ChanDisplay;
					Write-Host "> channel.";
				#Remove-TeamChannelUser -GroupId $TeamId -DisplayName $ChanDisplay -User $u.user -ErrorAction Continue;
				#Add-TeamChannelUser -GroupId $TeamId -DisplayName $ChanDisplay -User $u.user -ErrorAction Continue;
				}
			}
		#$ChanDisplay = "";
		}
	}
