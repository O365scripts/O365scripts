<#
.SYNOPSIS
    Reconnect a soft deleted or deleted mailbox recipient onto an existing active one.
.NOTES
	Use the New-MailboxRestoreRequest cmdlet to restore a soft-deleted or disconnected mailbox.
	This cmdlet starts the process of moving content from the soft-deleted mailbox, disabled mailbox, or any mailbox in a recovery database into a connected primary or archive mailbox.

	Please make sure to confirm and double check the source and destination mailbox before proceeding.
	If there is a previous archive mailbox to restore, make sure it is enabled on the destination mailbox.
.LINK
    https://docs.microsoft.com/en-us/powershell/module/exchange/mailboxes/New-MailboxRestoreRequest
#>


<# Which mailbox do you want restore FROM? #>
$mbox_src = Get-Mailbox -SoftDeletedMailbox | select Name,PrimarySmtpAddress,ArchiveStatus,WhenCreated,ExchangeGuid,Guid,WindowsLiveId,DistinguishedName | Out-GridView -Title "Which soft-deleted mailbox do you want restore from?" -PassThru;
#$mbox_src = Get-Mailbox -InactiveMailboxOnly | select Name,PrimarySmtpAddress,ArchiveStatus,WhenCreated,ExchangeGuid,Guid,DistinguishedName | Out-GridView -Title "Which deleted mailbox do you want restore from?" -PassThru;

<# Which mailbox do you want restore TO? #>
$mbox_dest = Get-Mailbox | select Name,ExchangeGuid,PrimarySmtpAddress,WhenCreated,DistinguishedName | Out-GridView -Title "Which actove mailbox do you want restore to?" -PassThru;

<# Confirm before running! #>
New-MailboxRestoreRequest -SourceMailbox $mbox_src.DistinguishedName -TargetMailbox $mbox_dest.DistinguishedName -AllowLegacyDNMismatch;

<# Archive mailbox enabled? #>
New-MailboxRestoreRequest -SourceMailbox $mbox_src.DistinguishedName -SourceIsArchive -TargetMailbox $mbox_dest.DistinguishedName -TargetIsArchive -AllowLegacyDNMismatch;

<# View current progress? #>
Get-MailboxRestoreRequest;
