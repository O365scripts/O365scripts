function X {
<#
.SYNOPSIS
.NOTES
.EXAMPLE
.LINK
#>

[CmdletBinding()]
param(
	[Parameter(
		Mandatory = $true,
		ValueFromPipeline = $true,
		ValueFromPipelineByPropertyName = $true,
		Position = 0
		)]
	[string[]]  $X
)
Begin {}
Process {}
End {}
}