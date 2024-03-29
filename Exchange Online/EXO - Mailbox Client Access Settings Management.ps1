<#
.SYNOPSIS
.NOTES
.LINK
https://docs.microsoft.com/en-us/powershell/module/exchange/client-access/set-casmailbox?view=exchange-ps
https://docs.microsoft.com/en-us/powershell/module/exchange/get-distributiongroupmember?view=exchange-ps
https://docs.microsoft.com/en-us/powershell/module/exchange/get-distributiongroup?view=exchange-ps
#>

<# Connect to EXO v2. #>
#Set-ExecutionPolicy RemoteSigned -Force -Confirm:$false;
#Install-Module ExchangeOnlineManagement -AllowClobber -Force -Confirm:$false;
$AdminUpn = "";
Connect-ExchangeOnline -UserPrincipalName $AdminUpn;

<# Interactive selection of one or multiple security groups and pass through each of their members to bulk adjust EAS, POP and IMAP mail protocols. #>
$eas = $false; $imap = $false; $pop = $false;
Get-DistributionGroup -RecipientTypeDetails MailUniversalSecurityGroup | Out-GridView -PassThru | % {Get-DistributionGroupMember -Identity $_.DistinguishedName | % {Set-CasMailbox -Identity $_.DistinguishedName -ActiveSyncEnabled:$eas -ImapEnabled:$imap -PopEnabled:$pop}};

<# Toggle EAS, IMAP and POP on all mailboxes. #>
$eas = $false; $imap = $false; $pop = $false;
Get-Mailbox -ResultSize Unlimited | % {Set-CasMailbox -Identity $_.DistinguishedName -ActiveSyncEnabled:$eas -ImapEnabled:$imap -PopEnabled:$pop};
