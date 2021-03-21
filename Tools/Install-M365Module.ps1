<#
.SYNOPSIS
Module Installation Helper
https://github.com/O365scripts/O365scripts/blob/master/Tools/Install-M365Modules.ps1
.NOTES
.LINK
.EXAMPLE
#>

<# Options. #>
$ForceModuleUpdate = $false;
$TeamsModuleRequiredVersion = "1.1.6"; # Need to use previous version since 2.0.0 doesn't have New-CsOnlineSession.

<# Missing modules? #>
#$IsModuleInstalled = Get-Module X -ListAvailable | Select Version;
$IsModuleInstalledMSOL = Get-Module MSOnline -ListAvailable | Select Version;
$IsModuleInstalledAAD = Get-Module AzureAD -ListAvailable | Select Version;
$IsModuleInstalledAzRMv1 = Get-Module AzureRM -ListAvailable | Select Version;
$IsModuleInstalledAzRMv2 = Get-Module Az -ListAvailable | Select Version;
$IsModuleInstalledAIP1 = Get-Module AADRM -ListAvailable | Select Version;
$IsModuleInstalledAIPv2 = Get-Module AIPService -ListAvailable | Select Version;
$IsModuleInstalledAIPClient = Get-Module AzureInformationProtection -ListAvailable | Select Version;
$IsModuleInstalledEXOv2 = Get-Module ExchangeOnlineManagement -ListAvailable | Select Version;
$IsModuleInstalledSPO = Get-Module Microsoft.Online.SharePoint.PowerShell -ListAvailable | Select Version;
$IsModuleInstalledPNPv1 = Get-Module SharePointPnPPowerShellOnline -ListAvailable | Select Version;
$IsModuleInstalledPNPv2 = Get-Module PnP.PowerShell -ListAvailable | Select Version;
$IsModuleInstalledTeams = Get-Module MicrosoftTeams -ListAvailable | Select Version;

<# Fill empty values. #>
#if ($null -eq $IsModuleInstalled) {$IsModuleInstalled = "n/a"}
if ($null -eq $IsModuleInstalledAAD) {$IsModuleInstalledAAD = "n/a"}
if ($null -eq $IsModuleInstalledAzRMv1) {$IsModuleInstalledAzRMv1 = "n/a"}
if ($null -eq $IsModuleInstalledAzRMv2) {$IsModuleInstalledAzRMv2 = "n/a"}
if ($null -eq $IsModuleInstalledAIPv2) {$IsModuleInstalledAIPv2 = "n/a"}
if ($null -eq $IsModuleInstalledEXOv2) {$IsModuleInstalledEXOv2 = "n/a"}
if ($null -eq $IsModuleInstalledSPO) {$IsModuleInstalledSPO = "n/a"}
if ($null -eq $IsModuleInstalledPNPv1) {$IsModuleInstalledPNPv1 = "n/a"}
if ($null -eq $IsModuleInstalledPNPv2) {$IsModuleInstalledPNPv2 = "n/a"}
if ($null -eq $IsModuleInstalledTeams) {$IsModuleInstalledTeams = "n/a"}

<# Show list of modules. #>
Clear-Host;
#Write-Host -NoNewline ": "; Write-Host $IsModuleInstalled;
Write-Host -NoNewline "AAD v1 (MSOL): ";
	if ($null -eq $IsModuleInstalledMSOL) {Write-Host -Fore Yellow "n/a"}
	elseif ($IsModuleInstalledMSOL.Count -gt 1) {Write-Host -Fore Yellow ($IsModuleInstalledMSOL.ForEach({$_.Version.ToString()}) -join ", ")}
	else {Write-Host -Fore Yellow $IsModuleInstalledMSOL.Version.ToString();}
Write-Host -NoNewline "Teams: ";
	if ($null -eq $IsModuleInstalledTeams) {Write-Host -Fore Yellow "n/a"}
	elseif ($IsModuleInstalledTeams.Count -gt 1) {Write-Host -Fore Yellow ($IsModuleInstalledTeams.ForEach({$_.Version.ToString()}) -join ", ")}
	else {Write-Host -Fore Yellow $IsModuleInstalledTeams.Version.ToString();}

Write-Host -NoNewline "AAD v2 (AzureAD): "; Write-Host -Fore Yellow $IsModuleInstalledAAD;
Write-Host -NoNewline "AzureRM v1: "; Write-Host -Fore Yellow $IsModuleInstalledAzRMv1;
Write-Host -NoNewline "AzureRM v2 (Az): "; Write-Host -Fore Yellow $IsModuleInstalledAzRMv2;
Write-Host -NoNewline "AADRM (deprecated): "; Write-Host -Fore Yellow $IsModuleInstalledAIPv1;
Write-Host -NoNewline "AIPService: "; Write-Host -Fore Yellow $IsModuleInstalledAIPv2;
Write-Host -NoNewline "Exchange Online v2: "; Write-Host -Fore Yellow $IsModuleInstalledEXOv2;
Write-Host -NoNewline "SharePoint Online: "; Write-Host -Fore Yellow $IsModuleInstalledSPO;
Write-Host -NoNewline "SPO PnP v1: "; Write-Host -Fore Yellow $IsModuleInstalledPNPv1;
Write-Host -NoNewline "SPO PnP v2: "; Write-Host -Fore Yellow $IsModuleInstalledPNPv2;
Write-Host -NoNewline "Teams: ";
	if ($null -eq $IsModuleInstalledTeams) {Write-Host -Fore Yellow "n/a"}
	elseif ($IsModuleInstalledTeams.Count -gt 1) {Write-Host -Fore Yellow ($IsModuleInstalledTeams.ForEach({$_.Version.ToString()}) -join ", ")}
	else {Write-Host -Fore Yellow $IsModuleInstalledTeams.Version.ToString();}
<# Install modules? #>
#Install-Module X -Force -Confirm:$false;
Write-Host -NoNewline "Teams: "; Write-Host -Fore Yellow $IsModuleInstalledTeams;

Install-Module MSOnline -Force -Confirm:$false;
Install-Module AzureAD -Force -Confirm:$false;
#Install-Module AzureRM; # Deprecated.
Install-Module Az -Force -Confirm:$false;
Install-Module AIPService -Force -Confirm:$false;
Install-Module ExchangeOnlineManagement -Force -Confirm:$false;
Install-Module Microsoft.Online.SharePoint.PowerShell -Force -Confirm:$false;
Install-Module PnP.PowerShell -Force -Confirm:$false;
Install-Module MicrosoftTeams -Force -Confirm:$false;
Install-Module MicrosoftTeams -RequiredVersion $TeamsModuleRequiredVersion -Force -Confirm:$false;
#Install-Module X -Force -Confirm:$false;


<# Import modules. #>
#Import-Module X;
Import-Module MSOnline;
Import-Module AzureAD;
#Import-Module MicrosoftTeams;
Import-Module MicrosoftTeams -RequiredVersion 1.1.6;
Import-Module PnP.PowerShell;