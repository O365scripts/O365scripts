<#
.SYNOPSIS
    Connecto to Microsoft Teams PowerShell
.NOTES
    You will need to specify the TeamsEnvironmentName when connecting to a GCC High or a DOD tenant (TeamsGCCH or TeamsDOD).
    Use the TenantId attribute when connecting to a different tenant.
    Use the LogFilePath and LogLevel when reporting bugs.
.LINK
    https://www.powershellgallery.com/packages/MicrosoftTeams/
    https://docs.microsoft.com/en-us/powershell/module/teams/connect-microsoftteams?view=teams-ps
#>

<#  Install module as administrator? #>
Install-Module -Name MicrosoftTeams -Force;

<#  Install module as user? #>
Install-Module -Name MicrosoftTeams -Scope CurrentUser -Force;

<# Connect to Teams #>
    $me = "admin@domain.onmicrosoft.com";
Connect-MicrosoftTeams -AccountId $me

<# Connect to Teams without MFA. #>
    $me = "admin@domain.onmicrosoft.com";
$creds = Get-Credential -Message "Login:" -UserName $me;
Connect-MicrosoftTeams -AccountId $me -Credential $creds;

<# Connect to Teams without MFA but do not store credentials. #>
    $me = "user@domain.com";
Connect-MicrosoftTeams -AccountId $me -Credential (Get-Credential -Message "Login:" -UserName $me);

<# Disconnect session? #>
Disconnect-MicrosoftTeams;
