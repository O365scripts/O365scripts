<#
.SYNOPSIS
Get M365 Module Overview
https://github.com/O365scripts/O365scripts/blob/master/Tools/Get-M365ModuleOverview.ps1
.NOTES
.LINK
Reference:
https://docs.microsoft.com/en-us/office365/enterprise/powershell/connect-to-all-office-365-services-in-a-single-windows-powershell-window
https://docs.microsoft.com/en-us/office365/enterprise/powershell/connect-to-office-365-powershell
.EXAMPLE
Get-M365ModuleOverview -Silent;
Get-M365ModuleOverview | Select Module -Unique | Where {$_.Version -ne "n/a"} | % {Install-Module $_.Module -AllowClobber -Force -Confirm:$false -Scope CurrentUser -WhatIf};
#>
function Get-M365ModuleOverview {
	[CmdletBinding()] Param (
		[switch]$ExportReport,
		[string]$ExportReportPath = "$env:USERPROFILE\Downloads",
		[switch]$Silent
	)
Begin {
if (!$Silent) {Write-Host -Fore Red "M365 PS MODULE OVERVIEW";}
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
	;
$Report = [System.Collections.Generic.List[Object]]::new()
}

Process {
foreach ($m in ($ListAllModules | Sort)) {
	if (!$Silent) {Write-Host -NoNewline "Searching if the "; Write-Host -NoNewline -Fore Yellow $m; Write-Host -NoNewline " module is installed: ";}
	$GetModule = Get-Module -ListAvailable -Name $m -ErrorAction SilentlyContinue;
	# Module not found.
	if ($null -eq $GetModule) {
		if (!$Silent) {Write-Host -Fore Red "NO";}
		#if ($ExportReport) {
			$ReportLine = [PSCustomObject]@{Module = $m; Version = "n/a"}
			$Report.Add($ReportLine);	
		#}
	}
	# Module found.
	else {
		if (!$Silent) {
			Write-Host -NoNewLine -Fore Green "YES";
			Write-Host -NoNewline " (";
		}
		# More than one version of module present.
		if (($GetModule).Count -gt 1) {
			if (!$Silent) {Write-Host -NoNewLine -Fore Yellow (($GetModule | Select -ExpandProperty Version) -join " ");}
			#if ($ExportReport) {
				# Building report lines for each version.
				foreach ($v in $GetModule) {
					$ReportLine = [PSCustomObject]@{Module = [string]$v.Name; Version = [string]$v.Version};
					$Report.Add($ReportLine);
					}
			#	}
			}
		else {
			if (!$Silent) {Write-Host -NoNewline -Fore Yellow $GetModule.Version;}
			# Build report line for version.
			#if ($ExportReport) {
				$Report.Add([PSCustomObject]@{Module = $GetModule.Name; Version = $GetModule.Version});
				#$ReportLine = [PSCustomObject]@{Module = $GetModule.Name; Version = $GetModule.Version}7#É
				#$Report.Add($ReportLine);
			#	}
			}
		if (!$Silent) {Write-Host ")";}
		}
	}
if ($ExportReport) {
	$Report | Export-Csv -Path "$ExportReportPath\M365ModuleOverview_$(Get-Date -Format "yyyyMMddhhmmss").csv" -NoTypeInformation -Encoding utf8 -Verbose;
	}
}

End {Return $Report;}
}