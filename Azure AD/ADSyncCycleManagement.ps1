<#
.SYNOPSIS
Azure AD Connect sync cycle management.

.NOTES

.LINK
https://learn.microsoft.com/azure/active-directory/hybrid/how-to-connect-sync-feature-scheduler
https://learn.microsoft.com/azure/active-directory/hybrid/how-to-connect-sync-whatis
#>

# Start a full sync.
Import-Module ADSync
Start-ADSyncSyncCycle Initial

# Start a delta sync.
Import-Module ADSync
Start-ADSyncSyncCycle Delta

# Set a custom sync interval.
#$time = "d.HH:mm:ss" # Format to use.
#$time = "2.0:00:00" # 2d
#$time = "12:00:00" # 12h
#$time = "0:30:00" # 30m
$time = ""
Set-ADSyncScheduler -CustomizedSyncCycleInterval $time
Get-ADSyncScheduler.CustomizedSyncCycleInterval

# Toggle the sync service.
Set-ADSyncScheduler -SyncCycleEnabled $false
Set-ADSyncScheduler -SyncCycleEnabled $true
