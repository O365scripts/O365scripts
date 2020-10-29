<#
.NOTES
.LINK
#>

<# Toggle Enterprise Voice on a specific user. #>
$User = "user@domain.com";
Set-CsUser -Identity $User -EnterpriseVoiceEnabled $false;
Set-CsUser -Identity $User -EnterpriseVoiceEnabled $true;

<# Toggle Enterprise Voice on all users. #>
Get-CsUser | % {Set-CsUser -Identity $_.Identity -EnterpriseVoiceEnabled $false -ErrorAction SilentlyContinue;}
Get-CsUser | % {Set-CsUser -Identity $_.Identity -EnterpriseVoiceEnabled $true -ErrorAction SilentlyContinue;}
