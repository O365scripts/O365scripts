<#
.SYNOPSIS
Office 365 Group Address List Visibility Management
.NOTES
HiddenFromAddressListsEnabled
$true: The Office 365 Group is hidden from the GAL and other address lists.
The group can still receive messages, but users can't search for or browse to the group in Outlook or Outlook on the web.
Users also can't find the group by using the Discover option in Outlook on the web. For users that are members of the Office 365 Group, the group will still appear in the navigation pane in Outlook and Outlook on the web if HiddenFromExchangeClientsEnabled property is NOT enabled.
$false: The Office 365 Group is visible in the GAL and other address lists. This is the default value.
.LINK
https://docs.microsoft.com/en-us/powershell/module/exchange/users-and-groups/set-unifiedgroup?view=exchange-ps
#>

<# Connect to EXO v2. #>
#Set-ExecutionPolicy RemoteSigned -Force -Confirm:$false;
#Install-Module ExchangeOnlineManagement -AllowClobber -Force -Confirm:$false;
$AdminUpn = "";
Connect-ExchangeOnline -UserPrincipalName $AdminUpn;

<# Pull list of O365 Groups and adjust the hidden from GAL/Outlook attributes on selected ones to $hidden. #>
$Hidden = $false;
$ListGroups = Get-UnifiedGroup | select DisplayName,PrimarySmtpAddress,HiddenFromAddressListsEnabled,HiddenFromExchangeClientsEnabled | Out-GridView -PassThru -Title "Which groups do you want to adjust?";
if ( $null -ne $ListGroups) {
	if ($ListGroups -is [array])
		{
		Write-Host "Adjusting the 'HiddenFromAddressListsEnabled' and 'HiddenFromExchangeClientsEnabled' attributes on the following unified groups...";
		foreach ($li in $ListGroups) {
			Write-Host -NoNewline "Group: "; Write-Host -Fore Yellow $li.PrimarySmtpAddress;
			Set-UnifiedGroup -Identity $li.PrimarySmtpAddress -HiddenFromAddressListsEnabled:$Hidden -HiddenFromExchangeClientsEnabled:$Hidden;
			}
		}
	else {
		Write-Host -NoNewline "Adjusting the 'HiddenFromAddressListsEnabled' and 'HiddenFromExchangeClientsEnabled' attributes on ";
			Write-Host -NoNewline -Fore Yellow $ListGroups.PrimarySmtpAddress; Write-Host ".";
		Set-UnifiedGroup -Identity $ListGroups.PrimarySmtpAddress -HiddenFromAddressListsEnabled:$Hidden -HiddenFromExchangeClientsEnabled:$Hidden;
		}
	}


<# Confirm current Hidden from GAL/Outlook settings of all O365 groups. #>
Get-UnifiedGroup | select DisplayName,PrimarySmtpAddress,HiddenFromAddressListsEnabled,HiddenFromExchangeClientsEnabled | Out-GridView;

<# Set a single O365 group to be hidden from GAL/Outlook. #>
$Group = "o365grouptest@domain.com";
$Hidden = $false;
Set-UnifiedGroup $Group -HiddenFromAddressListsEnabled:$Hidden -HiddenFromExchangeClientsEnabled:$Hidden;

<# Confirm if a single O365 group is set to be hidden from GAL/Outlook? #>
$Group = "o365group@domain.com";
Get-UnifiedGroup $Group | select DisplayName,PrimarySmtpAddress,HiddenFromAddressListsEnabled,HiddenFromExchangeClientsEnabled;
