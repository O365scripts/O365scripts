<#
.SYNOPSIS
Office Message Encryption Management
https://github.com/O365scripts/O365scripts/blob/master/Exchange%20Online/EXO%20-%20Office%20Message%20Encryption.ps1
.NOTES
.LINK
https://docs.microsoft.com/en-us/powershell/module/exchange/set-irmconfiguration?view=exchange-ps
https://docs.microsoft.com/en-us/powershell/module/exchange/get-irmconfiguration?view=exchange-ps
https://docs.microsoft.com/en-us/azure/information-protection/install-powershell
https://docs.microsoft.com/en-us/powershell/module/aipservice/enable-aipservice?view=azureipps
https://docs.microsoft.com/en-us/powershell/module/aipservice/get-aipservice?view=azureipps
#>

<# Confirm which modules are installed? #>
Get-Module AADRM -ListAvailable;
Get-Module AIPService -ListAvailable;
Get-Module ExchangeOnlineManagement -ListAvailable;

<# Remove previous AIP module? #>
#Uninstall-Module AADRM -AllVersions -Force -Confirm:$false;

<# Install AIP and EXO modules? #>
Install-Module AIPService -Force -Confirm:$false;
Install-Module ExchangeOnlineManagement -Force -Confirm:$false;

<# Connect to EXO and AIP. #>
$AdminUpn = "";
$Creds = Get-Credential -UserName $AdminUpn -Message "Login:";
Import-Module AIPService;
Import-Module ExchangeOnlineManagement;
Connect-AIPService -Credential $Creds;
Connect-ExchangeOnline -UserPrincipalName $AdminUpn -Credential $Creds;

<# Get AIP and IRM configuration. #>
$AipService = Get-AipService;
$AipConfig = Get-AipServiceConfiguration;
$IrmConfig = Get-IRMConfiguration;

<# Verify current configuration. #>
Clear
Write-Host -NoNewline -Fore Yellow "AIP Service: "; $AipService;
Write-Host;
Write-Host -NoNewline -Fore Yellow "Current AIP Configuration: "; $AipConfig;


<# If licensing location is empty or does not contain the licensing url taken from the aip service side then add it. #>
$LicenseUrl = $AipConfig.LicensingIntranetDistributionPointUrl;
$List = $IrmConfig.LicensingLocation;
if (!$List) {
	Write-Host "Licensing list currently empty.";
	$List = @()
}
if (!$List.Contains($LicenseUrl)) {
	Write-Host "Adding Licensing Distribution Point URL since it is missing from the list.";
	$List += $LicenseUrl
}
Write-Host -Fore Yellow "Setting IRM licensing location list.";
Set-IRMConfiguration -LicensingLocation $List;
(Get-IRMConfiguration).LicensingLocation;

Write-Host -Fore Yellow "Enabling Azure RMS and Internal Licensing.";
Set-IRMConfiguration -AzureRMSLicensingEnabled $true -InternalLicensingEnabled $true;
Set-IRMConfiguration -SimplifiedClientAccessEnabled $true;

######################

<# Use this if you want to toggle off v1 and v2 but only reenable v1. #>
Write-Host -Fore Yellow "Disable OME v1 and enable OME v2.";
Set-IRMConfiguration -AzureRMSLicensingEnabled $false -InternalLicensingEnabled $False -RMSOnlineKeySharingLocation $null -Force -Confirm:$false;
Set-IRMConfiguration -AzureRMSLicensingEnabled $true -InternalLicensingEnabled $true;

<# Enable the Protect button as well as use of the Encrypt and DNF templates in OWA. #>
Write-Host -Fore Yellow "Enable the Protect, Encrypt, Do Not Forward buttons and the DNF template in OWA.";
Set-IRMConfiguration -SimplifiedClientAccessEnabled $true -SimplifiedClientAccessEncryptOnlyDisabled $false -SimplifiedClientAccessDoNotForwardDisabled $false;
