<#
.SYNOPSIS
.NOTES
.LINK
.EXAMPLE
#>

<# Report builder example. #>
$Report = [System.Collections.Generic.List[Object]]::new();
$ListX | % {
	$AttributeX = "";
	$AttributeX = $_.X;

    $ReportLine = [PSCustomObject] @{
		X = $_
		Y = $AttributeX
		Z = ""
	}
	$Report.Add($ReportLine);
}
<# View or export results? #>
$Report | Format-List;
$Report | Out-GridView;
$Report | Export-Csv -Path "$env:USERPROFILE\Desktop\Export_$((Get-Date -Format "yyyyMMdd-hhmmss")).csv" -Encoding utf8 -NoTypeInformation;
