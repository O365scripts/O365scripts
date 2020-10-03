# Office 365 Scripts
*Welcome to my slowly-expanding collection of O365/M365-related scripts!*

#### System Requirements
* While it possible to use PS on both [Linux](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-linux?view=powershell-7) and [Mac](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-macos?view=powershell-7), it is recommended to use 5.1 instead of the [Core](https://github.com/PowerShell/PowerShell) version (7/6) which is known to have compatibility issues so you will mostly need to be on a Windows system to run these scripts.
* If running on an older Windows OS system and the **$PSVersionTable** shows that the PS version is lower than **5.1**, the  [WMF](https://docs.microsoft.com/en-us/powershell/scripting/windows-powershell/wmf/setup/install-configure?view=powershell-7) will need to be updated and possibly [.NET](https://dotnet.microsoft.com/download/dotnet-framework/thank-you/net48-web-installer) as well. 
* Script execution will need to be enabled once before being able to run scripts with [Set-ExecutionPolicy](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.security/set-executionpolicy?view=powershell-7).

#### Official 365 Documentation
 * Exchange Online [v2](https://docs.microsoft.com/en-us/powershell/exchange/connect-to-exchange-online-powershell?view=exchange-ps) / [v1](https://docs.microsoft.com/en-us/powershell/exchange/basic-auth-connect-to-exo-powershell?view=exchange-ps)
 * Skype for Business via [exe](https://docs.microsoft.com/en-us/microsoft-365/enterprise/manage-skype-for-business-online-with-microsoft-365-powershell?view=o365-worldwide) / [teams]()
 * [SharePoint Online](https://docs.microsoft.com/en-us/powershell/sharepoint/sharepoint-online/connect-sharepoint-online?view=sharepoint-ps) / [PNP](https://docs.microsoft.com/en-us/powershell/sharepoint/sharepoint-pnp/sharepoint-pnp-cmdlets?view=sharepoint-ps)

#### Tools
 * Office Deployment Tool [Download](https://go.microsoft.com/fwlink/p/?LinkID=626065) / [Config](https://config.office.com/deploymentsettings) / [Overview](https://docs.microsoft.com/en-us/deployoffice/overview-office-deployment-tool)
 * Admin Center [Help](https://docs.microsoft.com/en-us/microsoft-365/admin/?view=o365-worldwide)
