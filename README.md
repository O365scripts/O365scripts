# Office 365 Scripts
https://github.com/O365scripts/O365scripts

*Welcome to my slowly-expanding collection of O365/M365-related scripts!*

#### System Requirements
* While it possible to use PS on both [Linux](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-linux?view=powershell-7) and [Mac](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-macos?view=powershell-7), these scripts were made and tested on Windows using PS 5.1 but not on PS [Core](https://github.com/PowerShell/PowerShell) (version 6,7+).
* When running on an older Windows system and the **$PSVersionTable** is less than **5.1**, the [WMF](https://docs.microsoft.com/en-us/powershell/scripting/windows-powershell/wmf/setup/install-configure?view=powershell-7) will need to be updated and possibly [.NET](https://dotnet.microsoft.com/download/dotnet-framework/thank-you/net48-web-installer) as well or you may have issues connecting to services.
* Script execution will need to be enabled once before being able to run scripts with the [Set-ExecutionPolicy](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.security/set-executionpolicy?view=powershell-7) command. Use the -Scope CurrentUser parameter if you do not have any local administrative rights.

#### Official 365 Documentation
 * Exchange Online [v2](https://docs.microsoft.com/en-us/powershell/exchange/connect-to-exchange-online-powershell?view=exchange-ps) / [v1](https://docs.microsoft.com/en-us/powershell/exchange/basic-auth-connect-to-exo-powershell?view=exchange-ps)
 * Skype for Business via [teams](https://docs.microsoft.com/en-us/microsoftteams/teams-powershell-overview) | [exe](https://docs.microsoft.com/en-us/microsoft-365/enterprise/manage-skype-for-business-online-with-microsoft-365-powershell?view=o365-worldwide)
 * [SharePoint Online](https://docs.microsoft.com/en-us/powershell/sharepoint/sharepoint-online/connect-sharepoint-online?view=sharepoint-ps) / [PNP](https://docs.microsoft.com/en-us/powershell/sharepoint/sharepoint-pnp/sharepoint-pnp-cmdlets?view=sharepoint-ps)

#### Tools
 * Office Deployment Tool [Download](https://go.microsoft.com/fwlink/p/?LinkID=626065) / [Config](https://config.office.com/deploymentsettings) / [Overview](https://docs.microsoft.com/en-us/deployoffice/overview-office-deployment-tool)
 * Admin Center [Help](https://docs.microsoft.com/en-us/microsoft-365/admin/?view=o365-worldwide)

#### Issues

#### Contribution

#### License

#### Legal Disclaimer
Use this software at your own risk. This software comes with no warranty, either express or implied.
I assume no liability for the use or misuse of this software or its derivatives.
This software is offered "as-is". I will not install, remove, operate or support this software at your request.
If you are unsure of how this software will interact with your system, do not use it.
