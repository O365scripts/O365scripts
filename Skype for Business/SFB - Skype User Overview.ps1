<#
.SYNOPSIS
.NOTES
.LINK
#>

<# QUICKRUN: Install the Teams module and connect to SFBO. #>
$Tenant = "mytenant";
#Set-ExecutionPolicy RemoteSigned;
#Install-Module MicrosoftTeams -Force -Confirm:$false;
Import-Module MicrosoftTeams;
$Session_Sfb = New-CsOnlineSession -OverrideAdminDomain "$Tenant.onmicrosoft.com";
Import-PSSession $Session_Sfb;

<# Prevent output truncation... #>
$FormatEnumerationLimit = -1;

<# Export Skype/Teams User Overview. #>
$User = "user@domain.com";
$Stamp = Get-Date -Format "yyyyMMddHHmmss";
Get-CsOnlineUser -Identity $User -ErrorAction SilentlyContinue | Out-File -Encoding utf8 -FilePath "$env:USERPROFILE\Desktop\Get-CsOnlineUser__$($User.Replace("@","_"))_$Stamp.txt";
#Get-CsOnlineVoiceUser -Identity $User -ErrorAction SilentlyContinue | Out-File -FilePath "$Path_CsvOut\Get-CsOnlineVoiceUser__$($User.Replace("@","_"))_$Stamp.txt";
#Get-CsOnlineDialInConferencingUser -Identity $User -ErrorAction SilentlyContinue | Out-File -FilePath "$Path_CsvOut\Get-CsOnlineDialInConferencingUser__$($User.Replace("@","_"))_$Stamp.txt";
#Get-CsOnlineApplicationInstance -Identity $User -ErrorAction SilentlyContinue | Out-File -FilePath "$Path_CsvOut\Get-CsOnlineApplicationInstance__$($User.Replace("@","_"))_$Stamp.txt";
#Get-CsUser -Identity $User -ErrorAction SilentlyContinue | Out-File -Encoding utf8 -FilePath "$env:USERPROFILE\Desktop\Get-CsUser__$($User.Replace("@","_"))_$Stamp.txt";
