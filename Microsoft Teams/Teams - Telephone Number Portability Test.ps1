<#
.SYNOPSIS
Basic Portability Telephone Number Testing
(link)
.NOTES
.LINK
Reference:
#>

<# Connect to Teams. #>
#Set-ExecutionPolicy RemoteSigned -Force -Confirm:$false;
#Install-Module MicrosoftTeams -AllowClobber -Force -Confirm:$false;
Import-Module MicrosoftTeams;
Connect-MicrosoftTeams;

<# Verify basic portability number details. #>
$Number = "12223334444";
$TestPortIn = Test-CsOnlineCarrierPortabilityIn -TelephoneNumbers $Number;
Write-Host -NoNewline "Available Porting Days (Mon-Fri): "; Write-Host -Fore Yellow $TestPortIn.Carriers.FocDates;
Write-Host -NoNewline "Available Porting Hours: "; Write-Host -Fore Yellow "$($TestPortIn.Carriers.FocTimeRange.Begin) - $($TestPortIn.Carriers.FocTimeRange.End)";
Write-Host -NoNewline "Minimum Porting Interval: "; Write-Host -Fore Yellow "$($TestPortIn.Carriers.MinimumPortingInterval) days";
