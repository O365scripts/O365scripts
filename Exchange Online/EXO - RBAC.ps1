<#
.SYNOPSIS
.NOTES
.LINK
#>

<# Connect to EXO v2. #>
#Set-ExecutionPolicy RemoteSigned -Force -Confirm:$false;
#Install-Module ExchangeOnlineManagement -AllowClobber -Force -Confirm:$false;
$AdminUpn = "";
Connect-ExchangeOnline -UserPrincipalName $AdminUpn;

<# #>
$role = "CustomMyBaseOptions";
New-ManagementRole -Name $role -Parent MyBaseOptions

Set-ManagementRoleEntry $role\New-InboxRule -RemoveParameter -Parameters ForwardTo, RedirectTo, ForwardAsAttachmentTo
Set-ManagementRoleEntry $role\Set-Mailbox -RemoveParameter -Parameters DeliverToMailboxAndForward,ForwardingAddress,ForwardingSmtpAddress

$policy = "CustomMyBaseOptionsPolicy";
New-RoleAssignmentPolicy -Name $policy -Roles $role,MyContactInformation,MyRetentionPolicies,MyMailSubscriptions,MyTextMessaging,MyVoiceMail,MyDistributionGroupMembership,MyDistributionGroups,MyProfileInformation
Set-Mailbox -Identity "user@domain.com" -RoleAssignmentPolicy $policy
