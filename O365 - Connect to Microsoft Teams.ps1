<#
.SYNOPSIS
	Connect to Microsoft Teams PowerShell
.NOTES
 > You will need to specify the -TeamsEnvironmentName when connecting to a GCC High or a DOD tenant (TeamsGCCH or TeamsDOD).
 > Use the TenantId attribute when connecting to a different tenant.
 > Use the -LogFilePath and -LogLevel when reporting bugs.
.LINK
https://www.powershellgallery.com/packages/MicrosoftTeams/
https://docs.microsoft.com/en-us/powershell/module/teams/connect-microsoftteams?view=teams-ps
#>

<# Install the Teams module as administrator? #>
Install-Module MicrosoftTeams -Force -Confirm:$false;
<# Install the Teams module as user? #>
Install-Module MicrosoftTeams -Scope CurrentUser -Force -Confirm:$false;
<# Force reinstallation of the Teams module? #>
Remove-Module MicrosoftTeams -Force -Confirm:$false -ErrorAction SilentlyContinue; Install-Module MicrosofTeams -Force -Confirm:$false;

<# Connect to Teams? #>
$me = "admin@domain.onmicrosoft.com";
Connect-MicrosoftTeams -AccountId $me;

<# Connect to Teams without using MFA but cache credentials? #>
$me = "admin@domain.onmicrosoft.com";
$creds = Get-Credential -Message "Login:" -UserName $me;
Connect-MicrosoftTeams -AccountId $me -Credential $creds;
<#$creds = $null;#>

<# Connect to Teams without using MFA and without caching credentials? #>
$me = "admin@domain.onmicrosoft.com";
Connect-MicrosoftTeams -AccountId $me -Credential (Get-Credential -Message "Login:" -UserName $me);

<# Disconnect session? #>
Disconnect-MicrosoftTeams;
