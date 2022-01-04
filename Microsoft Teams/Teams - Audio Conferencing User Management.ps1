<#
.SYNOPSIS
Teams Audio Conferencing User and Bridge Management
https://github.com/O365scripts/O365scripts/blob/master/Microsoft%20Teams/Teams%20-%20Audio%20Conferencing%20User%20Management.ps1
.NOTES
	> In some rare cases, there may be a lingering sync issue between the Azure and the Voice directories for a specific user which can prevent the conferencing bridge details from showing up in the meeting invite.
	> When that situation happens, attempting to toggle off audio conferencing via Disable/Enable-CsOnlineDialInConferencingUser can sometimes help but if it still gets stuck you may need to create a service request from your admin portal.
.LINK
Reference:
https://docs.microsoft.com/en-us/microsoftteams/phone-numbers-for-audio-conferencing-in-teams
https://docs.microsoft.com/en-us/microsoftteams/audio-conferencing-common-questions
https://docs.microsoft.com/en-us/microsoftteams/dial-out-minutes-canada-us
https://docs.microsoft.com/en-us/microsoftteams/complimentary-dial-out-period
https://docs.microsoft.com/en-us/powershell/module/skype/get-csonlinedialinconferencinguser?view=skype-ps
https://docs.microsoft.com/en-us/powershell/module/skype/set-csonlinedialinconferencinguser?view=skype-ps
https://docs.microsoft.com/en-us/powershell/module/skype/get-csonlineuser?view=skype-ps
#>

<# Connect to Teams. #>
#Set-ExecutionPolicy RemoteSigned -Force -Confirm:$false;
#Install-Module MicrosoftTeams -AllowClobber -Force -Confirm:$false;
Import-Module MicrosoftTeams;
Connect-MicrosoftTeams;

<# Toggle on/off audio conferencing on a single user. Wait an hour in between preferably. #>
$User = "";
Disable-CsOnlineDialInConferencingUser $User;
Enable-CsOnlineDialInConferencingUser $User;

<# Export CsOnlineUser and ConferencingUser details to text. #>
$User = "";
$StampNow = Get-Date -Format "yyyyMMddhhmmss";
$PathBaseExport = "$env:USERPROFILE\Desktop";
$FormatEnumerationLimit = -1;
Get-CsOnlineUser -Identity $User | Select * | Out-File -FilePath "$PathBaseExport\Get-CsOnlineUser_$StampNow.txt" -Encoding utf8 -NoClobber;
Get-CsOnlineDialInConferencingUser -Identity $User | Out-File "$PathBaseExport\Get-CsOnlineDialInConferencingUser_$StampNow.txt" -Encoding utf8 -NoClobber;

<# Interactive selection of a bridge number to assign on a conferencing user. #>
$User = "";
$Bridge = Get-CsOnlineDialInConferencingBridge | Select -ExpandProperty ServiceNumbers | Select Number,City,Type,IsShared,PrimaryLanguage,SecondaryLanguages | Out-GridView -OutputMode Single;
Set-CsOnlineDialInConferencingUser -Identity $User -ServiceNumber $Bridge;
Set-CsOnlineDialInConferencingUser -Identity $User -TollFreeServiceNumber $Bridge;
Get-CsOnlineDialInConferencingUser -Identity $User;

<# Conference Bridge number details. #>
Get-CsOnlineTelephoneNumber -TelephoneNumber "12223334444";

<# Get list of dedicated conference bridge numbers. #>
Get-CsOnlineTelephoneNumber -InventoryType Service | Where {$_.TargetType -eq "caa"} | Select Id,CityCode;

<# List all possible shared/dedicated bridge numbers. #>
Get-CsOnlineDialInConferencingBridge | Select -ExpandProperty ServiceNumbers | Select Number,City,IsShared;

<# Unregister a bridge number to be reassigned on a resource account or be sent for type conversion. #>
Unregister-CsOnlineDialInConferencingServiceNumber -Identity "+1234567890";