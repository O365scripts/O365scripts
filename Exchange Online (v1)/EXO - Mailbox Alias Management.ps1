<#
.SYNOPSIS
	Mailbox Alias Management
.NOTES
.LINK
https://docs.microsoft.com/en-us/exchange/recipients/user-mailboxes/email-addresses?view=exchserver-2019
#>

<# Add or remove an alias to a specific mailbox.#>
$mbox = "user@domain.com";
$alias = "user2@domain.com";
Set-Mailbox $mbox -EmailAddresses @{add=$alias};
Set-Mailbox $mbox -EmailAddresses @{remove=$alias};
