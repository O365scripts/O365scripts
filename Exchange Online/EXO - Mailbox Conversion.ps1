<#
.SYNOPSIS
Exchange Mailbox Conversion Management

.NOTES
Important considerations
Shared mailboxes can have up to 50GB of data without a license assigned to them. To hold more data than that, you need a license assigned to it

.LINK
https://docs.microsoft.com/en-us/microsoft-365/admin/email/convert-user-mailbox-to-shared-mailbox?view=o365-worldwide
https://docs.microsoft.com/en-us/powershell/module/exchange/set-mailbox?view=exchange-ps
https://support.microsoft.com/en-us/help/2710029/shared-mailboxes-are-unexpectedly-converted-to-user-mailboxes-after-di
#>


<# Interactive mailbox type conversion selection. #>
$type_from = "Regular", "Room", "Equipment", "Shared" | Out-GridView -OutputMode Single;
$type_to = "Regular", "Room", "Equipment", "Shared" | Out-GridView -OutputMode Single;
$list_mbox = Get-Mailbox $_.DistinguishedName | Select Identity,PrimarySmtpAddress,RecipientTypeDetails | Out-Gridview;
$list_mbox | % {Set-Mailbox -Identity $_.DistinguishedName -Type $type_to;}


<# Convert a single mailbox into a different type? #>
$mbox = "";
Set-Mailbox -Identity $mbox -Type Shared;
Set-Mailbox -Identity $mbox -Type User;

<# Get the list of user mailboxes and convert the selected ones into shared mailboxes. #>
$type_from = "UserMailbox";
$type_to = "SharedMailbox";
$list_mbox = Get-Mailbox -ResultSize Unlimited -Filter ("RecipientTypeDetails -eq '$type_from'");
$list_mbox | Out-Gridview -PassThru | % {Set-Mailbox -Identity $_.DistinguishedName -Type $type_to;}


<# WIP #>
#$list_mbox | Get-Mailbox $_.DistinguishedName | Select Identity,PrimarySmtpAddress,RecipientTypeDetails | Out-Gridview
#$list_mbox | % {Set-Mailbox -Identity $_.DistinguishedName -Type Shared;}

<# Build report of mailbox details after conversion to confirm results? #>
<# ... #>
