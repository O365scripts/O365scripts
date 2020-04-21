<#
.SYNOPSIS
    Connect to Exchange Online v2 PowerShell.
.NOTES
    The EXO V2 module use Modern authentication for all cmdlets.
    You can't use Basic authentication in the EXO V2 module; however, you still need to configure the Basic authentication setting in WinRM.

    The latest version of PowerShell that's currently supported for the EXO V2 module is PowerShell 5.1.
    Support for PowerShell 6.0 or later is currently a work in progress and will be released soon.
    This also implies that EXO PowerShell V2 module won't work in Linux or Mac as of now.
.LINK
    https://docs.microsoft.com/en-us/powershell/exchange/exchange-online/exchange-online-powershell-v2/exchange-online-powershell-v2?view=exchange-ps
    https://www.powershellgallery.com/packages/exchangeonlinemanagement/
#>

<# Installation requirements? #>
Install-Module PowerShellGet -Force -Confirm:$false;

<# Install module as administrator? #>
Install-Module ExchangeOnlineManagement -Confirm:$false;

<# Install module as user? #>
Install-Module ExchangeOnlineManagement -Scope CurrentUser -Confirm:$false;


<# Connect to EXO v2 #>
    $me = "admin@tenantname.onmicrosoft.com";
Connect-ExchangeOnline -UserPrincipalName $me;

<# Connect to EXO v2 without MFA. #>
    $me = "admin@tenantname.onmicrosoft.com";
$creds = Get-Credential -UserName $me -Message "Login:";
Connect-ExchangeOnline -Credential $UserCredential


<# DEBUG: Connect to EXO v2 and output full logs? #>
    $me = "admin@tenantname.onmicrosoft.com";
    $path_log = "$env:USERPROFILE\Desktop\";
Connect-ExchangeOnline -UserPrincipalName $me -EnableErrorReporting -LogLevel All -LogDirectoryPath $path_log;

<# Disconnect? #>
