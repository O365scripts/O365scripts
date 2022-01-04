<#
.SYNOPSIS
M365 Module Installation Helper
https://github.com/O365scripts/O365scripts/blob/master/Tools/Install-M365Module.ps1
.NOTES
	> Pull the Get-M365ModuleOverview output and confirm which ones to install/update.
.LINK
Reference:
.EXAMPLE
Install-M35Module -Lite
Install-M35Module -Full
Install-M35Module -Fulll
#>

function Install-M365Module {
	[CmdletBinding()] Param ($Mode="Standard", $OutputMode="List");
	Begin {
		If ($null -eq $Domain) {
			Write-Host -Fore Red "MICROSOFT 365 DNS LOOKUP";
			$Domain = Read-Host -Prompt "Enter the domain name to lookup M365 related DNS records";
		}
	}
	Process {
	}
}
<# Options. #>
$ForceModuleUpdate = $true;
#$InstallModuleScope = "CurrentUser"; # Defaults to admin unless specified.

<# List of common modules. #>
$ListAllModules = "AADRM", 
	"AIPService", 
	"AzureAD",
	"AzureADPreview",
	"ExchangeOnlineManagement",
	"Microsoft.Online.SharePoint.PowerShell",
	"MicrosoftTeams",
	"MSGraph",
	"MSOnline",
	"MSCommerce",
	"NetworkTestingCompanion",
	"O365CentralizedAddInDeployment",
	"O365Troubleshooters",
	"PnP.PowerShell",
	#"SharePointPnPPowerShell2019","SharePointPnPPowerShell2016","SharePointPnPPowerShell2013",
	"SharePointPnPPowerShellOnline"
$ListPresetLite = "AzureAD MSOnline ExchangeOnlineManagement MicrosoftTeams Microsoft.Online.SharePoint.PowerShell MSGraph" -split " ";
$ListPresetFull = "AIPService AzureAD AzureADPreview ExchangeOnlineManagement Microsoft.Online.SharePoint.PowerShell MicrosoftTeams MSGraph MSOnline MSCommerce NetworkTestingCompanion O365CentralizedAddInDeployment O365Troubleshooters PnP.PowerShell" -split " ";

<# Confirm modules present. #>
$ListModules = $ListAllModules; #$ListPresetLite; #$ListPresetFull;

$GetModule = Get-Module -ListAvailable -Name $m -ErrorAction SilentlyContinue;
#$IsModuleInstalled = Get-InstalledModule X | Select Version;
$IsModuleInstalledAZ = Get-InstalledModule Az | Select Version;
$IsModuleInstalledAAD = Get-InstalledModule AzureAD | Select Version;
$IsModuleInstalledMSOL = Get-InstalledModule MSOnline | Select Version;
$IsModuleInstalledAzRMv1 = Get-InstalledModule AzureRM | Select Version;
$IsModuleInstalledAzRMv2 = Get-InstalledModule Az | Select Version;
$IsModuleInstalledAIP1 = Get-InstalledModule AADRM | Select Version;
$IsModuleInstalledAIPv2 = Get-InstalledModule AIPService | Select Version;
$IsModuleInstalledAIPClient = Get-InstalledModule AzureInformationProtection | Select Version;
$IsModuleInstalledEXOv2 = Get-InstalledModule ExchangeOnlineManagement | Select Version;
$IsModuleInstalledSPO = Get-InstalledModule Microsoft.Online.SharePoint.PowerShell | Select Version;
$IsModuleInstalledPNPv1 = Get-InstalledModule SharePointPnPPowerShellOnline | Select Version;
$IsModuleInstalledPNPv2 = Get-InstalledModule PnP.PowerShell | Select Version;
$IsModuleInstalledTeams = Get-InstalledModule MicrosoftTeams | Select Version;
#>

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
#>

<# Show list of modules. #>
Clear-Host;
Write-Host -NoNewline "AAD v1 (MSOL): ";
	if ($null -eq $IsModuleInstalledMSOL) {Write-Host -Fore Yellow "n/a"}
	elseif ($IsModuleInstalledMSOL.Count -gt 1) {Write-Host -Fore Yellow ($IsModuleInstalledMSOL.ForEach({$_.Version.ToString()}) -join ", ")}
	else {Write-Host -Fore Yellow $IsModuleInstalledMSOL.Version.ToString();}
Write-Host -NoNewline "Teams: ";
	if ($null -eq $IsModuleInstalledTeams) {Write-Host -Fore Yellow "n/a"}
	elseif ($IsModuleInstalledTeams.Count -gt 1) {Write-Host -Fore Yellow ($IsModuleInstalledTeams.ForEach({$_.Version.ToString()}) -join ", ")}
	else {Write-Host -Fore Yellow $IsModuleInstalledTeams.Version.ToString();}

#Write-Host -NoNewline "InsertNameOfModule: "; Write-Host $IsModuleInstalled;
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
#>

<# Install modules? #>
#Install-Module X -Force -Confirm:$false;
Write-Host -NoNewline "Teams: "; Write-Host -Fore Yellow $IsModuleInstalledTeams;
Install-Module Az -Force -Confirm:$false;
Install-Module AzureAD -Force -Confirm:$false;
Install-Module MSOnline -Force -Confirm:$false;
Install-Module AIPService -Force -Confirm:$false;
#Install-Module AzureRM -WhatIf; # Deprecated.

Install-Module ExchangeOnlineManagement -Force -Confirm:$false;

Install-Module Microsoft.Online.SharePoint.PowerShell -Force -Confirm:$false;
Install-Module PnP.PowerShell -Force -Confirm:$false;
Install-Module MicrosoftTeams -Force -Confirm:$false;
#Install-Module X -Force -Confirm:$false;
#>

<# Import modules? #>
#Import-Module X;
Import-Module MSGraph;
Import-Module Az;
Import-Module AzureAD;
Import-Module MSOnline;
Import-Module ExchangeOnlineManagement;
Import-Module MicrosoftTeams;
Import-Module PnP.PowerShell;
Import-Module Microsoft.Online.SharePoint.PowerShell;
