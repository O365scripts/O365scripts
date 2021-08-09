<#
.NOTES
.LINK
#>

<# QUICKRUN: Install the Teams module and connect to SFBO. #>
$Me = "admin@mytenant.onmicrosoft.com";
$Tenant = "mytenant";
Install-Module MicrosoftTeams -Force -Confirm:$false;
$Session_Sfb = New-CsOnlineSession -OverrideAdminDomain "$Tenant.onmicrosoft.com";
Import-PSSession $Session_Sfb -AllowClobber;

<# Toggle Enterprise Voice on a specific user. #>
$User = "user@domain.com";
Set-CsUser -Identity $User -EnterpriseVoiceEnabled $false;
Set-CsUser -Identity $User -EnterpriseVoiceEnabled $true;

<# Toggle Enterprise Voice on all users. #>
Get-CsOnlineUser | % {Set-CsUser -Identity $_.Identity -EnterpriseVoiceEnabled $false -ErrorAction SilentlyContinue;}
Get-CsOnlineUser | % {Set-CsUser -Identity $_.Identity -EnterpriseVoiceEnabled $true -ErrorAction SilentlyContinue;}
