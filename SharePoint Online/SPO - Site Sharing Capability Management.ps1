<#
.SYNOPSIS
.NOTES
.LINK
https://docs.microsoft.com/en-us/powershell/module/sharepoint-online/set-sposite?view=sharepoint-ps
https://docs.microsoft.com/en-us/powershell/module/sharepoint-online/get-sposite?view=sharepoint-ps
https://docs.microsoft.com/en-us/onedrive/manage-sharing
https://docs.microsoft.com/en-us/onedrive/user-external-sharing-settings
https://docs.microsoft.com/en-us/sharepoint/turn-external-sharing-on-or-off
#>

<# Pull list of SPO sites and configure External Sharing on the selected SPO sites. #>
$site = Get-SPOSite | select Url, SharingCapability | Out-GridView -PassThru -Title "Select the site(s) you wish to adjust external sharing...";
if ($site -ne $null) {
	$share = "Disabled","ExistingExternalUserSharingOnly","ExternalUserSharingOnly","ExternalUserAndGuestSharing";
	if ($site -is [array])
		{
		$s = $share | Out-GridView -PassThru -Title "Which sharing capability do you want to set on the sites?";
		Write-Host -Fore Yellow -NoNewline "Adjusting the following sites' external sharing setting to: "; Write-Host -Fore Red $s;
		foreach ($si in $site) {
			Set-SPOSite -Identity $si.Url -SharingCapability $s;
			Write-Host -Fore Yellow -NoNewline "Site: "; Write-Host $si.Url;
			}
		}
	else {
		$s = $share | Out-GridView -PassThru -Title "Which sharing capability do you want set on the site?";
		Set-SPOSite -Identity $site.Url -SharingCapability $s;
		Write-Host -Fore Yellow -NoNewline "Site: "; Write-Host $site.Url;
		Write-Host -Fore Yellow -NoNewline "Sharing: "; Write-Host $s; Write-Host "";
		}
	}


<# Pull list of ODfB sites and configure External Sharing on the selected ODfB sites. #>
$site = Get-SPOSite | select Url, SharingCapability | Out-GridView -PassThru -Title "Select the site(s) you wish to adjust external sharing...";
if ($site -ne $null) {
	$share = "Disabled","ExistingExternalUserSharingOnly","ExternalUserSharingOnly","ExternalUserAndGuestSharing";
	if ($site -is [array])
		{
		$s = $share | Out-GridView -PassThru -Title "Which sharing capability do you want to set on the sites?";
		Write-Host -Fore Yellow -NoNewline "Adjusting the following sites' external sharing setting to: "; Write-Host -Fore Red $s;
		foreach ($si in $site) {
			Set-SPOSite -Identity $si.Url -SharingCapability $s;
			Write-Host -Fore Yellow -NoNewline "Site: "; Write-Host $si.Url;
			}
		}
	else {
		$s = $share | Out-GridView -PassThru -Title "Which sharing capability do you want set on the site?";
		Set-SPOSite -Identity $site.Url -SharingCapability $s;
		Write-Host -Fore Yellow -NoNewline "Site: "; Write-Host $site.Url;
		Write-Host -Fore Yellow -NoNewline "Sharing: "; Write-Host $s; Write-Host "";
		}
	}
