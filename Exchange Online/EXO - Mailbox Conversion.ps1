<#
.SYNOPSIS
Exchange Mailbox Conversion Management
https://github.com/O365scripts/O365scripts/blob/master/Exchange%20Online/EXO%20-%20Mailbox%20Conversion.ps1
.NOTES
    > Important considerations:
    > Shared mailboxes can have up to 50GB of data without a license assigned to them. To hold more data than that, you need a license assigned to it.
.LINK
https://docs.microsoft.com/en-us/microsoft-365/admin/email/convert-user-mailbox-to-shared-mailbox?view=o365-worldwide
https://docs.microsoft.com/en-us/powershell/module/exchange/set-mailbox?view=exchange-ps
https://support.microsoft.com/en-us/help/2710029/shared-mailboxes-are-unexpectedly-converted-to-user-mailboxes-after-di
#>

<# Connect to EXO v2. #>
#Set-ExecutionPolicy RemoteSigned -Force -Confirm:$false;
#Install-Module ExchangeOnlineManagement -AllowClobber -Force -Confirm:$false;
$AdminUpn = "";
Connect-ExchangeOnline -UserPrincipalName $AdminUpn;

<# Interactive mailbox type conversion selection. #>
$TypeSource = "Regular", "Room", "Equipment", "Shared" | Out-GridView -OutputMode Single;
$TypeDest = "Regular", "Room", "Equipment", "Shared" | Out-GridView -OutputMode Single;
$ListMbox = Get-Mailbox $_.DistinguishedName | Select Identity,PrimarySmtpAddress,RecipientTypeDetails | Out-Gridview;
$ListMbox | % {Set-Mailbox -Identity $_.DistinguishedName -Type $TypeDest;}

<# Convert a single mailbox into a different type? #>
$User = "";
Set-Mailbox -Identity $User -Type Shared;
Set-Mailbox -Identity $User -Type User;

<# Get the list of user mailboxes and convert the selected ones into shared mailboxes. #>
$TypeSource = "UserMailbox";
$TypeDest = "SharedMailbox";
$list_mbox = Get-Mailbox -ResultSize Unlimited -Filter ("RecipientTypeDetails -eq '$TypeSource'");
$list_mbox | Out-Gridview -PassThru | % {Set-Mailbox -Identity $_.DistinguishedName -Type $TypeDest;}

<# WIP #>
#$list_mbox | Get-Mailbox $_.DistinguishedName | Select Identity,PrimarySmtpAddress,RecipientTypeDetails | Out-Gridview
#$list_mbox | % {Set-Mailbox -Identity $_.DistinguishedName -Type Shared;}

<# Build report of mailbox details after conversion to confirm results? #>
<# ... #>