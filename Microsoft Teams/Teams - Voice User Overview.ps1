<#
.SYNOPSIS
Get Teams Voice User Overview Details
https://github.com/O365scripts/O365scripts/blob/master/Microsoft%20Teams/Teams%20-%20Voice%20User%20Overview.ps1
.NOTES
	> Get-CsOnlineApplicationInstance/Endpoint should normally fail unless the $User is also a Resource Account.
.LINK
Reference:
https://docs.microsoft.com/en-us/powershell/module/skype/get-csonlineuser?view=skype-ps
https://docs.microsoft.com/en-us/powershell/module/skype/get-csonlinevoiceuser?view=skype-ps
https://docs.microsoft.com/en-us/powershell/module/skype/get-csonlinedialinconferencinguser?view=skype-ps
https://docs.microsoft.com/en-us/powershell/module/skype/get-csonlineapplicationendpoint?view=skype-ps
https://docs.microsoft.com/en-us/powershell/module/skype/get-csonlineapplicationinstance?view=skype-ps
#>

<# Connect to Teams. #>
#Set-ExecutionPolicy RemoteSigned -Force -Confirm:$false;
#Install-Module MicrosoftTeams -AllowClobber -Force -Confirm:$false;
Import-Module MicrosoftTeams;
Connect-MicrosoftTeams;

<# Prevent output truncation... #>
$FormatEnumerationLimit = -1;

<# Display Teams Voice User Overview. #>
$User = "";
Get-CsOnlineUser -Identity $User | Select *;
Get-CsOnlineVoiceUser -Identity $User;
Get-CsOnlineDialInConferencingUser -Identity $User;
#Get-CsOnlineApplicationInstance -Identity $User -ErrorAction SilentlyContinue;
#Get-CsOnlineApplicationEndpoint -Uri $User -ErrorAction SilentlyContinue;
# </TeamsVoiceUserOverview>

<# Get Teams Voice User Overview and send compressed output to zip. #>
$User = "";
$Encoding = "utf8";
$Stamp = Get-Date -Format "yyyyMMddHHmmss"; $PathOut = "$env:TEMP\TeamsVoiceUserOverview_$Stamp";
$PathExport = "$env:USERPROFILE\Downloads"; $PathExportFile = "$PathExport\M365-TeamsVoiceUserOverview_$Stamp.zip";
New-Item $PathOut -ItemType Directory | Out-Null;
$CsOnlineUser = Get-CsOnlineUser -Identity $User -ErrorAction SilentlyContinue; if ($CsOnlineUser) {$CsOnlineUser | Out-File "$PathOut\Get-CsOnlineUser.txt" -Encoding $Encoding};
$CsOnlineVoiceUser = Get-CsOnlineVoiceUser -Identity $User -ErrorAction SilentlyContinue; if ($CsOnlineVoiceUser) {$CsOnlineVoiceUser | Out-File "$PathOut\Get-CsOnlineVoiceUser.txt" -Encoding $Encoding};
$CsOnlineDialInConferencingUser = Get-CsOnlineDialInConferencingUser -Identity $User -ErrorAction SilentlyContinue; if ($CsOnlineDialInConferencingUser) {$CsOnlineDialInConferencingUser | Out-File "$PathOut\Get-CsOnlineDialInConferencingUser.txt" -Encoding $Encoding};
#$CsOnlineApplicationInstance = Get-CsOnlineApplicationInstance -Identity $User -ErrorAction SilentlyContinue; if ($CsOnlineApplicationInstance) {$CsOnlineApplicationInstance | Out-File "$PathOut\Get-CsOnlineApplicationInstance.txt" -Encoding $Encoding};
#$CsOnlineApplicationEndpoint = Get-CsOnlineApplicationEndpoint -Uri $User -ErrorAction SilentlyContinue; if ($CsOnlineApplicationEndpoint) {$CsOnlineApplicationEndpoint | Out-File "$PathOut\Get-CsOnlineApplicationEndpoint.txt" -Encoding $Encoding};
Compress-Archive -Path "$PathOut\*" -DestinationPath $PathExportFile;
Remove-Item $PathOut -Recurse -Force -Confirm:$false;
explorer "/select,$PathExportFile";
<# </TeamsVoiceUserOverviewExport> #>
