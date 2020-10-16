<#
#>

<# Interactive selection of one or multiple users to be added to one or multiple distribution groups. #>
$ListDG = Get-DistributionGroup -RecipientTypeDetails "MailUniversalDistributionGroup" -ResultSize Unlimited | Out-GridView -PassThru;
$ListUsers = Get-ExoMailbox -RecipientTypeDetails "UserMailbox" | Out-GridView -PassThru;
ForEach ($dg in $ListDG) {$ListUsers | % {Add-DistributionGroupMember -Identity $dg.DistinguishedName -Member $_.DistinguishedName -ErrorAction SilentlyContinue;}}
