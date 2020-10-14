<#
#>


<# Toggle on/off audio conferencing on a single user. #>
$User = "";
Disable-CsOnlineDialInConferencingUser $User;
Enable-CsOnlineDialInConferencingUser $User;

<# Export CsOnlineUser and ConferencingUser details of a specific user. #>
$User = "user@domain.com";
$UserOut = $User.Replace("@","_");
$Path_CsvOut = "$env:USERPROFILE\Desktop";
Get-CsOnlineUser -Identity $User | Export-Csv -Path "$Path_CsvOut\Get-CsOnlineUser - $UserOut.csv" -Encoding utf8 -NoTypeInformation;
Get-CsOnlineDialInConferencingUser -Identity $User | Export-Csv -Path "$Path_CsvOut\CsOnlineDialInConferencingUser - $UserOut.csv" -Encoding utf8 -NoTypeInformation;
