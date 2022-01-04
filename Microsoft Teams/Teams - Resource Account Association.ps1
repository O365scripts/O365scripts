<#
.SYNOPSIS
Teams Resource Account Association
https://github.com/O365scripts/O365scripts/blob/master/Microsoft%20Teams/Teams%20-%20Resource%20Account%20Association.ps1
.NOTES
	> Expected Application IDs:
		+ Attendant ID: ce933385-9390-45d1-9512-c8d228074e07
		+ Call Queue ID: 11cd3e2e-fccb-42ad-ad00-878b93575e07
	> To do: Verify/list current associations.
.LINK
Reference:
https://docs.microsoft.com/en-us/powershell/module/skype/new-csonlineapplicationinstanceassociation?view=skype-ps
#>

<# Connect to Teams. #>
#Set-ExecutionPolicy RemoteSigned -Force -Confirm:$false;
#Install-Module MicrosoftTeams -AllowClobber -Force -Confirm:$false;
Import-Module MicrosoftTeams;
Connect-MicrosoftTeams;

<# Interactive: Associate an auto attendant resource account. #>
$Resource = (Get-CsOnlineApplicationInstance | Where {$_.ApplicationId -eq "ce933385-9390-45d1-9512-c8d228074e07"} | Out-GridView -OutputMode Single).ObjectId;
$Attendant = (Get-CsAutoAttendant | Out-GridView -OutputMode Single).Id;
New-CsOnlineApplicationInstanceAssociation -Identities @($Resource) -ConfigurationId $Attendant -ConfigurationType "AutoAttendant";

<# Interactive: Associate one or multiple auto attendant resource accounts. #>
$ListResource = Get-CsOnlineApplicationInstance | Where {$_.ApplicationId -eq "ce933385-9390-45d1-9512-c8d228074e07"} | Select DisplayName,UserPrincipalName,PhoneNumber,ObjectId | Out-GridView -PassThru -Title "Resource Account selection";
$Attendant = (Get-CsAutoAttendant | Out-GridView -OutputMode Single).Id;
$ListResource | % {New-CsOnlineApplicationInstanceAssociation -Identities @($_.ObjectId) -ConfigurationId $Attendant -ConfigurationType "AutoAttendant"}

<# Interactive: Associate a call queue resource account. #>
$Resource = (Get-CsOnlineApplicationInstance | Where {$_.ApplicationId -eq "11cd3e2e-fccb-42ad-ad00-878b93575e07"} | Out-GridView -OutputMode Single).ObjectId;
$CallQueue = (Get-CsAutoAttendant | Out-GridView -OutputMode Single).Id;
New-CsOnlineApplicationInstanceAssociation -Identities @($Resource) -ConfigurationId $Attendant -ConfigurationType "AutoAttendant";

<# Interactive: Associate one or multiple call queue resource accounts. #>
$ListResource = Get-CsOnlineApplicationInstance | Where {$_.ApplicationId -eq "11cd3e2e-fccb-42ad-ad00-878b93575e07"} | Select DisplayName,UserPrincipalName,PhoneNumber,ObjectId | Out-GridView -PassThru -Title "Resource Account selection";
$CallQueue = (Get-CsCallQueue | Out-GridView -OutputMode Single).Identity;
$ListResource | % {New-CsOnlineApplicationInstanceAssociation -Identities @($_.ObjectId) -ConfigurationId $CallQueue -ConfigurationType "CallQueue"}
