<#
.SYNOPSIS
Skype/Teams Voice User Number Management

.NOTES
The emergency location that is assigned to the user must match the area code of the user number that will be assigned.
The Telephone Number assignment failed. The country of the user’s Usage Location XX and the country of the Telephone Number XX do not match.

.LINK
https://docs.microsoft.com/en-us/powershell/module/skype/get-csonlinelislocation?view=skype-ps
https://docs.microsoft.com/en-us/powershell/module/skype/new-csonlinelislocation?view=skype-ps
#>

<# QUICKRUN: Install the Teams module and connect to SFBO. #>
$Tenant = "mytenant";
Install-Module MicrosoftTeams -Force -Confirm:$false;
Import-Module MicrosoftTeams;
$Session_Sfb = New-CsOnlineSession -OverrideAdminDomain "$Tenant.onmicrosoft.com";
Import-PSSession $Session_Sfb;

<# Specify manually which number to assign to a specific user. #>
$user = "";
$number = "+###########";
Set-CsOnlineVoiceUser -Identity $user -TelephoneNumber $number;

<# Specify manually which number and emergency location ID to assign to a specific user. #>
$user = "";
$number = "+1234567890";
$location = "12345678-1234-1234-1234-123412345678";
Set-CsOnlineVoiceUser -Identity $user -TelephoneNumber $number -LocationID $location;


<# Interactive selection of both a number and an emergency location on a specific user. #>
$user = "";
$number = (Get-CsOnlineTelephoneNumber -IsNotAssigned | Where {$_.InventoryType -eq "Subscriber"} | Select Id,InventoryType,ActivationState,O365Region,CityCode | Out-GridView -Title "Which phone number to you wish to assign?" -OutputMode Single).Id;
$location = (Get-CsOnlineLisLocation | Select CompanyName,City,ValidationStatus,HouseNumber,StreetName,StateOrProvince,CountryOrRegion,LocationId | Out-GridView -Title "Which emergency location to assign?" -OutputMode Single).LocationId;
Set-CsOnlineVoiceUser -Identity $user -TelephoneNumber $number -LocationID $location;


<# Interactive selection of an emergency location and assignment of the first available number on a specific user. #>
$user = "";
$location = (Get-CsOnlineLisLocation | Select CompanyName,City,ValidationStatus,HouseNumber,StreetName,StateOrProvince,CountryOrRegion,LocationId | Out-GridView -Title "Which emergency location to assign?" -OutputMode Single).LocationId;
$number = (Get-CsOnlineTelephoneNumber -IsNotAssigned)[0].Id;
Set-CsOnlineVoiceUser -Identity $user -TelephoneNumber $number -LocationID $location;


<# Unassign number from a specific user. #>
$user = "";
Set-CsOnlineVoiceUser -Identity $user -TelephoneNumber $null;

<# Unassign number and location from a specific user and disable enterprise voice. #>
$user = "";
Set-CsOnlineVoiceUser -Identity $user -TelephoneNumber $null -LocationID $null;
Set-CsUser -Identity $user -EnterpriseVoiceEnabled $false;


<# Adjust the UsageLocation so it matches the country of the telephone number that will be assigned on a specific user. #>
Connect-MsolService;
Set-MsolUser -UserPrincipalName $user -UsageLocation "XX";
Set-CsOnlineVoiceUser -Identity $user -TelephoneNumber $number -LocationID $location;
Set-CsOnlineVoiceUser -Identity $user -TelephoneNumber $null;


<# Online vs Hybrid Unassigned User Numbers? #>
$NumberUserOnline = Get-CsOnlineTelephoneNumber -IsNotAssigned -InventoryType Subscriber;
$NumberUserHybrid = Get-CsOnlineTelephoneNumber -NumberType Hybrid -IsNotAssigned -InventoryType Subscriber;
$NumberUserHybrid; $NumberUserOnline;

<# Online vs Hybrid Unassigned Service Numbers? #>
$NumberServiceOnline = Get-CsOnlineTelephoneNumber -IsNotAssigned -InventoryType Service;
$NumberServiceHybrid = Get-CsOnlineTelephoneNumber -NumberType Hybrid -IsNotAssigned -InventoryType Service;
$NumberServiceOnline; $NumberServiceHybrid;
