<#
.SYNOPSIS
.NOTES
.LINK
https://docs.microsoft.com/en-us/microsoft-365/admin/get-help-with-domains/create-dns-records-at-any-dns-hosting-provider?view=o365-worldwide
https://docs.microsoft.com/en-us/powershell/module/dnsclient/resolve-dnsname?view=win10-ps
.EXAMPLE
Get-M365DomainDnsOverview;
Get-M365DomainDnsOverview "microsoft.com";
Get-M365DomainDnsOverview "hotmail.com" -OutputMode File;
#>

function Get-Timestamp {Get-Date -Format "yyyyMMddHHmmss"}


function Get-M365DomainDnsOverview {
	[CmdletBinding()] Param ($Domain=$null, $OutputMode="List");
	Begin {
		If ($null -eq $Domain) {
			Write-Host -Fore Red "MICROSOFT 365 DNS LOOKUP";
			$Domain = Read-Host -Prompt "Enter the domain name to lookup M365 related DNS records";
		}
	}
	Process {
		if ($Domain -is [string] -and ($Domain).Length -gt 0) {
			$Domain = ($Domain).Trim();
			$DnsNS		= (Resolve-Dnsname -ErrorAction SilentlyContinue -Type "NS" -Name $Domain).ForEach({$_[0].NameHost}) | Out-String;
			$DnsA		= (Resolve-Dnsname -ErrorAction SilentlyContinue -Type "A" -Name $Domain).ForEach({$_[0].IPAddress}) | Out-String;
			$DnsMx		= (Resolve-DnsName -ErrorAction SilentlyContinue -Type "MX" -Name $Domain | sort Preference).ForEach({if ($null -ne $($_.NameExchange)) {"$($_.NameExchange) [$($_.Preference)]"}}) | Out-String;
			$DnsTxt		= (Resolve-Dnsname -ErrorAction SilentlyContinue -Type "TXT" -Name $Domain).ForEach({$_[0].Strings}) | Out-String;
			$DnsAuto	= (Resolve-DnsName -ErrorAction SilentlyContinue -Type "CNAME" -Name "autodiscover.$Domain").NameHost;
			$DnsDkim1	= (Resolve-DnsName -ErrorAction SilentlyContinue -Type "CNAME" -Name "selector1._domainkey.$Domain").NameHost;
			$DnsDkim2	= (Resolve-DnsName -ErrorAction SilentlyContinue -Type "CNAME" -Name "selector2._domainkey.$Domain").NameHost;
			$DnsSfb1	= (Resolve-Dnsname -ErrorAction SilentlyContinue -Type "CNAME" -Name "lyncdiscover.$Domain").NameHost;
			$DnsSfb2	= (Resolve-Dnsname -ErrorAction SilentlyContinue -Type "CNAME" -Name "sip.$Domain").NameHost;
			$DnsSfbSrv1 = (Resolve-DnsName -ErrorAction SilentlyContinue -Type "SRV" -Name "_sip._tls.$Domain").ForEach({if ($null -ne $_.NameTarget) {"$($_[0].NameTarget):$($_[0].Port)"}}) | Out-String;
			$DnsSfbSrv2 = (Resolve-DnsName -ErrorAction SilentlyContinue -Type "SRV" -Name "_sipfederationtls._tcp.$Domain").ForEach({if ($null -ne $_.NameTarget) {"$($_[0].NameTarget):$($_[0].Port)"}}) | Out-String;
			$DnsMdm1 	= (Resolve-Dnsname -ErrorAction SilentlyContinue -Type "CNAME" -Name "enterpriseregistration.$Domain").NameHost;
			$DnsMdm2 	= (Resolve-Dnsname -ErrorAction SilentlyContinue -Type "CNAME" -Name "enterpriseenrollment.$Domain").NameHost;
			$DnsSoa 	= (Resolve-Dnsname -ErrorAction SilentlyContinue -Type "CNAME" -Name "$Domain").NameAdministrator;
			$Report = [System.Collections.Generic.List[Object]]::new();
			$ReportLine = [PSCustomObject] @{
				Domain			= $Domain
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
				SOA				= $DnsSoa
				#DkimEnabled	= $_.Enabled
				#DkimStatus		= $_.Status
			}
			$Report.Add($ReportLine);
			if ($OutputMode -eq "List") {
				Write-Host -Fore Red "MICROSOFT 365 DNS LOOKUP";
				Write-Host -Fore Yellow -NoNewline "Domain: "; Write-Host $Domain;
				Write-Host -Fore Green "DNS results";
				$Report; # | Format-List;
			}
			if ($OutputMode -eq "File") {$Report | Out-File -FilePath "$PathOut\Get-M365DomainDnsOverview_$((Get-Timestamp)).txt" -Encoding utf8;}
		}
		else {Write-Host -Fore Yellow "Nothing to lookup, closing.";}
	}
}
