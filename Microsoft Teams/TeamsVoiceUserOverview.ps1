<#
.SYNOPSIS
Get Teams Voice User Overview Details
https://github.com/O365scripts/O365scripts/blob/master/Microsoft%20Teams/TeamsVoiceUserOverview.ps1

.NOTES
Get-CsOnlineApplicationInstance should normally fail unless the $User is an actual Resource Account.
The CsOnlineVoiceUser command has been replaced by the CsPhoneNumberAssignment. 

.LINK
Reference:
https://learn.microsoft.com//powershell/module/skype/get-csonlineuser
https://learn.microsoft.com//powershell/module/skype/get-csonlinedialinconferencinguser
https://learn.microsoft.com//powershell/module/skype/get-csonlineapplicationinstance
https://learn.microsoft.com//powershell/module/skype/get-csonlinevoiceuser [deprecated]
https://learn.microsoft.com//powershell/module/skype/get-csonlineapplicationendpoint [deprecated]
#>

<# Connect to Teams. #>
#Set-ExecutionPolicy RemoteSigned -Force -Confirm:$false;
#Install-Module MicrosoftTeams -AllowClobber -Force -Confirm:$false;
Import-Module MicrosoftTeams;
Connect-MicrosoftTeams;

<# Prevent output truncation... #>
$FormatEnumerationLimit = -1;

<# a) Display Teams Voice User Overview. #>
$User = "";
Get-CsOnlineUser -Identity $User | Select *;
Get-CsPhoneNumbAssignemnt -AssignedPstnTargetId $User;
Get-CsOnlineDialInConferencingUser -Identity $User;
#Get-CsOnlineApplicationInstance -Identity $User -ErrorAction SilentlyContinue;
# </TeamsVoiceUserOverview>


<# b) Get Teams Voice User Overview and send compressed output to zip. #>
$User = "";
$Encoding = "utf8";
$Stamp = Get-Date -Format "yyyyMMddHHmmss"; $PathOut = "$env:TEMP\TeamsVoiceUserOverview_$Stamp";
$PathExport = "$env:USERPROFILE\Downloads"; $PathExportFile = "$PathExport\M365TeamsVoiceUserOverview_$Stamp.zip";
New-Item $PathOut -ItemType Directory | Out-Null;
$CsOnlineUser = Get-CsOnlineUser -Identity $User -ErrorAction SilentlyContinue; if ($CsOnlineUser) {$CsOnlineUser | Out-File "$PathOut\Get-CsOnlineUser.txt" -Encoding $Encoding};
$CsPhone = Get-CsPhoneNumberAssignment -AssignedPstnTargetId $User -ErrorAction SilentlyContinue; if ($CsPhone) {$CsPhone | Out-File "$PathOut\Get-CsPhoneNumberAssignment.txt" -Encoding $Encoding};
$CsOnlineDialInConferencingUser = Get-CsOnlineDialInConferencingUser -Identity $User -ErrorAction SilentlyContinue; if ($CsOnlineDialInConferencingUser) {$CsOnlineDialInConferencingUser | Out-File "$PathOut\Get-CsOnlineDialInConferencingUser.txt" -Encoding $Encoding};
#$CsOnlineApplicationInstance = Get-CsOnlineApplicationInstance -Identity $User -ErrorAction SilentlyContinue; if ($CsOnlineApplicationInstance) {$CsOnlineApplicationInstance | Out-File "$PathOut\Get-CsOnlineApplicationInstance.txt" -Encoding $Encoding};
Compress-Archive -Path "$PathOut\*" -DestinationPath $PathExportFile;
Remove-Item $PathOut -Recurse -Force -Confirm:$false;
explorer "/select,$PathExportFile";
<# </TeamsVoiceUserOverviewExport> #>
