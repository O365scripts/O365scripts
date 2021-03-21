<#
.SYNOPSIS
Teams/Skype Audio Conferencing User and Bridge Management
https://github.com/O365scripts/O365scripts/blob/master/Skype%20for%20Business/SFB%20-%20Audio%20Conferencing%20User%20Management.ps1
.NOTES
In some rare cases, there may be a lingering sync issue between the Azure and the Voice directories for a specific user which can prevent the conferencing bridge details from showing up in the meeting invite.
When that situation happens, attempting to toggle off audio conferencing via Disable/Enable-CsOnlineDialInConferencingUser can sometimes help but if it still gets stuck you may need to create a service request from your admin portal.
.LINK
https://docs.microsoft.com/en-us/microsoftteams/phone-numbers-for-audio-conferencing-in-teams
https://docs.microsoft.com/en-us/microsoftteams/audio-conferencing-common-questions
https://docs.microsoft.com/en-us/microsoftteams/dial-out-minutes-canada-us
https://docs.microsoft.com/en-us/microsoftteams/complimentary-dial-out-period
https://docs.microsoft.com/en-us/powershell/module/skype/get-csonlinedialinconferencinguser?view=skype-ps
https://docs.microsoft.com/en-us/powershell/module/skype/set-csonlinedialinconferencinguser?view=skype-ps
https://docs.microsoft.com/en-us/powershell/module/skype/get-csonlineuser?view=skype-ps
#>

<# Toggle on/off audio conferencing on a single user. Wait an hour in between preferably. #>
$User = "";
Disable-CsOnlineDialInConferencingUser $User;
Enable-CsOnlineDialInConferencingUser $User;

<# Export CsOnlineUser and ConferencingUser details of a specific user. #>
$User = "user@domain.com";
Get-CsOnlineUser -Identity $User | Out-File -FilePath "$env:USERPROFILE\Desktop\Get-CsOnlineUser_$(Get-Date -Format "yyyyMMdd-hhmmss").txt" -Encoding utf8;
Get-CsOnlineDialInConferencingUser -Identity $Use | Out-File -FilePath "$env:USERPROFILE\Desktop\Get-CsOnlineDialInConferencingUser_$(Get-Date -Format "yyyyMMdd-hhmmss").txt" -Encoding utf8;

<# Conference Bridge number details. #>
Get-CsOnlineTelephoneNumber -TelephoneNumber "+1234567890";

<# Get list of dedicated conference bridge numbers. #>
Get-CsOnlineTelephoneNumber -InventoryType Service | Where {$_.TargetType -eq "caa"} | Select Id,CityCode

<# List all possible shared/dedicated bridge numbers. #>
Get-CsOnlineDialInConferencingBridge | Select -ExpandProperty ServiceNumbers | Select Number,City,IsShared

<# Interactive selection of a bridge. #>
$Bridge = Get-CsOnlineDialInConferencingBridge | Select -ExpandProperty ServiceNumbers | Select Number,City,Type,IsShared,PrimaryLanguage,SecondaryLanguages | Out-GridView -OutputMode Single;

<# Unregister a bridge number to be reassigned on a resource account or be sent for type conversion. #>
Unregister-CsOnlineDialInConferencingServiceNumber -Identity "+1234567890";