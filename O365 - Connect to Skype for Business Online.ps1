<#
.SYNOPSIS
    Connect to Skype for Business Online PowerShell
.NOTES
    SETUP    
    Download and install the module.
        https://www.microsoft.com/en-us/download/details.aspx?id=39366
    Adjust the $me variable with your global admin's address.
    
    TROUBLESHOOTING
    Make sure the $PSVersionTable is up to date.
    You might need to update WMF and .NET if connecting from an older machine.
.LINK
    Download Skype for Business PowerShell module: https://www.microsoft.com/en-us/download/details.aspx?id=39366
    https://docs.microsoft.com/en-us/SkypeForBusiness/set-up-your-computer-for-windows-powershell/download-and-install-the-skype-for-business-online-connector
    https://docs.microsoft.com/en-us/SkypeForBusiness/set-up-your-computer-for-windows-powershell/set-up-your-computer-for-windows-powershell
#>

<# Connect to Skype for Business Online. #>
    $me = "admin@domain.onmicrosoft.com";
Import-Module SkypeOnlineConnector;
$session_sfb = New-CsOnlineSession -UserName $me -SessionOption (New-PSSessionOption -IdleTimeoutMSec (30 *60*1000));
Import-PSSession $session_sfb;

<# Close session? #>
Remove-PSSession $session_sfb;

<# #################### #>

<# Connect to Skype for Business Online without MFA enabled and store credentials. #>
    $me = "admin@domain.onmicrosoft.com";
$creds = Get-Credential -UserName $me -Message "Login:";
Import-Module SkypeOnlineConnector;
$session_sfb = New-CsOnlineSession -UserName $me -Credential $creds -SessionOption (New-PSSessionOption -IdleTimeoutMSec (30 *60*1000));
Import-PSSession $session_sfb;

<# Clear cached credentials? #>
$creds = $null;

<# #################### #>

<# Connect to Skype for Business Online without MFA and witout storing credentials. #>
    $me = "admin@domain.onmicrosoft.com";
Import-Module SkypeOnlineConnector;
$session_sfb = New-CsOnlineSession -UserName $me -Credential (Get-Credential -UserName $me -Message "Login:") -SessionOption (New-PSSessionOption -IdleTimeoutMSec (30 *60*1000));
Import-PSSession $session_sfb;

<# #################### #>

<# Skype for Business module installed? #>
Get-Module SkypeOnlineConnector -ListAvailable;

<# Import module directly? #>
Import-Module ($env:ProgramFiles + "\\Common Files\\Skype for Business Online\\Modules\\SkypeOnlineConnector\\SkypeOnlineConnector.psd1");
