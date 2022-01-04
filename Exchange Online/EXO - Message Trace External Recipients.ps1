<#
.SYNOPSIS
Search in message trace for all unique external recipient addresses.
https://github.com/O365scripts/O365scripts/blob/master/Exchange%20Online/EXO%20-%20Message%20Trace%20External%20Recipients.ps1
.NOTES
	> To do? Automated enumeration of possible verified domains via Get-MsolDomain/AzureADDomain.
.LINK
https://docs.microsoft.com/en-us/powershell/module/exchange/mail-flow/get-messagetrace?view=exchange-ps
#>

<# Connect to EXO v2. #>
#Set-ExecutionPolicy RemoteSigned -Force -Confirm:$false;
#Install-Module ExchangeOnlineManagement -AllowClobber -Force -Confirm:$false;
$AdminUpn = "";
Connect-ExchangeOnline -UserPrincipalName $AdminUpn;

<# Export list of unique external addresses sent out via the onMS or by the custom domain to CSV. #>
$Domain = "domain.com";
$DomainOnms = "tenant.onmicrosoft.com";
$PathCsv = "$env:USERPROFILE\Desktop\ExportMsgTraceUniqueExternalAddresses_$((Get-Date -Format "yyyyMMddHHmmss")).csv";
Get-MessageTrace -StartDate (Get-Date).Adddays(-30) -EndDate (Get-Date) | `
	Where {$_.RecipientAddress -notlike "*$Domain" -and $_.RecipientAddress -notlike "*$DomainOnms"} | `
	Group-Object -Property RecipientAddress | Select Name | `
	Export-Csv -NoTypeInformation -Path $PathCsv;


<# Export list of unique external addresses sent out via the onMS or by multiple custom domains to CSV. #>
$Domain = "domain.com";
$Domain2 = "domain2.com";
$Domain3 = "domain3.com";
$DomainOnms = "tenant.onmicrosoft.com";
$PathCsv = "$env:USERPROFILE\Downloads\ExportMsgTraceUniqueExternalAddresses_$((Get-Date -Format "yyyyMMddHHmmss")).csv";
Get-MessageTrace -StartDate (Get-Date).Adddays(-30) -EndDate (Get-Date) | `
	Where {$_.RecipientAddress -notlike "*$Domain" -and `
		$_.RecipientAddress -notlike "*$Domain2"} -and `
		$_.RecipientAddress -notlike "*$Domain3"} -and `
		$_.RecipientAddress -notlike "*$DomainOnms"} | `
	Group-Object -Property RecipientAddress | Select Name | `
	Export-Csv -NoTypeInformation -Path $PathCsv;
