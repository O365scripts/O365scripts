<#
.SYNOPSIS
.NOTES
.LINK
#>

<# #>
$Report = [System.Collections.Generic.List[Object]]::new();
$ListDomains | % {
	<# #>
	$DnsNS		= (Resolve-Dnsname -Type "NS" -Name $_ -ErrorAction SilentlyContinue).ForEach({$_[0].NameHost}) | Out-String;
	$DnsA		= (Resolve-Dnsname -Type "A" -Name $_ -ErrorAction SilentlyContinue).ForEach({$_[0].IPAddress}) | Out-String;
	$DnsMx      = (Resolve-DnsName -Type "MX" -Name $_ -ErrorAction SilentlyContinue | sort Preference).ForEach({"$($_.NameExchange) [$($_.Preference)]"}) | Out-String;
	$DnsTxt		= (Resolve-Dnsname -Type "TXT" -Name $_ -ErrorAction SilentlyContinue).ForEach({$_[0].Strings}) | Out-String;
	$DnsAuto	= (Resolve-DnsName -ErrorAction SilentlyContinue -Type "CNAME" -Name "autodiscover.$_").NameHost;
	$DnsDkim1	= (Resolve-DnsName -Type "CNAME" -Name "selector1._domainkey.$_" -ErrorAction SilentlyContinue).NameHost;
	$DnsDkim2	= (Resolve-DnsName -Type "CNAME" -Name "selector2._domainkey.$_" -ErrorAction SilentlyContinue).NameHost;
	$DnsSfb1	= (Resolve-Dnsname -ErrorAction SilentlyContinue -Type "CNAME" -Name "lyncdiscover.$_").NameHost;
	$DnsSfb2	= (Resolve-Dnsname -ErrorAction SilentlyContinue -Type "CNAME" -Name "sip.$_").NameHost;
	$DnsSfbSrv1 = (Resolve-DnsName -ErrorAction SilentlyContinue -Type "SRV" -Name "_sip._tls.$_").ForEach({if ("" -ne $_.NameTarget) {$_[0].NameTarget}}) | Out-String;
	$DnsSfbSrv2 = (Resolve-DnsName -ErrorAction SilentlyContinue -Type "SRV" -Name "_sipfederationtls._tcp.$_").ForEach({if ("" -ne $_.NameTarget) {$_[0].NameTarget}}) | Out-String;
	$DnsMdm1 	= (Resolve-Dnsname -ErrorAction SilentlyContinue -Type "CNAME" -Name "enterpriseregistration.$_").NameHost;
	$DnsMdm2 	= (Resolve-Dnsname -ErrorAction SilentlyContinue -Type "CNAME" -Name "enterpriseenrollment.$_").NameHost;

	$ReportLine = [PSCustomObject] @{
		#Domain			= $_.Identity
		Domain			= $_
		NS				= $DnsNS
		A				= $DnsA
		MX				= $DnsMx
		TXT				= $DnsTxt
		Autodiscover	= $DnsAuto
		DKIM_1			= $DnsDkim1
		DKIM_2			= $DnsDkim2
		SkypeCNAME_1	= $DnsSfb1
		SkypeCNAME_2	= $DnsSfb2
		SkypeSRV_1		= $DnsSfbSrv1
		SkypeSRV_2		= $DnsSfbSrv2
		MDM_1			= $DnsMdm1
		MDM_2			= $DnsMdm2
		#DkimEnabled	= $_.Enabled
		#DkimStatus		= $_.Status
	}
	$Report.Add($ReportLine)
}

<# Export results to? #>
$Report | Export-Csv -Encoding ut8 -NoTypeInformation -Path "$env:USERPROFILE\Desktop\dns.txt";
#$Report | Out-GridView;
