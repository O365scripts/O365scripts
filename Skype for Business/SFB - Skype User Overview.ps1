<#
.SYNOPSIS
.NOTES
.LINK
#>

<# Skype/Teams User Overview. #>
$User = "user@domain.com";
$Path_CsvOut = "$env:USERPROFILE\Desktop"; 
$UserOut = $User.Replace("@","_");
Get-CsOnlineUser -Identity $User -ErrorAction SilentlyContinue | Export-Csv -Path "$Path_CsvOut\Get-CsOnlineUser__$UserOut_$Stamp.csv" -Encoding utf8 -NoTypeInformation;
Get-CsOnlineVoiceUser -Identity $User -ErrorAction SilentlyContinue | Export-Csv -Path "$Path_CsvOut\Get-CsOnlineVoiceUser__$UserOut_$Stamp.csv" -Encoding utf8 -NoTypeInformation;
Get-CsOnlineDialInConferencingUser -Identity $User -ErrorAction SilentlyContinue | Export-Csv -Path "$Path_CsvOut\CsOnlineDialInConferencingUser__$UserOut_$Stamp.csv" -Encoding utf8 -NoTypeInformation;
Get-CsOnlineApplicationInstance -Identity $User -ErrorAction SilentlyContinue | Export-Csv -Path "$Path_CsvOut\CsOnlineApplicationInstance__$UserOut_$Stamp.csv" -Encoding utf8 -NoTypeInformation;
Get-CsUser -Identity $User -ErrorAction SilentlyContinue | Export-Csv -Path "$Path_CsvOut\Get-CsUser__$UserOut_$Stamp.csv" -Encoding utf8 -NoTypeInformation;
