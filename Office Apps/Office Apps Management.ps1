<#
.SYNOPSIS
Office Apps Activation and Version Update Management
https://github.com/O365scripts/O365scripts/blob/master/Office%20Apps/Office%20Apps%20Management.ps1
.NOTES
.LINK
https://docs.microsoft.com/en-us/officeupdates/update-history-microsoft365-apps-by-date
https://docs.microsoft.com/en-us/deployoffice/overview-licensing-activation-microsoft-365-apps
https://docs.microsoft.com/en-us/office/troubleshoot/office-suite-issues/office-click-to-run-installation
https://support.microsoft.com/en-us/office/office-installed-with-click-to-run-and-windows-installer-on-same-computer-isn-t-supported-30775ef4-fa77-4f47-98fb-c5826a6926cd
https://support.microsoft.com/en-us/office/activate-office-5bd38f38-db92-448b-a982-ad170b1e187e
#>

<# Select which folder to run the OSPP vbs script to run from. #>
$ListPathOspp = @{
	"Office 2016 (x64 or x86)" = "$env:ProgramFiles\Microsoft Office\Office16\ospp.vbs";
	"Office 2016 (x86/64)" = "${env:ProgramFiles(x86)}\Microsoft Office\Office16\ospp.vbs";
	"Office 2013 (x64 or x86)" = "$env:ProgramFiles\Microsoft Office\Office15\ospp.vbs";
	"Office 2013 (x86/64)" = "${env:ProgramFiles(x86)}\Microsoft Office\Office15\ospp.vbs";
	"Office 2010 (x64 or x86)" = "$env:ProgramFiles\Microsoft Office\Office14\ospp.vbs";
	"Office 2010 (x86/64)" = "${env:ProgramFiles(x86)}\Microsoft Office\Office14\ospp.vbs";
	"Office 2007 (x86)" = "$env:ProgramFiles\Microsoft Office\Office13\ospp.vbs";
	"Office 2007 (x86/64)" = "${env:ProgramFiles(x86)}\Microsoft Office\Office13\ospp.vbs";
};
$PathOspp = $ListPathOspp | Out-GridView -OutputMode Single;
if (!(Get-Item $PathOspp.Value -ErrorAction SilentlyContinue)) {
	Write-Host -NoNewline "Unable to find the OSPP script in: "; Write-Host -Fore Yellow $PathOspp.Value;
}
<# Get the list of current Office activation keys. #>
& "$env:windir\System32\cscript.exe" $PathOspp /dstatus;
<#  Adjust the XXXXX with the activation key you want to remove and run once per key. #>
& "$env:windir\System32\cscript.exe" $PathOspp /unpkey XXXXX;


<# Update or downgrade Office Apps to a specific version. #>
$Version = "16.0.13801.20360";
Start-Process "$env:ProgramFiles\Common Files\Microsoft Shared\ClickToRun\OfficeC2RClient.exe" -ArgumentList "/Update user UpdateVersion=$Version";
