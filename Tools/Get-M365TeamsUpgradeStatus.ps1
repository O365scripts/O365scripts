<#
.SYNOPSIS
Get Teams Tenant and User Upgrade Status.
.NOTES
	> Confirm if Teams and MSOL/AAD modules are present and need to be installed/upgraded.
	> If multiple versions of the Teams module that are below 1.1.6 are present, previous versions should to be removed.
	> Confirm on all verified domains if the Skype/Teams DNS records are present and if they are pointing to 365.
	> Force upgrade all users to TeamsOnly
	?
.LINK
https://docs.microsoft.com/en-us/powershell/module/skype/get-csteamsupgradestatus?view=skype-ps
https://docs.microsoft.com/en-us/powershell/module/skype/grant-csteamsupgradepolicy?view=skype-ps
#>

<# Confirm Tenant Upgrade Status. #>
Get-CsTeamsUpgradeStatus;
Get-CsTeamsUpgradeConfiguration -Identity Global;
Get-CsTeamsUpgradePolicy -Identity Global;

<# Sample Tenant Upgrade Status Output. #>
<#
TenantId             : x
State                : Null
OptInEligibleDate    : 
UpgradeScheduledDate : 
UserNotificationDate : 
UpgradeDate          : 
LastStateChangeDate  : 
#>

<# Confirm Teams User Upgrade Status Details. #>
$User = "";
Get-CsOnlineUser -Identity $User | Select UserPrincipalName,TeamsUpgrade*;

<# Confirm Teams Upgade Status of All Users. #>
Get-CsOnlineUser | Select ObjectId,UserPrincipalName,TeamsUpgradeEffectiveMode;
