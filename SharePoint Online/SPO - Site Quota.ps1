<#
.SYNOPSIS
Site Collection Storage Quota Management
.NOTES
.LINK
https://docs.microsoft.com/en-us/sharepoint/manage-site-collection-storage-limits
https://docs.microsoft.com/en-us/powershell/module/sharepoint-online/set-sposite?view=sharepoint-ps
https://docs.microsoft.com/en-us/powershell/module/sharepoint-online/get-sposite?view=sharepoint-ps
#>

<# Set storage quota on an ODFB site. #>
$SiteOD = "user_domain_com";
$SiteQuota = 5 * 1048576; 
$SiteQuotaWarn = 4.75 * 1048576;
Set-SPOSite -Identity "https://${tenant}-my.sharepoint.com/personal/${site_od4b}" -StorageQuota $SiteQuota -StorageQuotaWarningLevel $SiteQuotaWarn;
Get-SPOSite -Identity "https://${tenant}-my.sharepoint.com/personal/${site_od4b}" | select StorageQuota*;
