<#
.SYNOPSIS
Mailbox Permission Management
.NOTES

.LINK
https://docs.microsoft.com/en-us/powershell/module/exchange/mailboxes/add-mailboxpermission?view=exchange-ps
https://docs.microsoft.com/en-us/powershell/module/exchange/mailboxes/remove-mailboxpermission?view=exchange-ps
https://docs.microsoft.com/en-us/outlook/troubleshoot/domain-management/remove-automapping-for-shared-mailbox
#>

<# Get list of mailboxes and assign full access permissions to an account or a group. #>
$grant_to = "admins@domain.com";

$mbox = Get-Mailbox -ResultSize Unlimited;
#$mbox = Get-Mailbox -ResultSize Unlimited | Where {$_.RecipientTypeDetails -eq "UserMailbox"};
#$mbox = Get-Mailbox -ResultSize Unlimited | Where {$_.RecipientTypeDetails -eq "SharedMailbox"};
#$mbox = Get-Mailbox -ResultSize Unlimited | Where {$_.RecipientTypeDetails -eq "EquipmentMailbox"};
#$mbox = Get-Mailbox -ResultSize Unlimited | Where {$_.RecipientTypeDetails -eq "RoomMailbox"};

Foreach ($m in $mbox) {
	Write-Host -NoNewline "Trying to grant Full Access permissions on ";
		Write-Host -NoNewline -Fore Yellow $m.PrimarySmtpAddress;
		Write-Host -NoNewline " to ";
		Write-Host -NoNewline -Fore Yellow $grant_to;
		Write-Host -NoNewline ".";
	#Remove-MailboxPermission -Identity $m.PrimarySmtpAddress -User $grant_to -AccessRights FullAccess -InheritanceType All -Confirm:$false -ErrorAction Continue;
	Add-MailboxPermission -Identity $m.PrimarySmtpAddress -User $grant_to -AccessRights FullAccess -AutoMapping:$false -ErrorAction Continue;
	}
