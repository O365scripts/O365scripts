<#
.SYNOPSIS
.NOTES
.LINK
https://docs.microsoft.com/en-us/powershell/module/skype/get-csonlinedialinconferencinguser?view=skype-ps
https://docs.microsoft.com/en-us/powershell/module/skype/set-csonlinedialinconferencinguser?view=skype-ps
https://docs.microsoft.com/en-us/powershell/module/skype/get-csonlineuser?view=skype-ps
#>


<# Toggle on/off audio conferencing on a single user. #>
$User = "";
Disable-CsOnlineDialInConferencingUser $User;
Enable-CsOnlineDialInConferencingUser $User;

<# Export CsOnlineUser and ConferencingUser details of a specific user. #>
$User = "user@domain.com";
$UserOut = $User.Replace("@","_");
Get-CsOnlineUser -Identity $User -ErrorAction SilentlyContinue | Out-File -Encoding utf8 -FilePath "$env:USERPROFILE\Desktop\Get-CsOnlineUser__$($User.Replace("@","_"))_$Stamp.txt";
Get-CsOnlineDialInConferencingUser -Identity $User -ErrorAction SilentlyContinue | Out-File -FilePath "$env:USERPROFILE\Desktop\Get-CsOnlineDialInConferencingUser__$($User.Replace("@","_"))_$Stamp.txt";
