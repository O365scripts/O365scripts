<#
.SYNOPSIS
Clear the Microsoft Teams application cache.
https://github.com/O365scripts/O365scripts/blob/master/Microsoft%20Teams/Teams%20-%20Application%20Cache%20Clear.ps1

.NOTES
> Use the 1st option to flush everything inside the "$env:APPDATA\Microsoft\Teams" folder or the 2nd one to clear only specific cache folders.
> Files in the meeting-addin folder may be undeletable and remain as read-only if Outlook is still opened, likewise for Teams.
> To do: Copy backgrounds folder to temp before wiping full folder and moving back to bg folder.

.LINK
https://learn.microsoft.com/microsoftteams/troubleshoot/teams-administration/clear-teams-cache
#>

<# a) Close Teams and flush the entire cache folder. #>
Stop-Process -Name "Teams" -Force -Confirm:$false -ErrorAction SilentlyContinue;
#Stop-Process -Name "Outlook" -Force -Confirm:$false -ErrorAction $ErrAction;
Remove-Item -Path "$env:APPDATA\Microsoft\Teams\*" -Recurse -Force -Confirm:$false -ErrorAction SilentlyContinue;

<# b) Close Teams and clear specific cache folders (eg: save the custom backgrounds). #>
$ErrAction = "SilentlyContinue";
Stop-Process -Name "Teams" -Force -Confirm:$false -ErrorAction $ErrAction;
#Stop-Process -Name "Outlook" -Force -Confirm:$false -ErrorAction $ErrAction;
Remove-Item -Path "$env:APPDATA\Microsoft\Teams\application cache\cache\*" -Force -Confirm:$false -ErrorAction $ErrAction;
#emove-Item -Path "$env:APPDATA\Microsoft\Teams\backgrounds\*" -Force -Confirm:$false -ErrorAction $ErrAction;
Remove-Item -Path "$env:APPDATA\Microsoft\Teams\blob_storage\*" -Force -Confirm:$false -ErrorAction $ErrAction;
Remove-Item -Path "$env:APPDATA\Microsoft\Teams\Cache\*" -Force -Confirm:$false -ErrorAction $ErrAction;
Remove-Item -Path "$env:APPDATA\Microsoft\Teams\databases\*" -Force -Confirm:$false -ErrorAction $ErrAction;
Remove-Item -Path "$env:APPDATA\Microsoft\Teams\GPUcache\*" -Force -Confirm:$false -ErrorAction $ErrAction;
Remove-Item -Path "$env:APPDATA\Microsoft\Teams\IndexedDB\*" -Recurse -Force -Confirm:$false -ErrorAction $ErrAction;
Remove-Item -Path "$env:APPDATA\Microsoft\Teams\Local Storage\*" -Recurse -Force -Confirm:$false -ErrorAction $ErrAction;
Remove-Item -Path "$env:APPDATA\Microsoft\Teams\tmp\*" -Force -Confirm:$false -ErrorAction $ErrAction;
