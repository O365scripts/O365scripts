<#
.SYNOPSIS
.NOTES
	> E5 or Compliance add-on needed for advanced audit events such as MailItemsAccessed.
	> Search-UnifiedAuditLog vs Search-MailboxAuditLog.
	> Owner: The possible enumeration values are 'None, Update, Copy, Move, MoveToDeletedItems, SoftDelete, HardDelete,    
FolderBind, SendAs, SendOnBehalf, MessageBind, Create, MailboxLogin, UpdateFolderPermissions, AddFolderPermissions, ModifyFolderPermissions, RemoveFolderPermissions, UpdateInboxRules, UpdateCalendarDelegation,
RecordDelete, ApplyRecord, MailItemsAccessed, Default, UpdateComplianceTag, Send, SearchQueryInitiated'.
	> Admin: Supported audit operations for Admin are None, Create, FolderBind, MessageBind, SendAs, SendOnBehalf, SoftDelete, HardDelete, Update, Move, Copy, MoveToDeletedItems and 
UpdateFolderPermissions.
	> Delegate: Supported audit operations for Delegate are None, Create, FolderBind, SendAs, SendOnBehalf, SoftDelete, HardDelete, Update, Move, MoveToDeletedItems and UpdateFolderPermissions.
.LINK
https://docs.microsoft.com/en-us/microsoft-365/compliance/enable-mailbox-auditing?view=o365-worldwide
https://docs.microsoft.com/en-us/microsoft-365/compliance/search-the-audit-log-in-security-and-compliance?view=o365-worldwide
https://docs.microsoft.com/en-us/microsoft-365/compliance/advanced-audit?view=o365-worldwide
https://docs.microsoft.com/en-us/microsoft-365/compliance/set-up-advanced-audit?view=o365-worldwide
https://docs.microsoft.com/en-us/microsoft-365/compliance/mailitemsaccessed-forensics-investigations?view=o365-worldwide
https://docs.microsoft.com/en-us/powershell/module/exchange/set-mailbox?view=exchange-ps
#>

<# Connect to EXO v2. #>
#Set-ExecutionPolicy RemoteSigned -Force -Confirm:$false;
#Install-Module ExchangeOnlineManagement -AllowClobber -Force -Confirm:$false;
$AdminUpn = "";
Connect-ExchangeOnline -UserPrincipalName $AdminUpn;


<# Enable all regular audit flags on a specific mailbox. #>
$User = "user@domain.com";
$AuditOwnerFlags = @{Add="AddFolderPermissions", "ApplyRecord", "Create", "HardDelete", "MailboxLogin", "ModifyFolderPermissions", "Move", "MoveToDeletedItems", "RecordDelete", "RemoveFolderPermissions", "SoftDelete", "Update", "UpdateFolderPermissions", "UpdateCalendarDelegation", "UpdateInboxRules"}
$AuditAdminFlags = @{Add="AddFolderPermissions", "ApplyRecord", "Copy", "Create", "HardDelete", "ModifyFolderPermissions", "Move", "MoveToDeletedItems", "RecordDelete", "RemoveFolderPermissions", "SendAs", "SendOnBehalf", "SoftDelete", "Update", "UpdateFolderPermissions", "UpdateCalendarDelegation", "UpdateInboxRules"}
$AuditDelegateFlags = @{Add="AddFolderPermissions", "ApplyRecord", "Create", "HardDelete", "ModifyFolderPermissions", "Move", "MoveToDeletedItems", "RecordDelete", "RemoveFolderPermissions", "SendAs", "SendOnBehalf", "SoftDelete", "Update", "UpdateFolderPermissions", "UpdateInboxRules"}
Set-Mailbox -Identity $User -AuditEnabled $true -AuditAdmin $AuditAdminFlags -AuditDelegate $AuditDelegateFlags -AuditOwner $AuditOwnerFlags;

<# Enable all regular audit flags on all user mailboxes. #>
$ListMailbox = Get-Mailbox -RecipientTypeDetails UserMailbox -ResultSize Unlimited;
$ListMailbox | % {
	Write-Host -NoNewline "Enabling all audit flags on "; Write-Host -Fore Yellow $_.PrimarySmtpAddress;
	Set-Mailbox -Identity $_.DistinguishedName `
	-AuditOwner @{Add="AddFolderPermissions", "ApplyRecord", "Create", "HardDelete", "MailboxLogin", "ModifyFolderPermissions", "Move", "MoveToDeletedItems", "RecordDelete", "RemoveFolderPermissions", "SoftDelete", "Update", "UpdateFolderPermissions", "UpdateCalendarDelegation", "UpdateInboxRules"} `
	-AuditAdmin @{Add="AddFolderPermissions", "ApplyRecord", "Copy", "Create", "HardDelete", "ModifyFolderPermissions", "Move", "MoveToDeletedItems", "RecordDelete", "RemoveFolderPermissions", "SendAs", "SendOnBehalf", "SoftDelete", "Update", "UpdateFolderPermissions", "UpdateCalendarDelegation", "UpdateInboxRules"} `
	-AuditDelegate @{Add="AddFolderPermissions", "ApplyRecord", "Create", "HardDelete", "ModifyFolderPermissions", "Move", "MoveToDeletedItems", "RecordDelete", "RemoveFolderPermissions", "SendAs", "SendOnBehalf", "SoftDelete", "Update", "UpdateFolderPermissions", "UpdateInboxRules"} `
	-AuditEnabled $true};

<# Enable advanced audit flags. #>
Set-Mailbox -Identity $User -AuditOwner @{Add="MailItemsAccessed", "Send", "SearchQueryInitiated"};