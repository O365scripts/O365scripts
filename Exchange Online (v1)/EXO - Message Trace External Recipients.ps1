<#
.SYNOPSIS
	Search in message trace for all unique external recipient addresses.
.NOTES

.LINK
	https://docs.microsoft.com/en-us/powershell/module/exchange/mail-flow/get-messagetrace?view=exchange-ps
#>

<# Single custom domain? #>
$domain = "domain.com";
$domain_onms = "tenant.onmicrosoft.com";
$path_csv = "$env:USERPROFILE\Desktop\export.csv";
Get-MessageTrace -StartDate (Get-Date).Adddays(-30) -EndDate (Get-Date) | `
	Where {$_.RecipientAddress -notlike "*$domain" -and `
		$_.RecipientAddress -notlike "*$domain_onms"} | `
	Group-Object -Property RecipientAddress | Select Name | `
	Export-Csv -NoTypeInformation -Path $path_csv;


<# Multiple custom domains? #>
$domain = "domain.com";
$domain2 = "domain2.com";
$domain3 = "domain3.com";
$domain_onms = "tenant.onmicrosoft.com";

$path_csv = "$env:USERPROFILE\Desktop\export.csv";
Get-MessageTrace -StartDate (Get-Date).Adddays(-30) -EndDate (Get-Date) | `
	Where {$_.RecipientAddress -notlike "*$domain" -and `
		$_.RecipientAddress -notlike "*$domain2"} -and `
		$_.RecipientAddress -notlike "*$domain3"} -and `
		$_.RecipientAddress -notlike "*$domain_onms"} | `
	Group-Object -Property RecipientAddress | Select Name | `
	Export-Csv -NoTypeInformation -Path $path_csv;
