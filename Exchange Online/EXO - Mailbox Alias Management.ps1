<#
.SYNOPSIS
Mailbox Alias Management
.NOTES
.LINK
https://docs.microsoft.com/en-us/exchange/recipients/user-mailboxes/email-addresses?view=exchserver-2019
https://docs.microsoft.com/en-us/powershell/module/exchange/set-mailbox?view=exchange-ps
https://docs.microsoft.com/en-us/powershell/module/exchange/get-mailbox?view=exchange-ps
#>

<# Add or remove an alias on a specific mailbox.#>
$mbox = "user@domain.com";
$alias = "user2@domain.com";
Set-Mailbox $mbox -EmailAddresses @{add=$alias};
Set-Mailbox $mbox -EmailAddresses @{remove=$alias};

<#####################>

<# Add multiple aliases from a CSV into a specified mailbox. #>
$User = "user@domain.com";$PathCsv = "$env:USERPROFILE\Desktop\BulkAddAliasesToMailbox.csv";
Import-Csv $PathCsv | % {Set-Mailbox $User -EmailAddresses @{add=$_.SmtpAddress}};

<# Verify aliases. #>
(Get-Mailbox $User).EmailAddresses
