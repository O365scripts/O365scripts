<#
.SYNOPSIS
Simple function to generate a full timestamp.
.NOTES
Version Update: 2020-11-03
Author: https://github.com/O365scripts
.LINK
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-date?view=powershell-7
#>

<# Timestamper. #>
function Get-Timestamp {Get-Date -Format "yyyyMMddHHmmss"}
