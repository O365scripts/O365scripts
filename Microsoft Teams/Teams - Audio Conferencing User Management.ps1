<#
.SYNOPSIS
Teams Audio Conferencing User and Bridge Management
https://github.com/O365scripts/O365scripts/blob/master/Microsoft%20Teams/Teams%20-%20Audio%20Conferencing%20User%20Management.ps1

.NOTES
Troubleshooting:
> In some rare cases, there may be a lingering sync issue between the Azure and the Voice directories for a specific user which can prevent the conferencing bridge details from showing up in the meeting invite.
> Previously, it was possible to toggle conferencing via  the Disable/Enable-CsOnlineDialInConferencingUser but the commands have since been retired with no direct replacement.
> The self help diagnostic can be used https://aka.ms/TeasConfDiag for possible insights.
> An Enterprise E5 trial can be assigned on the impacted user to attempt reprovisioning.
> Otherwise if it still gets stuck you may need to create a service request from your admin portal.

.LINK
Reference:
https://learn.microsoft.com/microsoftteams/phone-numbers-for-audio-conferencing-in-teams
https://learn.microsoft.com/microsoftteams/audio-conferencing-common-questions
https://learn.microsoft.com/microsoftteams/dial-out-minutes-canada-us
https://learn.microsoft.com/microsoftteams/complimentary-dial-out-period
https://learn.microsoft.com/powershell/module/skype/get-csonlinedialinconferencinguser
https://learn.microsoft.com/powershell/module/skype/set-csonlinedialinconferencinguser
https://learn.microsoft.com/powershell/module/skype/get-csonlineuser
#>

<# Connect to Teams. #>
#Set-ExecutionPolicy RemoteSigned -Force -Confirm:$false;
#Install-Module MicrosoftTeams -AllowClobber -Force -Confirm:$false;
Import-Module MicrosoftTeams;
Connect-MicrosoftTeams;

<# Assign a toll conference bridge number on a user and confirm number/user details. #>
$User = "";
$TollBridge = "12223334444";
Set-CsOnlineDialInConferencingUser -Identity $User -ServiceNumber $TollBridge;
Get-CsOnlineDialInConferencingUser -Identity $User;

<# Assign a toll and toll-free conference bridge number on a user and confirm number/user details. #>
$User = "";
$TollBridge = "12223334444";
$TollFreeBridge = "18003334444";
Set-CsOnlineDialInConferencingUser -Identity $User -ServiceNumber $TollBridge;
Set-CsOnlineDialInConferencingUser -Identity $User -TollFreeServiceNumber $TollFreeBridge;
Get-CsOnlineTelephoneNumber -TelephoneNumber $TollBridge;
Get-CsOnlineTelephoneNumber -TelephoneNumber $TollFreeBridge;
Get-CsOnlineDialInConferencingUser -Identity $User;

<# DEPRECATED: Toggle on/off audio conferencing on a single user. Wait an hour in between preferably. #>
#Disable-CsOnlineDialInConferencingUser $User;
#Enable-CsOnlineDialInConferencingUser $User;

<# Export CsOnlineUser and ConferencingUser details to text. #>
$User = "";
$StampNow = Get-Date -Format "yyyyMMddhhmmss";
$PathBaseExport = "$env:USERPROFILE\Desktop";
$FormatEnumerationLimit = -1;
Get-CsOnlineUser -Identity $User | Select * | Out-File -FilePath "$PathBaseExport\Get-CsOnlineUser_$StampNow.txt" -Encoding utf8 -NoClobber;
Get-CsOnlineDialInConferencingUser -Identity $User | Out-File "$PathBaseExport\Get-CsOnlineDialInConferencingUser_$StampNow.txt" -Encoding utf8 -NoClobber;


<# Interactive selection of conference bridge number to assign on a user. #>
$User = "";
$Bridge = Get-CsOnlineDialInConferencingBridge | Select -ExpandProperty ServiceNumbers | Select Number,City,Type,IsShared,PrimaryLanguage,SecondaryLanguages | Out-GridView -OutputMode Single;
Set-CsOnlineDialInConferencingUser -Identity $User -ServiceNumber $Bridge;
Set-CsOnlineDialInConferencingUser -Identity $User -TollFreeServiceNumber $Bridge;

<# Display audio conferencing user details. #>
Get-CsOnlineDialInConferencingUser -Identity $User;

<# Conference Bridge number details. #>
Get-CsOnlineTelephoneNumber -TelephoneNumber "12223334444";

<# Get list of dedicated conference bridge numbers. #>
Get-CsOnlineTelephoneNumber -InventoryType Service | Where {$_.TargetType -eq "caa"} | Select Id,CityCode;

<# List all possible shared/dedicated bridge numbers. #>
Get-CsOnlineDialInConferencingBridge | Select -ExpandProperty ServiceNumbers | Select Number,City,IsShared;

<# Unregister a bridge number to be reassigned on a resource account or be sent for type conversion. #>
Unregister-CsOnlineDialInConferencingServiceNumber -Identity "+1234567890";
