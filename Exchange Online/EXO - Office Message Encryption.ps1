<#
.SYNOPSIS
Office Message Encryption Management
https://github.com/O365scripts/O365scripts/blob/master/Exchange%20Online/EXO%20-%20Office%20Message%20Encryption.ps1
.NOTES
	> 
.LINK
Reference:
https://docs.microsoft.com/en-us/microsoft-365/compliance/ome-faq?view=o365-worldwide
https://docs.microsoft.com/en-us/powershell/module/exchange/set-irmconfiguration?view=exchange-ps
https://docs.microsoft.com/en-us/powershell/module/exchange/get-irmconfiguration?view=exchange-ps
https://docs.microsoft.com/en-us/azure/information-protection/install-powershell
https://docs.microsoft.com/en-us/powershell/module/aipservice/enable-aipservice?view=azureipps
https://docs.microsoft.com/en-us/powershell/module/aipservice/get-aipservice?view=azureipps
https://docs.microsoft.com/en-us/microsoft-365/compliance/set-up-azure-rms-for-previous-version-message-encryption?view=o365-worldwide
#>

<# Connect to EXO and AIP. #>
#Install-Module AIPService -AllowClobber -Force -Confirm:$false;
#Install-Module ExchangeOnlineManagement -AllowClobber -Force -Confirm:$false;
Import-Module AIPService;
Import-Module ExchangeOnlineManagement;
$AdminUpn = "";
Connect-ExchangeOnline -UserPrincipalName $AdminUpn;
Connect-AIPService;

<# Connect to EXO and AIP without MFA. #>
#$Creds = Get-Credential -UserName $AdminUpn -Message "Login:";
#Connect-AIPService -Credential $Creds;
#Connect-ExchangeOnline -UserPrincipalName $AdminUpn -Credential $Creds;

<# Confirm which modules are installed? #>
Get-Module AADRM -ListAvailable | Select Name,Version;
Get-Module AIPService -ListAvailable | Select Name,Version;
Get-Module ExchangeOnlineManagement -ListAvailable | Select Name,Version;

<# Remove previous AIP module? #>
#Uninstall-Module AADRM -AllVersions -Force -Confirm:$false;

<# Get AIP status and AIP/IRM configuration. #>
$AipService = Get-AipService;
$AipConfig = Get-AipServiceConfiguration;
$IrmConfig = Get-IRMConfiguration;

<# Display current configuration. #>
Clear;
Write-Host -NoNewLine -Fore Yellow "AIP Service: ";
	if ($AipService -eq "Disabled") {Write-Host -Fore Red $AipService;}
	elseif ($AipService -eq "Enabled") {Write-Host -Fore Green $AipService;}
Write-Host -Fore Yellow "AIP Configuration: "; $AipConfig;
Write-Host -Fore Yellow "IRM Configuration: "; $IrmConfig;

<# Enable AIP if disabled. #>
if ($AipService -eq "Disabled"){
	Write-Host -Fore Yellow "Attempting to enable AIP.";
	Enable-AipService
}


<# If licensing location is empty or does not contain the licensing url taken from the aip service side, add it. #>
$LicenseUrl = ;

$List = $IrmConfig.LicensingLocation;
if (!$List) {Write-Host "Licensing list currently empty."; $List = @()}
if (!$List.Contains($AipConfig.LicensingIntranetDistributionPointUrl)) {
	Write-Host "Adding Licensing Distribution Point URL since it is missing from the list.";
	$List += $AipConfig.LicensingIntranetDistributionPointUrl;
}
Write-Host -Fore Yellow "Setting IRM licensing location list.";
Set-IRMConfiguration -LicensingLocation $List;

Write-Host -Fore Yellow "Enabling Office 365 Message Encryption Azure RMS and Internal Licensing.";
Set-IRMConfiguration -AzureRMSLicensingEnabled $true -InternalLicensingEnabled $true;

<# Enable the Protect button, Encrypt Only and Do Not Forward in OWA #>
Set-IRMConfiguration -SimplifiedClientAccessEnabled $true -SimplifiedClientAccessEncryptOnlyDisabled $false -SimplifiedClientAccessDoNotForwardDisabled $false -EnablePdfEncryption $true;


Set-IRMConfiguration -SearchEnabled $true;

<# Confirm? #>

Get-IRMConfiguration;
Get-RMSTemplate;
Test-IRMConfiguration -Sender $AdminUpn;


<# Optional: Disable OME Clear OME v1 TPDs +v2? #>
Write-Host -Fore Yellow "Disabling OME v1 and v2 and re-enabling OME v2 only.";
Set-IRMConfiguration -AzureRMSLicensingEnabled $false -InternalLicensingEnabled $false -RMSOnlineKeySharingLocation $null -Force -Confirm:$false;
Set-IRMConfiguration -AzureRMSLicensingEnabled $true -InternalLicensingEnabled $true;
