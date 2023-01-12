<#
.SYNOPSIS
Get an overview of all the common DNS records of a specific domain, including the ones related to M365.
https://github.com/O365scripts/O365scripts/blob/master/Tools/Get-M365DomainDnsOverview.ps1
https://gist.github.com/O365scripts/400ba8dbc980ae9f9bb1cb703cf00093

.NOTES
domain.com (NS A MX TXT SOA)
Mail:
  autodiscover.domain.com (CNAME)
  _dmarc.domain.com (TXT)
  selector1._domainkey.domain.com (CNAME)
  selector1._domainkey.domain.com (CNAME)
Teams/Skype:
  lyncdiscover.domain.com (CNAME A)
  sip.domain.com (CNAME A)
  _sip._tls.domain.com
  _sipfederationtls._tcp.domain.com
Intune/MDM:
  enterpriseregistration.domain.com
  enterpriseenrollment.domain.com

.LINK
https://learn.microsoft.com/microsoft-365/admin/get-help-with-domains/create-dns-records-at-any-dns-hosting-provider
https://docs.microsoft.com/powershell/module/dnsclient/resolve-dnsname

.EXAMPLE
Get-M365DomainDnsOverview
Get-M365DomainDnsOverview "microsoft.com"
Get-M365DomainDnsOverview "hotmail.com" -OutputMode File
#>

function Get-M365DomainDnsOverview {
	[CmdletBinding()] Param ($Domain=$null,$OutputMode="List",$PathOut=$null,$Server=$null);
	Begin {
		if ($null -eq $Domain) {
			Write-Host -Fore Red "MICROSOFT 365 DNS LOOKUP";
			$Domain = Read-Host -Prompt "Enter the domain name to lookup M365 related DNS records";
		}
	$ErrAct = "SilentlyContinue";
	}
	Process {
		if ($Domain -is [string] -and ($Domain).Length -gt 0) {
			$Domain = ($Domain).Trim();
			$DnsNS		= (Resolve-Dnsname -Server $Server -ErrorAction $ErrAct -Type "NS" -Name $Domain).ForEach({$_[0].NameHost}) | Out-String;
			$DnsA		= (Resolve-Dnsname -Server $Server -ErrorAction $ErrAct -Type "A" -Name $Domain).ForEach({$_[0].IPAddress}) | Out-String;
			$DnsMx		= (Resolve-Dnsname -Server $Server -ErrorAction $ErrAct -Type "MX" -Name $Domain | sort Preference).ForEach({if ($null -ne $($_.NameExchange)) {"$($_.NameExchange) [$($_.Preference)]"}}) | Out-String;
			$DnsTxt		= (Resolve-Dnsname -Server $Server -ErrorAction $ErrAct -Type "TXT" -Name $Domain).ForEach({$_[0].Strings}) | Out-String;
			$DnsDmarc	= (Resolve-Dnsname -Server $Server -ErrorAction $ErrAct -Type "TXT" -Name _dmarc.$Domain).ForEach({$_[0].Strings}) | Out-String;
			$DnsAuto	= (Resolve-Dnsname -Server $Server -ErrorAction $ErrAct -Type "CNAME" -Name "autodiscover.$Domain").NameHost;
			$DnsDkim1	= (Resolve-Dnsname -Server $Server -ErrorAction $ErrAct -Type "CNAME" -Name "selector1._domainkey.$Domain").NameHost;
			$DnsDkim2	= (Resolve-Dnsname -Server $Server -ErrorAction $ErrAct -Type "CNAME" -Name "selector2._domainkey.$Domain").NameHost;
			$DnsSfbLync	= (Resolve-Dnsname -Server $Server -ErrorAction $ErrAct -Type "CNAME" -Name "lyncdiscover.$Domain").NameHost;
			$DnsSfbLyncA= (Resolve-Dnsname -Server $Server -ErrorAction $ErrAct -Type "A" -Name "lyncdiscover.$Domain").ForEach({$_[0].IPAddress}) | Out-String;
			$DnsSfbSip = (Resolve-Dnsname -Server $Server -ErrorAction $ErrAct -Type "CNAME" -Name "sip.$Domain").NameHost;
			$DnsSfbSipA= (Resolve-Dnsname -Server $Server -ErrorAction $ErrAct -Type "A" -Name "sip.$Domain").ForEach({$_[0].IPAddress}) | Out-String;
			$DnsSfbSipSrv = (Resolve-Dnsname -Server $Server -ErrorAction $ErrAct -Type "SRV" -Name "_sip._tls.$Domain").ForEach({if ($null -ne $_.NameTarget) {"$($_[0].NameTarget):$($_[0].Port)"}}) | Out-String;
			$DnsSfbSipFedSrv = (Resolve-Dnsname -Server $Server -ErrorAction $ErrAct -Type "SRV" -Name "_sipfederationtls._tcp.$Domain").ForEach({if ($null -ne $_.NameTarget) {"$($_[0].NameTarget):$($_[0].Port)"}}) | Out-String;
			$DnsMdm1 	= (Resolve-Dnsname -Server $Server -ErrorAction $ErrAct -Type "CNAME" -Name "enterpriseregistration.$Domain").NameHost;
			$DnsMdm2 	= (Resolve-Dnsname -Server $Server -ErrorAction $ErrAct -Type "CNAME" -Name "enterpriseenrollment.$Domain").NameHost;
			$DnsSoa 	= (Resolve-Dnsname -Server $Server -ErrorAction $ErrAct -Type "CNAME" -Name "$Domain").NameAdministrator;
			$Report = [System.Collections.Generic.List[Object]]::new();
			$ReportLine = [PSCustomObject] @{
				Domain			= $Domain
				NS				= $DnsNS
				A				= $DnsA
				MX				= $DnsMx
				TXT				= $DnsTxt
				DMARC			= $DnsDmarc
				Autodiscover	= $DnsAuto
				DKIM1			= $DnsDkim1
				DKIM2			= $DnsDkim2
				SkypeLyncdiscover = $DnsSfbLync
				SkypeLyncdiscoverA = $DnsSfbLyncA
				SkypeSip		= $DnsSfbSip
				SkypeSipA		= $DnsSfbSipA
				SkypeSipSRV		= $DnsSfbSipSrv
				SkypeSipFedSRV	= $DnsSfbSipFedSrv
				MDM1			= $DnsMdm1
				MDM2			= $DnsMdm2
				SOA				= $DnsSoa
			}
			$Report.Add($ReportLine);
			if ($OutputMode -eq "List") {
				#Write-Host -Fore Red "MICROSOFT 365 DNS LOOKUP";
				Write-Host -Fore Yellow -NoNewline "Domain: "; Write-Host $Domain;
				Write-Host -Fore Green "DNS results";
				$Report; # | Format-List;
			}
			if ($OutputMode -eq "File") {$Report | Out-File -FilePath "$PathOut\Get-M365DomainDnsOverview_$((Get-Date -Format "yyyyMMddHHmmss")).txt" -Encoding utf8;}
		}
		else {Write-Host -Fore Yellow "Nothing to lookup, closing.";}
	}
}
