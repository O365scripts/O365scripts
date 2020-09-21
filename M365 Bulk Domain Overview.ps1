<#
.SYNOPSIS
M365 DNS Domain Bulk Overview

.NOTES
 +Use your prefered method to feed value(s) to $ListDomains by manual input or from a txt/csv file.

.LINK
https://docs.microsoft.com/en-us/powershell/module/dnsclient/resolve-dnsname?view=win10-ps
https://docs.microsoft.com/en-us/microsoft-365/admin/get-help-with-domains/create-dns-records-at-any-dns-hosting-provider?view=o365-worldwide
#>

<# Specify manually the list of domains to lookup the DNS records? #>
#$ListDomains = "";
$ListDomains = "hotmail.com", "google.com", "yahoo.com";
<# Prompt directly for domain to lookup? #>
#$ListDomains = Read-Host -Prompt "Enter domain";
<# Pull domains from text or CSV? #>
#$ListDomains = Get-Content -Path "$env:USERPROFILE\Desktop\List of Domains.txt";
#$ListDomains = Import-Csv "$env:USERPROFILE\Desktop\List of Domains.csv";

<# Build a report of the general DNS and Office 365-related records of selected domains. #>
$Report = [System.Collections.Generic.List[Object]]::new();
$ListDomains | % {
	<# #>
	$DnsNS		= (Resolve-Dnsname -ErrorAction SilentlyContinue -Type "NS" -Name $_).ForEach({$_[0].NameHost}) | Out-String;
	$DnsA		= (Resolve-Dnsname -ErrorAction SilentlyContinue -Type "A" -Name $_).ForEach({$_[0].IPAddress}) | Out-String;
	$DnsMx		= (Resolve-DnsName -ErrorAction SilentlyContinue -Type "MX" -Name $_ | sort Preference).ForEach({"$($_.NameExchange) [$($_.Preference)]"}) | Out-String;
	$DnsTxt		= (Resolve-Dnsname -ErrorAction SilentlyContinue -Type "TXT" -Name $_).ForEach({$_[0].Strings}) | Out-String;
	$DnsAuto	= (Resolve-DnsName -ErrorAction SilentlyContinue -Type "CNAME" -Name "autodiscover.$_").NameHost;
	$DnsDkim1	= (Resolve-DnsName -ErrorAction SilentlyContinue -Type "CNAME" -Name "selector1._domainkey.$_").NameHost;
	$DnsDkim2	= (Resolve-DnsName -ErrorAction SilentlyContinue -Type "CNAME" -Name "selector2._domainkey.$_").NameHost;
	$DnsSfb1	= (Resolve-Dnsname -ErrorAction SilentlyContinue -Type "CNAME" -Name "lyncdiscover.$_").NameHost;
	$DnsSfb2	= (Resolve-Dnsname -ErrorAction SilentlyContinue -Type "CNAME" -Name "sip.$_").NameHost;
	$DnsSfbSrv1	= (Resolve-DnsName -ErrorAction SilentlyContinue -Type "SRV" -Name "_sip._tls.$_").ForEach({if ("" -ne $_.NameTarget) {"$($_[0].NameTarget):$($_[0].Port)"}}) | Out-String;
	$DnsSfbSrv2	= (Resolve-DnsName -ErrorAction SilentlyContinue -Type "SRV" -Name "_sipfederationtls._tcp.$_").ForEach({if ("" -ne $_.NameTarget) {"$($_[0].NameTarget):$($_[0].Port)"}}) | Out-String;
	$DnsMdm1 	= (Resolve-Dnsname -ErrorAction SilentlyContinue -Type "CNAME" -Name "enterpriseregistration.$_").NameHost;
	$DnsMdm2 	= (Resolve-Dnsname -ErrorAction SilentlyContinue -Type "CNAME" -Name "enterpriseenrollment.$_").NameHost;
	$DnsSoa 	= (Resolve-Dnsname -ErrorAction SilentlyContinue -Type "CNAME" -Name "$_").NameAdministrator;

	$ReportLine = [PSCustomObject] @{
		Domain			= $_
		NS			= $DnsNS
		A			= $DnsA
		MX			= $DnsMx
		TXT			= $DnsTxt
		Autodiscover		= $DnsAuto
		DKIM_1			= $DnsDkim1
		DKIM_2			= $DnsDkim2
		SkypeCNAME_1		= $DnsSfb1
		SkypeCNAME_2		= $DnsSfb2
		SkypeSRV_1		= $DnsSfbSrv1
		SkypeSRV_2		= $DnsSfbSrv2
		MDM_1			= $DnsMdm1
		MDM_2			= $DnsMdm2
		SOA			= $DnsSoa
	}
	$Report.Add($ReportLine)
}

<# Export results.  #>
$Report | Export-Csv -Encoding ut8 -NoTypeInformation -Path "$env:USERPROFILE\Desktop\export.csv";
#$Report | Out-GridView;
#$Report | Format-List;
