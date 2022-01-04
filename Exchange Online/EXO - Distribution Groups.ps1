<#
.SYNOPSIS
.NOTES
.LINK
https://docs.microsoft.com/en-us/powershell/module/exchange/users-and-groups/set-distributiongroup?view=exchange-ps
#>

<# Connect to EXO v2. #>
#Set-ExecutionPolicy RemoteSigned -Force -Confirm:$false;
#Install-Module ExchangeOnlineManagement -AllowClobber -Force -Confirm:$false;
$AdminUpn = "";
Connect-ExchangeOnline -UserPrincipalName $AdminUpn;

<# Get distribution groups which are set to restrict members from joining or leaving. #>
Get-DistributionGroup -Filter {{MemberDepartRestriction -eq "Closed"} -or {MemberJoinRestriction -eq "Closed"}} | Where {$_.GroupType -notmatch "SecurityEnabled"};

<# Set all distribution groups which are set to restrict members from joining or leaving to be opened. #>
$dg_depart = "Open";
$dg_join = "Open";
Get-DistributionGroup -Filter {{MemberDepartRestriction -eq "Closed"} -or {MemberJoinRestriction -eq "Closed"}} | `
	Where {$_.GroupType -notmatch "SecurityEnabled"} | Select Primary*,DisplayName,*Restriction,GroupType,WhenCreated | `
	? {Set-DistributionGroup -Identity $_.PrimarySmtpAddress -MemberJoinRestriction $dg_join -MemberDepartRestriction $dg_depart};
