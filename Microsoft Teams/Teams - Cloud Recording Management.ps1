<#
.SYNOPSIS
Teams Cloud Recording Management
https://github.com/O365scripts/O365scripts/blob/master/Microsoft%20Teams/Teams%20-%20Cloud%20Recording%20Management.ps1
.NOTES
.LINK
https://docs.microsoft.com/en-us/powershell/module/skype/set-csteamsmeetingpolicy?view=skype-ps
https://docs.microsoft.com/en-us/microsoftteams/tmr-meeting-recording-change
https://docs.microsoft.com/en-us/microsoftteams/cloud-recording
https://aka.ms/in-region
#>

<# Connect to Teams. #>
#Set-ExecutionPolicy RemoteSigned -Force -Confirm:$false;
#Install-Module MicrosoftTeams -AllowClobber -Force -Confirm:$false;
Import-Module MicrosoftTeams;
Connect-MicrosoftTeams;

<# Use OneDrive for Business and SharePoint or Stream for meeting recordings. #>
Set-CsTeamsMeetingPolicy -Identity "Global" -RecordingStorageMode "OneDriveForBusiness";

<# Opt out of OneDrive for Business and SharePoint to continue using Stream. #>
Set-CsTeamsMeetingPolicy -Identity "Global" -RecordingStorageMode "Stream";

<# Allow storing recording outside of region. Note that all meeting recordings will be permanently stored in another region, and can't be migrated. #>
Set-CsTeamsMeetingPolicy -Identity "Global" -AllowCloudRecording $true -AllowRecordingStorageOutsideRegion $true;

<# Confirm global meeting policy configuration. #>
Get-CsTeamsMeetingPolicy -Identity "Global";

<# Confirm all meeting policies. #>
Get-CsTeamsMeetingPolicy | Format-List;