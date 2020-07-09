<#
.SYNOPSIS
Clear the Teams application cache.
.NOTES
.LINK
https://microsoftteams.uservoice.com/forums/555103-public/suggestions/34320940-clear-local-cache-button
#>

<# Flush Teams desktop cache folders. #>
#erraction = "Continue";
$erraction = "SilentlyContinue";
Remove-Item -Path "$env:APPDATA\Microsoft\Teams\application cache\cache\*" -Force -Confirm:$false -ErrorAction $erraction;
#emove-Item -Path "$env:APPDATA\Microsoft\Teams\backgrounds\*" -Force -Confirm:$false -ErrorAction $erraction;
Remove-Item -Path "$env:APPDATA\Microsoft\Teams\blob_storage\*" -Force -Confirm:$false -ErrorAction $erraction;
Remove-Item -Path "$env:APPDATA\Microsoft\Teams\Cache\*" -Force -Confirm:$false -ErrorAction $erraction;
Remove-Item -Path "$env:APPDATA\Microsoft\Teams\databases\*" -Force -Confirm:$false -ErrorAction $erraction;
Remove-Item -Path "$env:APPDATA\Microsoft\Teams\GPUcache\*" -Force -Confirm:$false -ErrorAction $erraction;
Remove-Item -Path "$env:APPDATA\Microsoft\Teams\IndexedDB\*" -Recurse -Force -Confirm:$false -ErrorAction $erraction;
Remove-Item -Path "$env:APPDATA\Microsoft\Teams\Local Storage\*" -Recurse -Force -Confirm:$false -ErrorAction $erraction;
Remove-Item -Path "$env:APPDATA\Microsoft\Teams\tmp\*" -Force -Confirm:$false -ErrorAction $erraction;
