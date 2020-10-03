<#
.SYNOPSIS
Function to generate a random string of a given length.
.NOTES
Credits to Marcus Gelderman for the original script!
.LINK
https://gist.github.com/marcgeld/4891bbb6e72d7fdb577920a6420c1dfb
#>

<# Random string maker. #>
Function Get-RandomAlphaNumString {
	[CmdletBinding()] Param ([int] $Length = 16)
	Begin {}
	Process {
		$Out = (-join ((0x30..0x39)+(0x41..0x5A)+(0x61..0x7A) | Get-Random -Count $Length | % {[char]$_}) );
		$Out;
	}
}
