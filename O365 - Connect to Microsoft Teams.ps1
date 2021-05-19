<#
.SYNOPSIS
Connect to Microsoft Teams PowerShell
.NOTES
 > The recent Teams module versio
 > You will need to specify the -TeamsEnvironmentName when connecting to a GCC High or a DOD tenant (TeamsGCCH or TeamsDOD).
 > Use the TenantId attribute when connecting to a different tenant.
 > Use the -LogFilePath and -LogLevel when reporting bugs.
.LINK
https://www.powershellgallery.com/packages/MicrosoftTeams/
https://docs.microsoft.com/en-us/powershell/module/teams/connect-microsoftteams?view=teams-ps
#>

<# Connect to Teams. #>
#Set-ExecutionPolicy RemoteSigned
#Install-Module MicrosoftTeams -Force -Confirm:$false
Import-Module MicrosoftTeams;
Connect-MicrosoftTeams;

<# Connect to Teams without MFA enabled using cached credentials. #>
$AdminUpn = "admin@domain.com";
$Creds = Get-Credential -Message "Login:" -UserName $AdminUpn;
Import-Module MicrosoftTeams;
Connect-MicrosoftTeams -Credential $Creds;
<#$creds = $null;#>

<# Connect to Teams without MFA enabled and without caching credentials. #>
$me = "admin@domain.com";
Connect-MicrosoftTeams -Credential (Get-Credential -Message "Login:" -UserName $me);


<# Confirm Teams module version(s) installed. #>
Get-Module MicrosoftTeams -ListAvailable | Select Version;

<# Force uninstallation of the Teams module. #>
#Remove-Module MicrosoftTeams -Force -Confirm:$false -ErrorAction SilentlyContinue;

<# Disconnect session? #>
Disconnect-MicrosoftTeams;
