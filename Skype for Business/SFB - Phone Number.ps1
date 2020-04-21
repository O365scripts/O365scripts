<#
.SYNOPSIS
.NOTES
.LINK
#>

<# Connect to Skype for Business Online. #>
    $me = "admin@domain.onmicrosoft.com";
Import-Module SkypeOnlineConnector;
$session_sfb = New-CsOnlineSession -UserName $me;
Import-PSSession $session_sfb;

<# Specify which emegency location to assign? #>
$location = Get-CsOnlineLisLocation | Select CompanyName,City,ValidationStatus,HouseNumber,StreetName,StateOrProvince,CountryOrRegion,LocationId | Out-GridView -Title "Which emergency location to assign?" -PassThru;

<# Specify manually which number to assign? #>
$number = "+###########";
<# Pick the first unassigned number? #>
$number = (Get-CsOnlineTelephoneNumber -IsNotAssigned)[0].Id;
<# Pick a specific unassigned number? #>
$number = "+" + (Get-CsOnlineTelephoneNumber -IsNotAssigned | Select Id,InventoryType,ActivationState,O365Region,CityCode | Out-GridView -Title "Which phone number to you wish to assign?" -PassThru);

<# Assign phone number and an emergency location to a voice-enabled user. #>
    $user = "user@domain.com";
Set-CsOnlineVoiceUser -Identity $user -TelephoneNumber $number -LocationID $location.LocationId;
