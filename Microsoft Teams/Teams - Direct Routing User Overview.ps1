<#
.SYNOPSIS
Teams Direct Routing User Overview
(link)
.NOTES
.LINK
https://docs.microsoft.com/en-us/microsoftteams/direct-routing-landing-page
#>

<# Connect to Teams. #>
#Set-ExecutionPolicy RemoteSigned -Force -Confirm:$false;
#Install-Module MicrosoftTeams -AllowClobber -Force -Confirm:$false;
Import-Module MicrosoftTeams;
Connect-MicrosoftTeams;

<# Prevent output truncation... #>
$FormatEnumerationLimit = -1;

<# #>
# ...