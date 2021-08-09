<#
.SYNOPSIS
.NOTES
.LINK
https://docs.microsoft.com/en-us/onedrive/use-group-policy
https://support.microsoft.com/en-us/office/onedrive-won-t-start-0c158fa6-0cd8-4373-98c8-9179e24f10f2
https://support.microsoft.com/en-us/office/which-onedrive-app-19246eae-8a51-490a-8d97-a645c151f2ba
https://docs.microsoft.com/en-us/onedrive/plan-onedrive-enterprise
https://docs.microsoft.com/en-us/onedrive/deploy-on-windows
https://docs.microsoft.com/en-us/windows/win32/sysinfo/registry-value-types
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-itemproperty?view=powershell-7
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/remove-itemproperty?view=powershell-7
#>

<# Common example registry paths. #>
$reg_path = "";
$reg_path = "HKCU:\";
$reg_path = "HKCU:\Software\Microsoft\Office\16.0"
$reg_path = "HKLM:\";
$reg_path = "HKLM:\Software\Microsoft\Windows\OneDrive";


<# Interactive: Registry type selection. #>
$list_regtypes = "REG_BINARY", "REG_DWORD", "REG_DWORD_LITTLE_ENDIAN", "REG_DWORD_BIG_ENDIAN", "REG_EXPAND_SZ", "REG_LINK", "REG_MULTI_SZ", "REG_NONE", "REG_QWORD", "REG_QWORD_LITTLE_ENDIAN", "REG_SZ";
$reg_type = $list_regtypes | Out-GridView -OutputMode Single;

<# Create or set registry key . #>
$reg_type = "";
$reg_path = "";
$reg_name = "";
$reg_value = "";
New-ItemProperty -PropertyType $reg_type -Path $reg_path -Name $reg_name -Value $reg_value -Force;

<# Remove a registry entry. #>
$reg_path = "";
$reg_name = "";
Remove-ItemProperty -Path $reg_path -Name $reg_name -Force;


<# Prevent the usage of OneDrive for file storage. #>
$reg_path = "HKLM:\Software\Microsoft\Windows\OneDrive";
$reg_name = "DisableFileSyncNGSC";

<# Prevent users from syncing personal OneDrive accounts. #>
$reg_path = "HKLM:\Software\Microsoft\Windows\OneDrive";
$reg_name = "DisablePersonalSync";

<# Disable the tutorial that appears at the end of OneDrive Setup. #>
$reg_path = "HKLM:\Software\Microsoft\Windows\OneDrive";
$reg_name = "DisableTutorial";

<# Use OneDrive Files On-Demand. #>
$reg_path = "HKLM:\Software\Microsoft\Windows\OneDrive";
$reg_name = "FilesOnDemandEnabled";
