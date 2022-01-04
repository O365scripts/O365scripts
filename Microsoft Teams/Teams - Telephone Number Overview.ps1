<#
.SYNOPSIS
Teams Voice Number Overview
https://github.com/O365scripts/O365scripts/blob/master/Microsoft%20Teams/Teams%20-%20Telephone%20Number%20Overview.ps1
.NOTES
.LINK
Reference:
https://docs.microsoft.com/en-us/powershell/module/skype/get-csonlinetelephonenumber?view=skype-ps
https://docs.microsoft.com/en-us/powershell/module/skype/get-csonlineuser?view=skype-ps
https://docs.microsoft.com/en-us/powershell/module/skype/get-csonlinevoiceuser?view=skype-ps
#>

<# Connect to Teams. #>
#Set-ExecutionPolicy RemoteSigned -Force -Confirm:$false;
#Install-Module MicrosoftTeams -AllowClobber -Force -Confirm:$false;
Import-Module MicrosoftTeams;
Connect-MicrosoftTeams;

<# Get numbers and stats. #>
$ListAllNumbers = Get-CsOnlineTelephoneNumber;
$CountTotalNumbers = $ListAllNumbers.Count;
$CountServiceNumbers = ($ListAllNumbers | Where {$_.InventoryType -eq "Service"}).Count;
$CountUserNumbers = ($ListAllNumbers | Where {$_.InventoryType -eq "Subscriber"}).Count;
$CountTollFreeNumbers = ($ListAllNumbers | Where {$_.InventoryType -eq "Subscriber"}).Count;

<# Display report. #>
Clear
#Write-Host -NoNewLine "# of X: "; Write-Host -Fore Yellow $CountX;
Write-Host -NoNewLine "Total Numbers: "; Write-Host -Fore Yellow $CountTotalNumbers;
Write-Host -NoNewLine "# of User Numbers: "; Write-Host -Fore Yellow $CountUserNumbers;
Write-Host -NoNewLine "# of Service Numbers: "; Write-Host -Fore Yellow $CountServiceNumbers;

$ListAllNumbers | sort InventoryType,CityCode | ft -AutoSize O365Region,InventoryType,Id,CityCode,ActivationState,FriendlyName,TargetType
$ListNumbers = $ListAllNumbers | sort InventoryType,CityCode | Out-GridView -PassThru -Title "Select one or multiple numbers (hold control).";
$ListNumbers | % {Get-CsOnlineTelephoneNumber -TelephoneNumber $_.Id;
};
#$ListAllNumbers | select -First 1
