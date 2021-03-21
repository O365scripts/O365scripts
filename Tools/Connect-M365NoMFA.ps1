<#
.SYNOPSIS
Connect to different M365 services using an admin without multi-factor authentication enabled.
.NOTES
Please note that is highly recommended for admins to have MFA enabled for security measures.
Refer to the following page if you need to install modules before connecting: <url>
Note that is not possible to connect to EXO v2 and Security & Compliance at the same time as connecting to one will simply disconnect the other.
.LINK
#>

<# Login? #>
$AdminUpn = "admin@domain.com";
$Tenant = "contoso";
$Creds = Get-Credential -Message "Login" -UserName $AdminUpn;

<# Connect to MSOL. #>
Import-Module MSOnline;
Connect-MsolService -Credential $Creds;

<# Connect to AAD. #>
Import-Module AzureAD;
Connect-AzureAD -AccountId $AdminUpn -Credential $Creds;

<# Connect to EXO or S&C. #>
Import-Module ExchangeOnlineManagement;
Connect-ExchangeOnline -UserPrincipalName $AdminUpn -Credential $Creds;
#Connect-IPPSSession -UserPrincipalName $AdminUpn -Credential $Creds;

<# Connect to SFB. #>
Import-Module MicrosoftTeams -RequiredVersion 1.1.6;
$Session_Sfb = New-CsOnlineSession -Credentials $Creds;
Import-PSSession $Session_Sfb;

<# Connect to SPO. #>
Import-Module Microsoft.Online.SharePoint.PowerShell;
Connect-SPOService -Url "https://$Tenant-admin.sharepoint.com" -Credential $Creds;

<# Connect to SPO PnP. #>
Import-Module PnP.PowerShell;
Connect-PnPOnline -Url "https://${Tenant}-my.sharepoint.com" -Interactive;
