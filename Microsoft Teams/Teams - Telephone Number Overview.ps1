<#
.SYNOPSIS
Teams Voice Number Overview
https://github.com/O365scripts/O365scripts/blob/master/Microsoft%20Teams/Teams%20-%20Telephone%20Number%20Overview.ps1

.NOTES

.LINK
Reference:
https://learn.microsoft.com/powershell/module/skype/get-csonlinetelephonenumber
https://learn.microsoft.com/powershell/module/skype/get-csonlineuser
https://learn.microsoft.com/powershell/module/skype/get-csonlinevoiceuser
#>

<# Connect to Teams. #>
#Set-ExecutionPolicy RemoteSigned -Force -Confirm:$false;
#Install-Module MicrosoftTeams -AllowClobber -Force -Confirm:$false;
Import-Module MicrosoftTeams;
Connect-MicrosoftTeams;

<# Get numbers and stats. #>
$ListAllNumbers = Get-CsPhoneNumberAssignment;
$CountTotalNumbers = $ListAllNumbers.Count;
$CountServiceNumbers = ($ListAllNumbers | Where {$_.InventoryType -eq "Service"}).Count;
$CountUserNumbers = ($ListAllNumbers | Where {$_.InventoryType -eq "Subscriber"}).Count;
$CountTollFreeNumbers = ($ListAllNumbers | Where {$_.InventoryType -eq "Subscriber"}).Count;

<# Display number inventory report (incomplete). #>
Clear;
Write-Host -NoNewLine "Total Numbers: "; Write-Host -Fore Yellow $CountTotalNumbers;
Write-Host -NoNewLine "# of User Numbers: "; Write-Host -Fore Yellow $CountUserNumbers;
Write-Host -NoNewLine "# of Service Numbers: "; Write-Host -Fore Yellow $CountServiceNumbers;
Write-Host -NoNewLine "  Toll: "; Write-Host -Fore Yellow ($CountServiceNumbers - $CountTollFreeNumbers);
Write-Host -NoNewLine "  Toll Free: "; Write-Host -Fore Yellow $CountTollFreeNumbers;

<# Display details of all numbers by type. #>
$ListAllNumbers | Sort InventoryType,CityCode | Format-Table -AutoSize O365Region,InventoryType,Id,CityCode,ActivationState,FriendlyName,TargetType

# Display the properties of specific numbers.
$ListNumbers = $ListAllNumbers | Sort InventoryType,CityCode | Out-GridView -PassThru -Title "Select one or multiple numbers (hold control).";
$ListNumbers | Format-List;
