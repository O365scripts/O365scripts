<#
.SYNOPSIS
Teams Resource Account Creation and Management
https://github.com/O365scripts/O365scripts/blob/master/Microsoft%20Teams/.ps1
.NOTES
	> When creating a new resource account (RA), make sure to leave it's user as disabled or it may stop working as expected.
	> If the RA needs to be assigned a number, you will need to give it a Virtual Phone System license.
	> After some minor propagation, you should be able to assign it a service telephone number.
	> Note that you don't directly associate a service number to a AA/CQ, instead the phone number is associated to a RA.
	> Make sure to unassign an RA's number prior deleting or the number may become stale and require help from support to fix it.
	> RAs can be assigned toll and toll-free service phone numbers acquired from the teams admin center or ported from another provider.
	> A positive Communications Credits balance is required for toll-free service numbers.
	> Expected ApplicationId values depending on resource account type (may not be correctly set in some cases):
		+ AA: ce933385-9390-45d1-9512-c8d228074e07
		+ CQ: 11cd3e2e-fccb-42ad-ad00-878b93575e07
.LINK
Reference:
https://docs.microsoft.com/en-us/microsoftteams/manage-resource-accounts
https://docs.microsoft.com/en-us/microsoftteams/create-a-phone-system-auto-attendant
https://docs.microsoft.com/en-us/microsoftteams/create-a-phone-system-call-queue
https://docs.microsoft.com/en-us/powershell/module/skype/new-csonlineapplicationinstance?view=skype-ps
https://docs.microsoft.com/en-us/powershell/module/skype/set-csonlineapplicationinstance?view=skype-ps
https://docs.microsoft.com/en-us/powershell/module/skype/set-csonlinevoiceapplicationinstance?view=skype-ps
#>

<# Connect to Teams. #>
#Set-ExecutionPolicy RemoteSigned -Force -Confirm:$false;
#Install-Module MicrosoftTeams -AllowClobber -Force -Confirm:$false;
Import-Module MicrosoftTeams;
Connect-MicrosoftTeams;

<# Create an auto-attendant resource account. #>
$User = "aa@domain.com";
$Display = "Auto Attendant Resource Account";
$IdAA = "ce933385-9390-45d1-9512-c8d228074e07";
New-CsOnlineApplicationInstance -Identity $User -ApplicationId $IdAA -DisplayName $Display;

<# Create a call queue resource account. #>
$User = "cq@domain.com";
$Display = "Call Queue Resource Account";
$IdCQ = "11cd3e2e-fccb-42ad-ad00-878b93575e07";
New-CsOnlineApplicationInstance -Identity $User -ApplicationId $IdCQ -DisplayName $Display;

<# Interactive: Select an unassigned service number to assign on a resource account. #>
$Number = (Get-CsOnlineTelephoneNumber -InventoryType Service -IsNotAssigned | Out-GridView -OutputMode Single).Id
$User = (Get-CsOnlineApplicationInstance | Out-GridView -OutputMode Single).UserPrincipalName;
Set-CsOnlineApplicationEndpoint -Uri "sip:$User" -PhoneNumber $Number;

<# Unassign a number from a resource account. #>
$User = "resource@domain.com";
Set-CsOnlineApplicationEndpoint -Identity "sip:$User" -PhoneNumber "";

<# Assign a toll number to a resource account. #>
$User = "resource@domain.com";
$Number = "+1234567890";
Set-CsOnlineApplicationEndpoint -Uri "sip:$User" -PhoneNumber $Number;

<# Assign a toll-free number to a resource account. (Make sure to have a positive communication credits balance) #>
$User = "resource@domain.com";
$Number = "+18001234567";
Set-CsOnlineApplicationEndpoint -Uri "sip:$User" -PhoneNumber $Number;

<# Assign an hybrid number to a resource account. #>
$User = "resource@domain.com";
$Number = "+11231231234";
Set-CsOnlineApplicationInstance -Identity $User -OnpremPhoneNumber $Number;