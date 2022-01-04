<#
.SYNOPSIS
Teams Enterprise Voice
https://github.com/O365scripts/O365scripts/blob/master/Microsoft%20Teams/Teams%20-%20Enterprise%20Voice.ps1
.NOTES
	> Phone System is included in E5 but needs to be added for every other
	> Usually due to licensing:
		+ Cannot modify the parameter: "EnterpriseVoiceEnabled" because it is restricted for the user service plan: MCOStandard.
		+ Cannot modify the parameter: "EnterpriseVoiceEnabled" because it is restricted for the user service plan: MCOProfessional.
		+ Cannot modify the parameter: "EnterpriseVoiceEnabled" because it is restricted for the user service plan: MCO_TEAMS_IW.
	> Common error when target is a Resource Account:
		+ Management object not found for identity "12345678-1234-5678-1234-56781234678".
.LINK
Reference:
https://docs.microsoft.com/microsoftteams/here-s-what-you-get-with-phone-system
https://docs.microsoft.com/en-us/microsoftteams/troubleshoot/teams-conferencing/no-dial-pad
https://docs.microsoft.com/en-us/microsoftteams/setting-up-your-phone-system
https://docs.microsoft.com/en-us/microsoftteams/calling-plans-for-office-365
#>

<# Connect to Teams. #>
#Set-ExecutionPolicy RemoteSigned -Force -Confirm:$false;
#Install-Module MicrosoftTeams -AllowClobber -Force -Confirm:$false;
Import-Module MicrosoftTeams;
Connect-MicrosoftTeams;


<# Toggle EV on a specific user (wait an hour+ in between). #>
$User = "";
Set-CsUser -Identity $User -EnterpriseVoiceEnabled $false;
Set-CsUser -Identity $User -EnterpriseVoiceEnabled $true;


<# Interactive selection of users to enable or disable Enerprise Voice. #>
$ListUsers = Get-CsOnlineUser | Select ObjectId,UserPrincipalName,EnterpriseVoiceEnabled,InterpretedUserTpe | Sort EnterpriseVoiceEnabled,UserPrincipalName |Out-GridView -PassThru;
$ListUsers | % {Write-Host -NoNewLine "Attempting to disable EV on "; Write-Host -Fore Yellow $_.UserPrincipalName; Set-CsUser -Identity $_.ObjectId -EnterpriseVoiceEnabled $false -ErrorAction Continue;}
$ListUsers | % {Write-Host -NoNewLine "Attempting to enable EV on "; Write-Host -Fore Yellow $_.UserPrincipalName; Set-CsUser -Identity $_.ObjectId -EnterpriseVoiceEnabled $true -ErrorAction Continue;}


<# WARNING: Enable or Disable Enterprise Voice for all users. #>
Get-CsOnlineUser | % {Write-Host -NoNewLine "Attempting to enable EV on "; Write-Host -Fore Yellow $_.UserPrincipalName; Set-CsUser -Identity $_.ObjectId -EnterpriseVoiceEnabled $true -ErrorAction Continue;}
Get-CsOnlineUser | % {Write-Host -NoNewLine "Attempting to disable EV on "; Write-Host -Fore Yellow $_.UserPrincipalName; Set-CsUser -Identity $_.ObjectId -EnterpriseVoiceEnabled $false -ErrorAction Continue;}
