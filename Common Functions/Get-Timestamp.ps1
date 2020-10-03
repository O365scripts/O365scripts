<#
.SYNOPSIS
Function to generate a full timestamp.
.NOTES
.LINK
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-date?view=powershell-7
#>

<# Timestamper. #>
function Get-Timestamp {$Stamp = Get-Date -Format "yyyyMMddHHmmss"; $Stamp;}
