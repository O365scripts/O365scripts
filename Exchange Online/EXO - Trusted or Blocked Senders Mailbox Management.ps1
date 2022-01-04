<#
.SYNOPSIS
Trusted/Blocked Sender Mailbox Junk Email Configuration Management
.NOTES
.LINK
https://docs.microsoft.com/en-us/powershell/module/exchange/get-mailboxjunkemailconfiguration?view=exchange-ps
https://docs.microsoft.com/en-us/powershell/module/exchange/set-mailboxjunkemailconfiguration?view=exchange-ps
#>

<# Connect to EXO v2. #>
#Set-ExecutionPolicy RemoteSigned -Force -Confirm:$false;
#Install-Module ExchangeOnlineManagement -AllowClobber -Force -Confirm:$false;
$AdminUpn = "";
Connect-ExchangeOnline -UserPrincipalName $AdminUpn;

<# Add/remove a trusted sender on all mailboxes that do not already contain it. #>
$TrustedSender = "user@domain.com"
$ListMailbox = Get-Mailbox -ResultSize Unlimited | Select DisplayName,PrimarySmtpAddress,RecipientTypeDetails,DistinguishedName,@{Name="TrustedSendersAndDomains";Expression={(Get-MailboxJunkEmailConfiguration -Identity $_.DistinguishedName -ErrorAction SilentlyContinue).TrustedSendersAndDomains}};
$ListMailbox | Where {$_.TrustedSendersAndDomains -notcontains $TrustedSender} | % {Set-MailboxJunkEmailConfiguration -Identity $_.DistinguishedName -TrustedSendersAndDomains @{add=$TrustedSender}};
#$ListMailbox | Where {$_.TrustedSendersAndDomains -contains $TrustedSender} | % {Set-MailboxJunkEmailConfiguration -Identity $_.DistinguishedName -TrustedSendersAndDomains @{remove=$TrustedSender}};

<# Add/remove a blocked sender on all mailboxes that do not already contain it. #>
$BlockedSender = "user@domain.com"
$ListMailbox = Get-Mailbox -ResultSize Unlimited | Select DisplayName,PrimarySmtpAddress,RecipientTypeDetails,DistinguishedName,@{Name="BlockedSendersAndDomains";Expression={(Get-MailboxJunkEmailConfiguration -Identity $_.DistinguishedName -ErrorAction SilentlyContinue).BlockedSendersAndDomains}};
$ListMailbox | Where {$_.BlockedSendersAndDomains -notcontains $BlockedSender} | % {Set-MailboxJunkEmailConfiguration -Identity $_.DistinguishedName -BlockedSendersAndDomains @{add=$BlockedSender}};
#$ListMailbox | Where {$_.BlockedSendersAndDomains -contains $BlockedSender} | % {Set-MailboxJunkEmailConfiguration -Identity $_.DistinguishedName -BlockedSendersAndDomains @{remove=$BlockedSender}};
