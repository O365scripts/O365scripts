<#
.SYNOPSIS
.NOTES
	> The RetainDeletedItemsFor parameter specifies the length of time to keep soft-deleted items for the mailbox.
	> Soft-deleted items are items that have been deleted by using any of these methods:
		+ Deleting items from the Deleted Items folder.
		+ Selecting the Empty Deleted Items Folder action.
		+ Deleting items using Shift + Delete.
	> These actions move the items to the Recoverable Items folder, into a subfolder named Deletions.
	> Before the deleted item retention period expires, users can recover soft-deleted items in Outlook and Outlook on the web by using the Recover Deleted Items feature.
	> For more information, see Recoverable Items folder in Exchange Server.
	> To specify a value, enter it as a time span: dd.hh:mm:ss where dd = days, hh = hours, mm = minutes, and ss = seconds.
	> The default value is 14 days (14.00:00:00). In Exchange Online, you can increase the value to a maximum of 30 days.
	> In Exchange Online, you use this parameter to configure the RetainDeletedItemsFor value on existing mailboxes.
	> Use the Set-MailboxPlan cmdlet to change the RetainDeletedItemsFor value for all new mailboxes that you create in the future.
	> In on-premises Exchange, the default value is configured by the value of the DeletedItemRetention parameter on mailbox database. To override the default value, enter a value for the RetainDeletedItemsFor parameter on the mailbox.
.LINK
Reference:
https://docs.microsoft.com/en-us/powershell/module/exchange/set-mailbox?view=exchange-ps
#>

<# Connect to EXO v2. #>
#Set-ExecutionPolicy RemoteSigned -Force -Confirm:$false;
#Install-Module ExchangeOnlineManagement -AllowClobber -Force -Confirm:$false;
$AdminUpn = "";
Connect-ExchangeOnline -UserPrincipalName $AdminUpn;

<# Set deleted item retention to maxmimum value on all mailboxes. #>
Get-Mailbox -ResultSize Unlimited | % {Set-Mailbox -Identity $_.DistinguishedName -RetainDeletedItemsFor 30};

<# Set deleted item retention to a specific duration on a single mailbox. #>
$User = "user@domain.com";
$Retain = "d.hh:mm:ss";
Set-Mailbox -Identity $User -RetainDeletedItemsFor $Retain;
