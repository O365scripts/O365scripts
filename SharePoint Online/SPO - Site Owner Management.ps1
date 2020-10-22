<#
.SYNOPSIS
.NOTES
.LINK
#>

<# Select one or multiple security group and add each of it's members as site owners to one or multiple SPO sites. #>
$ListMembers = Get-DistributionGroup -RecipientTypeDetails MailUniversalSecurityGroup | Out-GridView -PassThru | % {Get-DistributionGroupMember -Identity $_.DistinguishedName};
$ListSites = Get-SPOSite | Out-GridView -PassThru;
ForEach ($s in $ListSites) {$ListMembers | % {Set-SPOUser -Site $s.Url -LoginName $_.PrimarySmtpAddress -IsSiteCollectionAdmin $true}}
