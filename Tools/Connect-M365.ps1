<#
.SYNOPSIS
Quick connection to M365 PowerShell.
https://github.com/O365scripts/O365scripts/blob/master/Tools/Connect-M365.ps1
.NOTES
This script does not validate the presence of any of the modules before connecting and assume they are already installed.
If you do need to install some of the modules you can refer to the following script: <link>
Uncomment and adjust the connection options with your admin and tenant details before running.
Adjust the connection options and the modules needed prior to running.
.LINK
#>

<# Connection options. #>
$AdminUpn = "";
$Tenant = "";
$AdminIsMfaEnabled = $false;

<# Get admin credentials if account is not MFA enabled. #>
if (!$AdminIsMfaEnabled) {$Creds = Get-Credential -Message "Login" -UserName $AdminUpn}

<# Which modules to connect? #>
$ConnectToMSOL	= 0;
$ConnectToAAD	= 0;
$ConnectToAz	= 0;
$ConnectToEXO	= 0; $ConnectToSCC = 0;
#$ConnectToSFBO	= 0;
$ConnectToTeams	= 0;
$ConnectToSPO	= 0;
$ConnectToPNP	= 0;

<# Specify which site url to use if you want to auto connect to PNP. #>
if ($ConnectToPNP) {
	$PnpSiteUrl = "https://${Tenant}.sharepoint.com/sites/NameOfSite";
	#$PnpSiteUrl = "https://${Tenant}-admin.sharepoint.com";
	#$PnpSiteUrl = "https://${Tenant}-my.sharepoint.com/personal/jdoe_contoso_com";
	#$PnpSiteUrl = "https://${Tenant}-admin.sharepoint.com";
}

<# MSOL #>
if ($ConnectToMSOL) {
	Import-Module MSOnline;
	if (!$AdminIsMfaEnabled) {Connect-MsolService -Credential $Creds}
	else {Connect-MsolService};
}
<# AzureAD #>
if ($ConnectToAAD) {
	Import-Module AzureAD;
	if (!$AdminIsMfaEnabled) {Connect-AzureAD -AccountId $AdminUpn -Credential $Creds}
	else {Connect-AzureAD -AccountId $AdminUpn}
}
<# Az (aka AzureRM v2) #>
if ($ConnectToAz) {
	Import-Module Az;
	if (!$AdminIsMfaEnabled) {Connect-AzAccount -Credential $Creds}
	else {Connect-AzAccount}
}

<# Check if EXO and SCC are both enabled. #>
if ($ConnectToEXO -and $ConnectToSCC) {
	Write-Host -NoNewline -Fore Red "Warning: ";
	Write-Host -Fore Yellow "Both the Exchange Online and Security & Compliance connection options were enabled but only one of these services can be connected at the same. Connecting to EXO instead.";
	$ConnectToSCC = 0;
}
<# Exchange Online v2 #>
if ($ConnectToEXO) {
	Import-Module ExchangeOnlineManagement;
	if (!$AdminIsMfaEnabled) {Connect-ExchangeOnline -UserPrincipalName $AdminUpn -Credential $Creds}
	else {Connect-ExchangeOnline -UserPrincipalName $AdminUpn}
}
<# Security & Compliance via EXO v2 module. #>
if ($ConnectToSCC) {
	Import-Module ExchangeOnlineManagement;
	if (!$AdminIsMfaEnabled) {Connect-IPPSSession -UserPrincipalName $AdminUpn -Credential $Creds}
	else {Connect-IPPSSession -UserPrincipalName $AdminUpn}
}
<# [DEPRECATED] Skype for Business Online via specific Teams module version. #>
<#
if ($ConnectToSFBO) {
	Import-Module MicrosoftTeams -RequiredVersion 1.1.6;
	if (!$AdminIsMfaEnabled) {$Session_Sfb = New-CsOnlineSession -Credential $Creds -OverrideAdminDomain "${Tenant}.onmicrosoft.com"}
	else {$Session_Sfb = New-CsOnlineSession -OverrideAdminDomain "${Tenant}.onmicrosoft.com"}
	Import-PSSession $Session_Sfb;
} #>
<# Teams #>
if ($ConnectToTeams) {
	Import-Module MicrosoftTeams;
	Connect-MicrosoftTeams;
}
<# SPO #>
if ($ConnectToSPO) {
	Import-Module Microsoft.Online.SharePoint.PowerShell;
	if (!$AdminIsMfaEnabled) {Connect-SPOService -Url "https://${Tenant}-admin.sharepoint.com" -Credential $Creds}
	else {Connect-SPOService -Url "https://${Tenant}-admin.sharepoint.com"}
}
<# SharePoint PnP #>
if ($ConnectToPNP) {
	if ($PnpSiteUrl) {
		Import-Module PnP.PowerShell;
		if (!$AdminIsMfaEnabled) {Connect-PnPOnline -Url $PnpSiteUrl -Credential $Creds}
		else {Connect-PnPOnline -Url $PnpSiteUrl -UseWebLogin}	
	}
	else {
		Write-Host -NoNewline -Fore Red "Warning: ";
		Write-Host -Fore Yellow "The `$PnpSiteUrl value was not specified so no connection to PNP will be attempted.";
	}
}

<# X #>
<#
if ($ConnectToX) {
	Import-Module X;
	if (!$AdminIsMfaEnabled) {Connect-X -Credential $Creds}
	else {Connect-X}
}
#>