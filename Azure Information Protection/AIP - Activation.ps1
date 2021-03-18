<#
.SYNOPSIS
https://github.com/O365scripts/O365scripts/edit/master/Azure%20Information%20Protection/AIP%20-%20Activation.ps1

.NOTES
Do not activate the protection service if you have Active Directory Rights Management Services (AD RMS) deployed for your organization.

.LINK
https://docs.microsoft.com/en-us/azure/information-protection/install-powershell
https://docs.microsoft.com/en-us/azure/information-protection/activate-service
https://docs.microsoft.com/en-us/powershell/module/aipservice/enable-aipservice?view=azureipps
#>

<# Previous version using the former AADRM module commands. #>
$LicensingLocation = (Get-AadrmConfiguration).LicensingIntranetDistributionPointUrl
Set-IRMConfiguration -LicensingLocation @{add=$LicensingLocation}
Set-IRMConfiguration -AzureRMSLicensingEnabled $true -InternalLicensingEnabled $true
Set-IRMConfiguration -SimplifiedClientAccessEnabled $true
Set-IRMConfiguration -ClientAccessServerEnabled $true
Get-IRMConfiguration

<# TODO: Updated version. #>
# ...
