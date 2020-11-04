<#
.SYNOPSIS
.NOTES
.LINK
#>

<# QUICKRUN: Install the Teams module and connect to SFBO. #>
$Me = "admin@mytenant.onmicrosoft.com";
$Tenant = "mytenant";
Install-Module MicrosoftTeams -Force -Confirm:$false;
$Session_Sfb = New-CsOnlineSession -OverrideAdminDomain "$Tenant.onmicrosoft.com";
Import-PSSession $Session_Sfb;

<# Skype/Teams User Overview. #>
$User = "user@domain.com";
$Path_CsvOut = "$env:USERPROFILE\Desktop"; 
Get-CsOnlineUser -Identity $User -ErrorAction SilentlyContinue | Out-File -FilePath "$Path_CsvOut\Get-CsOnlineUser__$($User.Replace("@","_"))_$Stamp.csv";
Get-CsOnlineVoiceUser -Identity $User -ErrorAction SilentlyContinue | Out-File -FilePath "$Path_CsvOut\Get-CsOnlineVoiceUser__$($User.Replace("@","_"))_$Stamp.csv";
Get-CsOnlineDialInConferencingUser -Identity $User -ErrorAction SilentlyContinue | Out-File -FilePath "$Path_CsvOut\CsOnlineDialInConferencingUser__$($User.Replace("@","_"))_$Stamp.csv";
Get-CsOnlineApplicationInstance -Identity $User -ErrorAction SilentlyContinue | Out-File -FilePath "$Path_CsvOut\CsOnlineApplicationInstance__$($User.Replace("@","_"))_$Stamp.csv";
Get-CsUser -Identity $User -ErrorAction SilentlyContinue | Out-File -FilePath "$Path_CsvOut\Get-CsUser__$($User.Replace("@","_"))_$Stamp.csv";
