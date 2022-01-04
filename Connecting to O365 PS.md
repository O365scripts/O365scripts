# Connecting to Office 365 PowerShell
## Getting Started
 - [System Requirements](https://docs.microsoft.com/en-us/powershell/scripting/windows-powershell/install/windows-powershell-system-requirements)
 - [Script Execution](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-7.2#change-the-execution-policy)
 - WinRM
 - [Windows Management Framework](https://docs.microsoft.com/en-us/powershell/scripting/windows-powershell/wmf/overview?view=powershell-7)
 - PowerShell vs PowerShell Core
## Modules
 - [Azure AD](https://docs.microsoft.com/en-us/powershell/azure/active-directory/install-adv2?view=azureadps-2.0)
 - [Azure Information Protection](https://docs.microsoft.com/en-us/azure/information-protection/install-powershell)
 - [Commerce](https://docs.microsoft.com/en-us/microsoft-365/commerce/subscriptions/allowselfservicepurchase-powershell?view=o365-worldwide)
 - [Exchange Online](https://docs.microsoft.com/en-us/powershell/exchange/exchange-online-powershell-v2?view=exchange-ps)
 - [Microsoft Teams](https://docs.microsoft.com/en-us/microsoftteams/teams-powershell-install)
 - [SharePoint Online](https://docs.microsoft.com/en-us/powershell/sharepoint/sharepoint-online/connect-sharepoint-online)
 - [SharePoint PnP](https://pnp.github.io/powershell/)
 - [Skype for Business](https://docs.microsoft.com/en-us/microsoft-365/enterprise/manage-skype-for-business-online-with-microsoft-365-powershell?view=o365-worldwide)

# Connecting to Azure AD
```PowerShell
#Install-Module AzureAD -AllowClobber -Force -Confirm:$false;
Import-Module AzureAD;
Connect-AzureAD;
```
# Connecting to Azure Information Protection v2
```PowerShell
#Install-Module AIPService -AllowClobber -Force -Confirm:$false;
Import-Module AIPService;
Connect-AIPService;
```
# Connecting to Commerce
```PowerShell
#Install-Module MSCommerce -AllowClobber -Force -Confirm:$false;
Import-Module MSCommerce;
Connect-MSCommerce;
```
# Connecting to Exchange Online v2
```PowerShell
#Install-Module ExchangeOnlineManagement -AllowClobber -Force -Confirm:$false;
Import-Module ExchangeOnlineManagement;
Connect-ExchangeOnline;
```
# Connecting to Microsoft Teams
```PowerShell
#Install-Module MicrosoftTeams -AllowClobber -Force -Confirm:$false;
Import-Module MicrosoftTeams;
Connect-MicrosoftTeams;
```
# Connecting to Security & Compliance
```PowerShell
#Install-Module ExchangeOnlineManagement -AllowClobber -Force -Confirm:$false;
Import-Module ExchangeOnlineManagement;
Connect-IPPSSession;
```
# Connecting to SharePoint Online
```PowerShell
#Install-Module Microsoft.Online.SharePoint.PowerShell -AllowClobber -Force -Confirm:$false;
Import-Module Microsoft.Online.SharePoint.PowerShell;
Connect-SPOService -Url "https://tenant-admin.sharepoint.com";
```
# Connecting to SharePoint PnP v2
```PowerShell
#Install-Module PnP.PowerShell -AllowClobber -Force -Confirm:$false;
#Register-PnPManagementShellAccess
Import-Module PnP.PowerShell;
Connect-PnPOnline -Url "https://tenant.sharepoint.com/sites/test" -Interactive;
```
