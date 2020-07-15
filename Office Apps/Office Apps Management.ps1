<#
.SYNOPSIS
.NOTES
.LINK
https://docs.microsoft.com/en-us/officeupdates/update-history-microsoft365-apps-by-date
https://docs.microsoft.com/en-us/deployoffice/overview-licensing-activation-microsoft-365-apps
https://docs.microsoft.com/en-us/office/troubleshoot/office-suite-issues/office-click-to-run-installation
https://support.microsoft.com/en-us/office/office-installed-with-click-to-run-and-windows-installer-on-same-computer-isn-t-supported-30775ef4-fa77-4f47-98fb-c5826a6926cd
https://support.microsoft.com/en-us/office/activate-office-5bd38f38-db92-448b-a982-ad170b1e187e
#>

<# Possible OSPP paths for 32/64 bit OS with 32/64 bit apps. #>
$path_ospp2016 = "$env:ProgramFiles\Microsoft Office\Office16\ospp.vbs";
$path_ospp2016x86 = "${env:ProgramFiles(x86)}\Microsoft Office\Office16\ospp.vbs"
$path_ospp2013 = "$env:ProgramFiles\Microsoft Office\Office15\ospp.vbs";
$path_ospp2013x86 = "${env:ProgramFiles(x86)}\Microsoft Office\Office15\ospp.vbs"
$path_ospp2010 = "$env:ProgramFiles\Microsoft Office\Office14\ospp.vbs";
$path_ospp2010x86 = "${env:ProgramFiles(x86)}\Microsoft Office\Office14\ospp.vbs"
$path_ospp2007 = "$env:ProgramFiles\Microsoft Office\Office13\ospp.vbs";
$path_ospp2007x86 = "${env:ProgramFiles(x86)}\Microsoft Office\Office13\ospp.vbs"

<# Specify the path of the OSPP vbs script to use. #>
$path_ospp = $path_ospp2016;

<# List current Office activation keys and remove one by specifying it's last five digits. #>
& "$env:windir\System32\cscript.exe" $path_ospp /dstatus;
& "$env:windir\System32\cscript.exe" $path_ospp /unpkey XXXXX;


<# Update or downgrade Office Apps to a specific version. #>
$version = "16.0.12827.20470";
Start-Process "$env:ProgramFiles\Common Files\Microsoft Shared\ClickToRun\OfficeC2RClient.exe" -ArgumentList "/Update user UpdateVersion=$version";
