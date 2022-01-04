<#
.SYNOPSIS
https://github.com/O365scripts/O365scripts/blob/master/Microsoft%20Teams/Teams%20-%20Team%20Overview.ps1
.NOTES
.LINK
#>

<# Connect to Teams. #>
#Set-ExecutionPolicy RemoteSigned -Force -Confirm:$false;
#Install-Module MicrosoftTeams -AllowClobber -Force -Confirm:$false;
Import-Module MicrosoftTeams;
Connect-MicrosoftTeams;

#rite-Host -NoNewline "# of X"; Write-Host -Fore Yellow $ListX.Count;
Write-Host -NoNewline "# of Teams"; Write-Host -Fore Yellow $ListAllTeams.Count;

# Team picker?
$ListTeams = Get-Team | Out-GridView -PassThru;

# Change visibility on Teams to public/private.
$ListTeams | $ {Set-Team -GroupId $_.GroupId -Visibility "Public"};
$ListTeams | $ {Set-Team -GroupId $_.GroupId -Visibility "Private"};


<# Pull some numbers! #>
$StampNow = Get-Date -Format "yyyyMMddHHmmss";
$ListAllTeams = Get-Team;
$TotalTeams = $ListAllTeams.Count;
$CountTeamsPublic = (Get-Team -Visibility Public).Count;
$CountTeamsPrivate = (Get-Team -Visibility Private).Count;

# List all members of all teams.
Get-Team | % {Write-Host -Fore Yellow $_.DisplayName; Get-TeamUser -GroupId $_.GroupId};

#rite-Host -NoNewline "# of X"; Write-Host -Fore Yellow $ListX.Count;