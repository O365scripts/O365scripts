<#
.SYNOPSIS
Exchange Online Mobile Device Management

.NOTES

.LINK
https://support.microsoft.com/en-us/help/3013802/exchange-activesync-device-is-blocked-unexpectedly-by-abq-list
https://support.microsoft.com/en-us/help/3193518/exchange-online-users-who-use-outlook-for-ios-and-android-and-device-a
#>

<# Empty the list of allowed/blocked mobile devices. #>
$mbox = "";
Set-CASMailbox -Identity $mbox -ActiveSyncAllowedDeviceIDs $null;
Set-CASMailbox -Identity $mbox -ActiveSyncBlockedDeviceIDs $null;

<# Add or remove a mobile device from the list of allowed mobile devices. #>
$mbox = "";
$deviceid = "";
Set-CASMailbox -Identity $mbox -ActiveSyncAllowedDeviceIDs @{add="$deviceid"};
Set-CASMailbox -Identity $mbox -ActiveSyncAllowedDeviceIDs @{remove="$deviceid"}

<# Add or remove a mobile device from the list of blocked mobile devices. #>
$mbox = "";
$deviceid = "";
Set-CASMailbox -Identity $mbox -ActiveSyncBlockedDeviceIDs @{add="$deviceid"}
Set-CASMailbox -Identity $mbox -ActiveSyncBlockedDeviceIDs @{remove="$deviceid"}
