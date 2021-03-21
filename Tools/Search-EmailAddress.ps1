<#
.SYNOPSIS
.NOTES
Confirm which email address to look for duplicates.

Get-MsolUser
Get-AzureADUser
Get-DistributionGroup
Get-UnifiedGroup
Get-Mailbox
Get-Recipient

Members, Guests
Mailboxes:
	UserMailbox
	SharedMailbox
	ResourceMailbox
	RoomMailbox
Groups:
	Mail-Enabled Security Group
	Distribution Group
	Dynamic Distribution Group
	Room List Distribution Group
	Unified Group (365)
.LINK
#>

#################################

$EmailAddress = "name@domain.com";

$ReportEmailAddress = "";

<# Recipients #>
$ListRecipients = Get-Recipient -ResultSize Unlimited -Filter ("EmailAddresses -like '$EmailAddress' -or PrimarySmtpAddress -eq '$EmailAddress'");
if (($ListRecipients | Measure-Object).Count -gt 1) {
	Write-Host -Fore Yellow "Found multiple possible recipients with the same email address."
	$ListRecipients | fl DisplayName,UserPrincipalName,RecipientTypeDetails,EmailAddresses,ExternalDirectoryObjectId,DistinguishedName,WhenCreated;
}

<# Groups #>
$ListGroups = Get-DistributionGroup -Filter ("EmailAddresses -like '$EmailAddress' -or PrimarySmtpAddress -eq '$EmailAddress'")
if (($ListGroups | Measure-Object).Count -gt 1) {
	Write-Host -Fore Yellow "Found multiple possible groups with the same email address."
	$ListGroups | fl DisplayName,UserPrincipalName,RecipientTypeDetails,EmailAddresses,ExternalDirectoryObjectId,DistinguishedName,WhenCreated;
}

<# Contacts #>
$ListContacts = Get-MailContact -Filter ("EmailAddresses -like '$EmailAddress' -or ExternalEmailAddress -eq '$EmailAddress'")
if (($ListContacts | Measure-Object).Count -gt 1) {
	Write-Host -Fore Yellow "Found multiple possible contacts with the same email address."
	$ListContacts | fl DisplayName,UserPrincipalName,RecipientTypeDetails,EmailAddresses,ExternalDirectoryObjectId,DistinguishedName,WhenCreated;
}

<# Users #>
$ListMsolUsers = Get-MsolUser -All -SearchString "$EmailAddress";
if (($ListMsolUsers | Measure-Object).Count -gt 1) {
	Write-Host -Fore Yellow "Found multiple possible MSOL users with the same email address."
	$ListMsolUsers | fl DisplayName,UserPrincipalName,ProxyAddresses,AlternateEmailAddresses,ObjectId,DistinguishedName,WhenCreated;
}

<# Deleted Users? #>
$ListMsolDeletedUsers = Get-MsolUser -ReturnDeletedUsers | Where {$_.UserPrincipalName -eq $EmailAddress -or $_.ProxyAddresses -like $EmailAddress};
if (($ListMsolDeletedUsers | Measure-Object).Count -gt 1) {
	Write-Host -Fore Yellow "Found MSOL deleted users with the specified email address."
	$ListMsolDeletedUsers | fl DisplayName,UserPrincipalName,ProxyAddresses,AlternateEmailAddresses,ObjectId,DistinguishedName,WhenCreated,SoftDeletionTimestamp;
}
Get-MsolUser -ReturnDeletedUsers | Where {($_.ProxyAddresses -like "$EmailAddress") -or ($_.UserPrincipalName -eq '$EmailAddress')};
