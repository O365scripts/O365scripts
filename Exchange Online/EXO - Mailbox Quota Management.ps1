<#
.SYNOPSIS
	Mailbox Quota Management
.NOTES

.LINK
https://docs.microsoft.com/en-us/powershell/module/exchange/mailboxes/set-mailbox?view=exchange-ps
https://docs.microsoft.com/en-us/exchange/recipients/user-mailboxes/storage-quotas?view=exchserver-2019
https://support.microsoft.com/en-us/help/2490230/how-to-set-exchange-online-mailbox-sizes-and-limits-in-the-office-365
#>

<# Set mailbox quota to 100GB on a single mailbox #>
$mbox = "";
$quota_psrq = "100GB";
$quota_psq = "99.75GB";
$quota_iwq = "99.50GB";
Set-Mailbox $mbox -ProhibitSendReceiveQuota $quota_psrq -ProhibitSendQuota $quota_psq -IssueWarningQuota $quota_iwq;
Get-Mailbox $mbox | select PrimarySMTPAddress, ProhibitSendReceiveQuota, ProhibitSendQuota, IssueWarningQuota;

<# Set mailbox quota to 50GB on a single mailbox #>
$mbox = "";
$quota_psrq = "50GB";
$quota_psq = "49.75GB";
$quota_iwq = "49.50GB";
Set-Mailbox $mbox -ProhibitSendReceiveQuota $quota_psrq -ProhibitSendQuota $quota_psq -IssueWarningQuota $quota_iwq;
Get-Mailbox $mbox | select PrimarySMTPAddress, ProhibitSendReceiveQuota, ProhibitSendQuota, IssueWarningQuota;

<# Confirm mailbox quotas? #>
Get-Mailbox | select PrimarySMTPAddress, ProhibitSendReceiveQuota, ProhibitSendQuota, IssueWarningQuota | Out-GridView;
