<#
.SYNOPSIS
Exchange Mailbox Conversion Management
https://github.com/O365scripts/O365scripts/blob/master/ExchangeOnline/ExchangeOnlineMailboxConversion.ps1

.NOTES
Available types for conversion:
+ Regular (User)
+ Room
+ Equipment
+ Shared
Other types cannot be converted.

Important considerations:
> Shared mailboxes can have up to 50GB of data without a license assigned to them.
To hold more data than that, you need a license assigned to it.

.LINK
https://learn.microsoft.com/microsoft-365/admin/email/convert-user-mailbox-to-shared-mailbox
https://learn.microsoft.com/powershell/module/exchange/set-mailbox
https://learn.microsoft.com/exchange/troubleshoot/user-and-shared-mailboxes/shared-mailboxes-unexpectedly-converted-to-user-mailboxes
#>

# Connect to EXO.
#Set-ExecutionPolicy RemoteSigned -Force -Confirm:$false
#Install-Module ExchangeOnlineManagement -Force -Confirm:$false
#Update-Module ExchangeOnlineManagement -Force -Confirm:$false
$AdminUpn = ""
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -UserPrincipalName $AdminUpn

# Interactive mailbox type conversion selection.
$TypeSource = "Regular", "Room", "Equipment", "Shared" | Out-GridView -OutputMode Single
$TypeDest = "Regular", "Room", "Equipment", "Shared" | Out-GridView -OutputMode Single
$ListMbox = Get-Mailbox $_.DistinguishedName | Select Identity,PrimarySmtpAddress,RecipientTypeDetails | Out-Gridview
$ListMbox | % {Set-Mailbox -Identity $_.DistinguishedName -Type $TypeDest}

<# Convert a single mailbox into a different type? #>
$User = ""
Set-Mailbox -Identity $User -Type Shared
Set-Mailbox -Identity $User -Type User

<# Get the list of user mailboxes and convert the selected ones into shared mailboxes. #>
$TypeSource = "UserMailbox"
$TypeDest = "SharedMailbox"
$ListMailbox = Get-Mailbox -ResultSize Unlimited -Filter ("RecipientTypeDetails -eq '$TypeSource'")
$ListMailbox | Out-Gridview -PassThru | % {Set-Mailbox -Identity $_.DistinguishedName -Type $TypeDest}

<# WIP #>
#$ListMailbox | Get-Mailbox $_.DistinguishedName | Select Identity,PrimarySmtpAddress,RecipientTypeDetails | Out-Gridview
#$ListMailbox | % {Set-Mailbox -Identity $_.DistinguishedName -Type Shared}

<# Build report of mailbox details after conversion to confirm results? #>
<# ... #>
