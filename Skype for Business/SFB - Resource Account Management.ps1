<#
.SYNOPSIS
Resource Account Creation and Management

.NOTES
You can only assign Cloud call queues toll and toll-free service phone numbers that you got in the Microsoft Teams admin center or transferred from another service provider.
Communications Credits are required for toll-free service numbers.
A call queue can be dialed directly or accessed by a selection on an auto attendant.
A call queue is required to have an associated resource account.
You don't directly associate a phone number to a call queue, instead the phone number is associated to a resource account.
When you assign a phone number to a resource account, you can now use the cost-free Phone System Virtual User license.
Phone System allows phone numbers at the organizational level for use with low-cost auto attendant and call queue services.

Auto Attendant: ce933385-9390-45d1-9512-c8d228074e07
Call Queue: 11cd3e2e-fccb-42ad-ad00-878b93575e07

.LINK
https://docs.microsoft.com/en-us/microsoftteams/manage-resource-accounts
https://docs.microsoft.com/en-us/microsoftteams/create-a-phone-system-call-queue
https://docs.microsoft.com/en-us/microsoftteams/create-a-phone-system-auto-attendant
https://docs.microsoft.com/en-us/powershell/module/skype/new-csonlineapplicationinstance?view=skype-ps
https://docs.microsoft.com/en-us/powershell/module/skype/set-csonlineapplicationinstance?view=skype-ps
#>

<# QUICKRUN: Install the Teams module and connect to SFBO. #>
$Tenant = "mytenant";
#Set-ExecutionPolicy RemoteSigned;
#Install-Module MicrosoftTeams -Force -Confirm:$false;
Import-Module MicrosoftTeams;
$Session_Sfb = New-CsOnlineSession -OverrideAdminDomain "$Tenant.onmicrosoft.com";
Import-PSSession $Session_Sfb;


<# Create an auto-attendant resource account. #>
$upn = "aa@domain.com";
$display = "Auto Attendant Resource Account";
$id_aa = "ce933385-9390-45d1-9512-c8d228074e07";
New-CsOnlineApplicationInstance -Identity $upn -ApplicationId $id_aa -DisplayName $display;


<# Create a call queue resource account. #>
$upn = "cq@domain.com";
$display = "Call Queue Resource Account";
$id_cq = "11cd3e2e-fccb-42ad-ad00-878b93575e07";
New-CsOnlineApplicationInstance -Identity $upn -ApplicationId $id_cq -DisplayName $display;


<# Select an unassigned service number and assign it to the selected resource account. #>
$number = (Get-CsOnlineTelephoneNumber -InventoryType Service -IsNotAssigned | Out-GridView -OutputMode Single).Id
$user = (Get-CsOnlineApplicationInstance | Out-GridView -OutputMode Single).UserPrincipalName;
Set-CsOnlineApplicationEndpoint -Uri "sip:$user" -PhoneNumber $number;

<# Unassign a number from a resource account. #>
$User = "resource@domain.com";
Set-CsOnlineApplicationEndpoint -Identity "sip:$User" -PhoneNumber "";

<# Assign a toll number to a resource account. #>
$User = "resource@domain.com";
$Number = "+1234567890";
Set-CsOnlineApplicationEndpoint -Uri "sip:$User" -PhoneNumber $Number;

<# Assign a toll-free number to a resource account. Make sure to have communication credits for it. #>
$User = "resource@domain.com";
$Number = "+18001234567";
Set-CsOnlineApplicationEndpoint -Uri "sip:$User" -PhoneNumber $Number;

<# Assign an hybrid number to a resource account. #>
$User = "resource@domain.com";
$Number = "+11231231234";
Set-CsOnlineApplicationInstance -Identity $User -OnpremPhoneNumber $Number;


<# Select a resource account to be associated with a selected attendant. #>
$Resource = (Get-CsOnlineApplicationInstance | Where {$_.ApplicationId -eq "ce933385-9390-45d1-9512-c8d228074e07"} | Out-GridView -OutputMode Single).ObjectId;
$Attendant = (Get-CsAutoAttendant | Out-GridView -OutputMode Single).Id;
New-CsOnlineApplicationInstanceAssociation -Identities @($Resource) -ConfigurationId $Attendant -ConfigurationType "AutoAttendant";

<# Select a resource account to be associated with a selected call queue. #>
$Resource = (Get-CsOnlineApplicationInstance | Where {$_.ApplicationId -eq "11cd3e2e-fccb-42ad-ad00-878b93575e07"} | Out-GridView -OutputMode Single).ObjectId;
$CallQueue = (Get-CsCallQueue | Out-GridView -OutputMode Single).Identity;
New-CsOnlineApplicationInstanceAssociation -Identities @($Resource) -ConfigurationId $CallQueue -ConfigurationType "CallQueue";
