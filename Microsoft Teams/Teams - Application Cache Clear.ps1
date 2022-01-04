<#
.SYNOPSIS
Clear the Microsoft Teams application cache.
https://github.com/O365scripts/O365scripts/blob/master/Microsoft%20Teams/Teams%20-%20Application%20Cache%20Clear.ps1
.NOTES
	> You may also flush everything inside the "$env:APPDATA\Microsoft\Teams" cache folder after closing the app.
	> Files may remain as read-only in the meeting-addin folder if Outlook is still opened.
.LINK
https://microsoftteams.uservoice.com/forums/555103-public/suggestions/34320940-clear-local-cache-button
#>

<# Flush specific Teams cache folders. #>
$ErrAction = "SilentlyContinue";
Remove-Item -Path "$env:APPDATA\Microsoft\Teams\application cache\cache\*" -Force -Confirm:$false -ErrorAction $ErrAction;
#emove-Item -Path "$env:APPDATA\Microsoft\Teams\backgrounds\*" -Force -Confirm:$false -ErrorAction $ErrAction;
Remove-Item -Path "$env:APPDATA\Microsoft\Teams\blob_storage\*" -Force -Confirm:$false -ErrorAction $ErrAction;
Remove-Item -Path "$env:APPDATA\Microsoft\Teams\Cache\*" -Force -Confirm:$false -ErrorAction $ErrAction;
Remove-Item -Path "$env:APPDATA\Microsoft\Teams\databases\*" -Force -Confirm:$false -ErrorAction $ErrAction;
Remove-Item -Path "$env:APPDATA\Microsoft\Teams\GPUcache\*" -Force -Confirm:$false -ErrorAction $ErrAction;
Remove-Item -Path "$env:APPDATA\Microsoft\Teams\IndexedDB\*" -Recurse -Force -Confirm:$false -ErrorAction $ErrAction;
Remove-Item -Path "$env:APPDATA\Microsoft\Teams\Local Storage\*" -Recurse -Force -Confirm:$false -ErrorAction $ErrAction;
Remove-Item -Path "$env:APPDATA\Microsoft\Teams\tmp\*" -Force -Confirm:$false -ErrorAction $ErrAction;

<# Flush the entire Teams cache folder contents. #>
Remove-Item -Path "$env:APPDATA\Microsoft\Teams\*" -Recurse -Force -Confirm:$false -ErrorAction SilentlyContinue;