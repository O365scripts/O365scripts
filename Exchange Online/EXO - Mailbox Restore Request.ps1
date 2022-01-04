<#
.SYNOPSIS
Reconnect a soft deleted or deleted mailbox recipient onto an existing active one.
.NOTES
Use the New-MailboxRestoreRequest cmdlet to restore a soft-deleted or disconnected mailbox.
This cmdlet starts the process of moving content from the soft-deleted mailbox, disabled mailbox, or any mailbox in a recovery database into a connected primary or archive mailbox.
Please make sure to confirm and double check the source and destination mailbox before proceeding.
If there is a previous archive mailbox to restore, make sure it is enabled on the destination mailbox prior to running the restore request for the archive.
.LINK
https://docs.microsoft.com/en-us/powershell/module/exchange/mailboxes/New-MailboxRestoreRequest
#>

<# Connect to EXO v2. #>
#Set-ExecutionPolicy RemoteSigned -Force -Confirm:$false;
#Install-Module ExchangeOnlineManagement -AllowClobber -Force -Confirm:$false;
$AdminUpn = "";
Connect-ExchangeOnline -UserPrincipalName $AdminUpn;

<# Which mailbox do you want restore FROM? #>
$SourceMailbox = Get-Mailbox -SoftDeletedMailbox | Select Name,PrimarySmtpAddress,ArchiveStatus,WhenCreated,ExchangeGuid,Guid,WindowsLiveId,DistinguishedName | Out-GridView -Title "Which soft-deleted mailbox do you want restore from?" -PassThru;
#$SourceMailbox = Get-Mailbox -InactiveMailboxOnly | Select Name,PrimarySmtpAddress,ArchiveStatus,WhenCreated,ExchangeGuid,Guid,DistinguishedName | Out-GridView -Title "Which deleted mailbox do you want restore from?" -PassThru;

<# Which mailbox do you want restore TO? #>
$DestMailbox = Get-Mailbox | Select Name,ExchangeGuid,PrimarySmtpAddress,WhenCreated,DistinguishedName | Out-GridView -Title "Which active mailbox do you want restore to?" -PassThru;

<# Confirm before running! #>
New-MailboxRestoreRequest -SourceMailbox $SourceMailbox.DistinguishedName -TargetMailbox $DestMailbox.DistinguishedName -AllowLegacyDNMismatch;

<# Archive mailbox enabled? #>
New-MailboxRestoreRequest -SourceMailbox $SourceMailbox.DistinguishedName -SourceIsArchive -TargetMailbox $DestMailbox.DistinguishedName -TargetIsArchive -AllowLegacyDNMismatch;

<# View current progress? #>
Get-MailboxRestoreRequest;
