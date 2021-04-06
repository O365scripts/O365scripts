<#
.SYNOPSIS
Get Skype User Overview Details
https://github.com/O365scripts/O365scripts/blob/master/Skype%20for%20Business/SFB%20-%20Skype%20User%20Overview.ps1
.NOTES
.LINK
https://docs.microsoft.com/en-us/powershell/module/skype/get-csonlineuser?view=skype-ps
https://docs.microsoft.com/en-us/powershell/module/skype/get-csonlinevoiceuser?view=skype-ps
https://docs.microsoft.com/en-us/powershell/module/skype/get-csonlinedialinconferencinguser?view=skype-ps
#>


<# Install the previous Teams module version and connect to SFBO using CsOnlineSession instead. #>
#Set-ExecutionPolicy RemoteSigned;
#Install-Module MicrosoftTeams -RequiredVersion 1.1.6 -Force -Confirm:$false;
Import-Module MicrosoftTeams -RequiredVersion 1.1.6;
$Session_Sfb = New-CsOnlineSession -OverrideAdminDomain "mytenant.onmicrosoft.com";
Import-PSSession $Session_Sfb;


<# Prevent output truncation... #>
$FormatEnumerationLimit = -1;

<# Export Skype/Teams User Overview. #>
$User = "user@domain.com";
$Stamp = Get-Date -Format "yyyyMMddHHmmss";
Get-CsOnlineUser -Identity $User -ErrorAction SilentlyContinue | Out-File -Encoding utf8 -FilePath "$env:USERPROFILE\Desktop\Get-CsOnlineUser_$Stamp.txt";
#Get-CsOnlineVoiceUser -Identity $User -ErrorAction SilentlyContinue | Out-File -FilePath $env:USERPROFILE\Desktop\Get-CsOnlineVoiceUser_$Stamp.txt";
#Get-CsOnlineDialInConferencingUser -Identity $User -ErrorAction SilentlyContinue | Out-File -FilePath "$env:USERPROFILE\Desktop\Get-CsOnlineDialInConferencingUser_$Stamp.txt";
#Get-CsOnlineApplicationInstance -Identity $User -ErrorAction SilentlyContinue | Out-File -FilePath $env:USERPROFILE\Desktop\Get-CsOnlineApplicationInstance_$Stamp.txt";
#Get-CsUser -Identity $User -ErrorAction SilentlyContinue | Out-File -Encoding utf8 -FilePath "$env:USERPROFILE\Desktop\Get-CsUser_$Stamp.txt";
