<#
.SYNOPSIS
Exchange Online Mailbox Alias Management
(link)
.NOTES
.LINK
Reference:
https://docs.microsoft.com/en-us/exchange/recipients/user-mailboxes/email-addresses?view=exchserver-2019
https://docs.microsoft.com/en-us/powershell/module/exchange/set-mailbox?view=exchange-ps
https://docs.microsoft.com/en-us/powershell/module/exchange/get-mailbox?view=exchange-ps
#>

<# Connect to EXO v2. #>
#Set-ExecutionPolicy RemoteSigned -Force -Confirm:$false;
#Install-Module ExchangeOnlineManagement -AllowClobber -Force -Confirm:$false;
$AdminUpn = "";
Connect-ExchangeOnline -UserPrincipalName $AdminUpn;

<# Add/remove a mailbox alias. #>
$User = "user@domain.com";
$Alias = "alias@domain.com";
Set-Mailbox $User -EmailAddresses @{add=$Alias};
Set-Mailbox $User -EmailAddresses @{remove=$Alias};

<# Verify aliases. #>
(Get-Mailbox $User).EmailAddresses

<# Add multiple mailbox aliases from CSV (Single column: SmtpAddress). #>
$User = "user@domain.com";
$PathCsv = "BulkAddMailboxAlias.csv";
Import-Csv $PathCsv | % {Set-Mailbox $User -EmailAddresses @{add=$_.SmtpAddress}};

<# Confirm which mailbox has a given alias. #>
$Alias = "";
Get-Recipient | Where {$_.EmailAddresses -match $Alias} | Select ExternalDirectoryObjectId,DisplayName,UserPrincipalName,EmailAddresses;