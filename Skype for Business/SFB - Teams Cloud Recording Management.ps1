<#
.SYNOPSIS
.NOTES
.LINK
https://docs.microsoft.com/en-us/powershell/module/skype/set-csteamsmeetingpolicy?view=skype-ps
https://docs.microsoft.com/en-us/microsoftteams/tmr-meeting-recording-change
https://docs.microsoft.com/en-us/microsoftteams/cloud-recording
https://aka.ms/in-region
#>

<# QUICKRUN: Install the Teams module and connect to SFBO. #>
$Tenant = "mytenant";
Install-Module MicrosoftTeams -Force -Confirm:$false;
$Session_Sfb = New-CsOnlineSession -OverrideAdminDomain "$Tenant.onmicrosoft.com";
Import-PSSession $Session_Sfb;

<# Use OneDrive for Business and SharePoint or Stream for meeting recordings. #>
Set-CsTeamsMeetingPolicy -Identity Global -RecordingStorageMode "OneDriveForBusiness";

<# Opt out of OneDrive for Business and SharePoint to continue using Stream. #>
Set-CsTeamsMeetingPolicy -Identity Global -RecordingStorageMode "Stream";

<# Allow storing recording outside of region. All meeting recordings will be permanently stored in another region, and can't be migrated. #>
Set-CsTeamsMeetingPolicy -Identity Global –AllowCloudRecording $true -AllowRecordingStorageOutsideRegion $true;

<# Confirm meeting policy configuration. #>
Get-CsTeamsMeetingPolicy -Identity Global;

<# Export meeting policy configuration. #>
Get-CsTeamsMeetingPolicy -Identity Global | Out-File "$env:USERPROFILE\Desktop\Get-CsTeamsMeetingPolicy-Global_$((Get-Date -Format "yyyyMMddHHmmss")).txt";
