<#
.LINK
https://docs.microsoft.com/en-us/powershell/module/exchange/get-mailboxjunkemailconfiguration?view=exchange-ps
https://docs.microsoft.com/en-us/powershell/module/exchange/set-mailboxjunkemailconfiguration?view=exchange-ps
#>

<# Add/remove a trusted sender on all mailboxes that do not already contain it. #>
$TrustedSender = "user@domain.com"
$ListMailbox = Get-Mailbox -ResultSize Unlimited | Select DisplayName,PrimarySmtpAddress,RecipientTypeDetails,DistinguishedName,@{Name="TrustedSendersAndDomains";Expression={(Get-MailboxJunkEmailConfiguration -Identity $_.DistinguishedName -ErrorAction SilentlyContinue).TrustedSendersAndDomains}};
$ListMailbox | Where {$_.TrustedSendersAndDomains -notcontains $TrustedSender} | % {Set-MailboxJunkEmailConfiguration -Identity $_.DistinguishedName -TrustedSendersAndDomains @{add=$TrustedSender}};
#$ListMailbox | Where {$_.TrustedSendersAndDomains -contains $TrustedSender} | % {Set-MailboxJunkEmailConfiguration -Identity $_.DistinguishedName -TrustedSendersAndDomains @{remove=$TrustedSender}};
