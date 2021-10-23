<#
.SYNOPSIS
Get Teams Voice User Overview Details
https://github.com/O365scripts/O365scripts/blob/master/Microsoft%20Teams/Teams%20-%20Voice%20User%20Overview.ps1
.NOTES
+CsOnlineApplicationInstance/Endpoint should fail normally unless the $User is a Resource Account for some reason.
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
Get-CsOnlineApplicationInstance -Identity $User -ErrorAction SilentlyContinue;
Get-CsOnlineApplicationEndpoint -Uri $User -ErrorAction SilentlyContinue;
# </TeamsVoiceUserOverview>


<# Export Teams Voice User Overview and compress to zip archive. #>
$User = "";
$Stamp = Get-Date -Format "yyyyMMddHHmmss"; $PathOut = "$env:TEMP\TeamsVoiceUserOverview_$Stamp";
$PathExportFile = "$env:USERPROFILE\Desktop\M365-TeamsVoiceUserOverview_$Stamp.zip";
New-Item $PathOut -ItemType Directory;
#$CsUser = Get-CsUser -Identity $User -ErrorAction SilentlyContinue;
#if ($CsUser) {$CsUser | Out-File -Encoding utf8 -FilePath "$PathOut\Get-CsUser.txt";}
$CsOnlineUser = Get-CsOnlineUser -Identity $User -ErrorAction SilentlyContinue;
if ($CsOnlineUser) {$CsOnlineUser | Out-File -Encoding utf8 -FilePath "$PathOut\Get-CsOnlineUser.txt";}
$CsOnlineVoiceUser = Get-CsOnlineVoiceUser -Identity $User -ErrorAction SilentlyContinue;
if ($CsOnlineVoiceUser) {$CsOnlineVoiceUser | Out-File -Encoding utf8 -FilePath "$PathOut\Get-CsOnlineVoiceUser.txt";}
$CsOnlineDialInConferencingUser = Get-CsOnlineDialInConferencingUser -Identity $User -ErrorAction SilentlyContinue
if ($CsOnlineDialInConferencingUser) {$CsOnlineDialInConferencingUser | Out-File -Encoding utf8 -FilePath "$PathOut\Get-CsOnlineDialInConferencingUser.txt";}
$CsOnlineApplicationInstance = Get-CsOnlineApplicationInstance -Identity $User -ErrorAction SilentlyContinue;
if ($CsOnlineApplicationInstance) {$CsOnlineApplicationInstance | Out-File -Encoding utf8 -FilePath "$PathOut\Get-CsOnlineApplicationInstance.txt";}
$CsOnlineApplicationEndpoint = Get-CsOnlineApplicationEndpoint -Uri $User -ErrorAction SilentlyContinue;
if ($CsOnlineApplicationEndpoint) {$CsOnlineApplicationEndpoint | Out-File -Encoding utf8 -FilePath "$PathOut\Get-CsOnlineApplicationEndpoint.txt";}
Compress-Archive -DestinationPath $PathExportFile -Path "$PathOut\*";
Remove-Item $PathOut -Recurse -Force -Confirm:$false;
explorer "/select,$PathExportFile";
<# </TeamsVoiceUserOverviewExport> #>
