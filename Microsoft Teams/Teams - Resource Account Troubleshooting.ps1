<#
.SYNOPSIS
https://github.com/O365scripts/O365scripts/blob/master/Microsoft%20Teams/.ps1
.NOTES
.LINK
#>

<# Connect to Teams. #>
#Set-ExecutionPolicy RemoteSigned -Force -Confirm:$false;
#Install-Module MicrosoftTeams -AllowClobber -Force -Confirm:$false;
Import-Module MicrosoftTeams;
Connect-MicrosoftTeams;

<# #>
#Get-CsOnlineUser | Where {$_.InterpretedUserType -match ""} | Select UserPrincipalName,InterpretedUserType,ObjectId;
Get-CsOnlineUser | Where {$_.InterpretedUserType -match "AADConnect"} | Select UserPrincipalName,InterpretedUserType,ObjectId;
Get-CsOnlineUser | Where {$_.InterpretedUserType -match "Hybrid"} | Select UserPrincipalName,InterpretedUserType,ObjectId;
Get-CsOnlineUser | Where {$_.InterpretedUserType -match "Misconfigured"} | Select UserPrincipalName,InterpretedUserType,ObjectId;
