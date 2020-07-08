<#
.SYNOPSIS
.NOTES
.LINK
https://docs.microsoft.com/en-us/azure/active-directory/hybrid/how-to-connect-sync-feature-scheduler
https://docs.microsoft.com/en-us/azure/active-directory/hybrid/how-to-connect-sync-whatis
#>

<# AADConnect Full Sync. #>
Import-Module ADSync;
Start-ADSyncSyncCycle Initial;

<# AADConnect Delta Sync. #>
Import-Module ADSync;
Start-ADSyncSyncCycle Delta;

<# Set a custom sync interval. #>
$time = "d.HH:mm:ss";
$time = "0:30:00";
$time = "";
Set-ADSyncScheduler -CustomizedSyncCycleInterval $time;

<# Enable or disable the sync service. #>
Set-ADSyncScheduler -SyncCycleEnabled $false;
Set-ADSyncScheduler -SyncCycleEnabled $true;

<# #>
...
