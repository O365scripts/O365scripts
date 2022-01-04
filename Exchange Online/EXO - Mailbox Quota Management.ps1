<#
.SYNOPSIS
Mailbox Quota Management
https://github.com/O365scripts/O365scripts/blob/master/Exchange%20Online/EXO%20-%20Mailbox%20Quota%20Management.ps1
.NOTES
.LINK
https://docs.microsoft.com/en-us/powershell/module/exchange/mailboxes/set-mailbox?view=exchange-ps
https://docs.microsoft.com/en-us/exchange/recipients/user-mailboxes/storage-quotas?view=exchserver-2019
https://support.microsoft.com/en-us/help/2490230/how-to-set-exchange-online-mailbox-sizes-and-limits-in-the-office-365
#>

<# Connect to EXO v2. #>
#Set-ExecutionPolicy RemoteSigned -Force -Confirm:$false;
#Install-Module ExchangeOnlineManagement -AllowClobber -Force -Confirm:$false;
$AdminUpn = "";
Connect-ExchangeOnline -UserPrincipalName $AdminUpn;

<# Set mailbox quota to 100GB on a single mailbox #>
$User = "";
$QuotaPsrq = "100GB";
$QuotaPsq = "99.75GB";
$QuotaIwq = "99.50GB";
Set-Mailbox $mbox -ProhibitSendReceiveQuota $QuotaPsrq -ProhibitSendQuota $QuotaPsq -IssueWarningQuota $QuotaIwq;
Get-Mailbox $mbox | Select PrimarySMTPAddress, ProhibitSendReceiveQuota, ProhibitSendQuota, IssueWarningQuota;

<# Set mailbox quota to 50GB on a single mailbox #>
$User = "";
$QuotaPsrq = "50GB";
$QuotaPsq = "49.75GB";
$QuotaIwq = "49.50GB";
Set-Mailbox $User -ProhibitSendReceiveQuota $QuotaPsrq -ProhibitSendQuota $QuotaPsq -IssueWarningQuota $QuotaIwq;
Get-Mailbox $User | Select PrimarySMTPAddress, ProhibitSendReceiveQuota, ProhibitSendQuota, IssueWarningQuota;

<# Confirm quota of all users. #>
Get-Mailbox | Select PrimarySMTPAddress, ProhibitSendReceiveQuota, ProhibitSendQuota, IssueWarningQuota;
