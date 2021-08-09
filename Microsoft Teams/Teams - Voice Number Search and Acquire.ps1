<#
.SYNOPSIS
Teams Cloud Number Search and Acquire Management

.NOTES
Get-CsOnlineTelephoneNumberInventoryTypes:	Service, Subscriber, TollFree
Get-CsOnlineTelephoneNumberInventoryRegions: NOAM, EMEA, APAC, LATAM
Get-CsOnlineTelephoneNumberInventoryCountries
Get-CsOnlineTelephoneNumberInventoryCities
Get-CsOnlineTelephoneNumberInventoryAreas
Search-CsOnlineTelephoneNumberInventory
Select-CsOnlineTelephoneNumberInventory
Get-CsOnlineTelephoneNumberReservationsInformation
Clear-CsOnlineTelephoneNumberReservation

.LINK
https://docs.microsoft.com/en-us/powershell/module/skype/search-csonlinetelephonenumberinventory?view=skype-ps
https://docs.microsoft.com/en-us/powershell/module/skype/select-csonlinetelephonenumberinventory?view=skype-ps
https://docs.microsoft.com/en-us/powershell/module/skype/get-csonlinetelephonenumberinventoryregions?view=skype-ps
https://docs.microsoft.com/en-us/powershell/module/skype/get-csonlinetelephonenumberinventoryareas?view=skype-ps
https://docs.microsoft.com/en-us/powershell/module/skype/get-csonlinetelephonenumber?view=skype-ps
#>

<# QUICKRUN: Install the Teams module and connect to SFBO. #>
$Tenant = "mytenant";
#Set-ExecutionPolicy RemoteSigned;
#Install-Module MicrosoftTeams -Force -Confirm:$false;
Import-Module MicrosoftTeams;
$Session_Sfb = New-CsOnlineSession -OverrideAdminDomain "$Tenant.onmicrosoft.com";
Import-PSSession $Session_Sfb;



<# How many numbers do you wish to acquire? #>
$InvQuantity = 1;

<# Specify the type, region, country, area, city and area code to attempt claiming numbers from. #>
$InvType = (Get-CsOnlineTelephoneNumberInventoryTypes | Select Id | Out-GridView -OutputMode Single).Id;
$InvRegion = (Get-CsOnlineTelephoneNumberInventoryRegions -InventoryType $InvType | Select Id | Out-GridView -OutputMode Single).Id;
$InvCountry = (Get-CsOnlineTelephoneNumberInventoryCountries -InventoryType $InvType -RegionalGroup $InvRegion | Select Id,DefaultName | Out-GridView -OutputMode Single).Id;
$InvArea = (Get-CsOnlineTelephoneNumberInventoryAreas -InventoryType $InvType -RegionalGroup $InvRegion -CountryOrRegion $InvCountry | Select Id,DefaultName | Out-GridView -OutputMode Single).Id;
$InvCity = Get-CsOnlineTelephoneNumberInventoryCities -InventoryType $InvType -RegionalGroup $InvRegion -CountryOrRegion $InvCountry -Area $InvArea | Select AreaCodes,DefaultName,Id,GeoCode | Out-GridView -OutputMode Single;
$InvAreaCode = $InvCity | Select -ExpandProperty AreaCodes | Out-GridView -OutputMode Single;

<# Search! #>
$InvSearch = Search-CsOnlineTelephoneNumberInventory -Quantity $InvQuantity -InventoryType $InvType -RegionalGroup $InvRegion -CountryOrRegion $InvCountry -Area $InvArea -CapitalOrMajorCity $InvCity.Id;

<# Which numbers do you want to keep? #>
$InvSearchNumbers = $InvSearch.Reservations[0].Numbers | Select -ExpandProperty Number;
$InvNumbers = $InvSearchNumbers | Out-GridView -PassThru;

<# Acquire! #>
$InvSelect = Select-CsOnlineTelephoneNumberInventory -ReservationId $InvSearch.ReservationId -TelephoneNumbers $InvNumbers -Region $InvRegion -CountryOrRegion $InvCountry -Area $InvArea -City $InvCity.Id;
$InvNumbers | % {Get-CsOnlineTelephoneNumber -TelephoneNumber $_}


<# Count how many total numbers of each type. #>
$NumbersTotalService = (Get-CsOnlineTelephoneNumber -InventoryType "Service").Count;
$NumbersTotalServiceUnassigned = (Get-CsOnlineTelephoneNumber -InventoryType "Service" -IsNotAssigned).Count;
$NumbersTotalUsers = (Get-CsOnlineTelephoneNumber -InventoryType "Subscriber").Count;
$NumbersTotalUsersUnassigned = (Get-CsOnlineTelephoneNumber -InventoryType "Subscriber" -IsNotAssigned).Count;
$NumbersTollFree = (Get-CsOnlineTelephoneNumber -InventoryType "TollFree").Count;
$NumbersTollFreeUnassigned = (Get-CsOnlineTelephoneNumber -InventoryType "TollFree" -IsNotAssigned).Count;

<# Count the maximum of total and service numbers available. #>
$InvMaxTotal = (Get-CsOnlineTelephoneNumberAvailableCount).Count;
$InvMaxUser = (Get-CsOnlineTelephoneNumberAvailableCount -InventoryType "Subscriber").Count;
$InvMaxService = (Get-CsOnlineTelephoneNumberAvailableCount -InventoryType "Service").Count;



<# Current values. #>
Clear-Host;
Write-Host -NoNewline "Quantity: "; Write-Host -Fore Yellow $InvQuantity;
Write-Host -NoNewline "Number Type: "; Write-Host -Fore Yellow $InvType;
Write-Host -NoNewline "Region: "; Write-Host -Fore Yellow $InvRegion;
Write-Host -NoNewline "Country: "; Write-Host -Fore Yellow $InvCountry;
Write-Host -NoNewline "Area: "; Write-Host -Fore Yellow $InvArea;
Write-Host -NoNewline "City: "; Write-Host -Fore Yellow $InvCity.DefaultName;
Write-Host -NoNewline "Area Code: "; Write-Host -Fore Yellow $InvAreaCode;
Write-Host;
Write-Host -NoNewline "Search Possible Numbers: "; Write-Host -Fore Yellow $InvSearchNumbers;
Write-Host -NoNewline "Search Selected Numbers: "; Write-Host -Fore Yellow $InvNumbers;
Write-Host -NoNewline "Search Reservation ID: "; Write-Host -Fore Yellow $InvSearch.ReservationId;
Write-Host;
Write-Host -NoNewline "Maximum Numbers: "; Write-Host -Fore Yellow $InvMaxTotal;
Write-Host -NoNewline "Maximum Service Numbers: "; Write-Host -Fore Yellow $InvMaxService;
Write-Host -NoNewline "Maximum User Numbers: "; Write-Host -Fore Yellow $InvMaxUser;
Write-Host;
Write-Host -NoNewline "Service Numbers: "; Write-Host -Fore Yellow $NumbersTotalService;
Write-Host -NoNewline "Unassigned Service Numbers: : "; Write-Host -Fore Yellow $NumbersTotalServiceUnassigned;
Write-Host -NoNewline "User Numbers: : "; Write-Host -Fore Yellow $NumbersTotalUsers;
Write-Host -NoNewline "Unassigned User Numbers: "; Write-Host -Fore Yellow $NumbersTotalUsersUnassigned;
Write-Host -NoNewline "Toll Free Numbers: "; Write-Host -Fore Yellow $NumbersTollFree;
Write-Host -NoNewline "Unassigned Toll Free Numbers: "; Write-Host -Fore Yellow $NumbersTollFreeUnassigned;
