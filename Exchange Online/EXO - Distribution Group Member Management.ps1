<#
.SYNOPSIS

.NOTES

.LINK
https://docs.microsoft.com/en-us/powershell/module/exchange/add-distributiongroupmember
https://support.microsoft.com/en-us/office/distribution-groups-e8ba58a8-fab2-4aaf-8aa1-2a304052d2de
#>

<# Connect to EXO v2. #>
$Me = "";
Connect-ExchangeOnline -UserPrincipalName $Me;

<# Interactive selection of one or multiple users to be added to one or multiple distribution groups. #>
$ListDG = Get-DistributionGroup -RecipientTypeDetails "MailUniversalDistributionGroup" -ResultSize Unlimited | Out-GridView -PassThru;
$ListUsers = Get-ExoMailbox -RecipientTypeDetails "UserMailbox" | Out-GridView -PassThru;
ForEach ($dg in $ListDG) {$ListUsers | % {Add-DistributionGroupMember -Identity $dg.DistinguishedName -Member $_.DistinguishedName -ErrorAction SilentlyContinue;}}
