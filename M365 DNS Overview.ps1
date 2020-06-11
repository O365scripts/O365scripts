<# Interactive M365 DNS lookup v0.3 #>
$m365_exo   = 1;
$m365_teams = 1;
$m365_mdm   = 1;
do {
Clear
Write-Host -Fore Red "M365 DNS OVERVIEW";
$domain = Read-Host -Prompt "Enter domain";
if (!$domain) {exit;}
else
    {
    if ($m365_exo) {
        <# MX, CNAME, TXT #>
        $dns_mx = Resolve-DnsName -Type "MX" -Name $domain -ErrorAction SilentlyContinue | select NameExchange,Preference | sort Preference | ft;
        $dns_dkim1 = (Resolve-DnsName -Type "CNAME" -Name "selector1._domainkey.${domain}" -ErrorAction SilentlyContinue).NameHost;
        $dns_dkim2 = (Resolve-DnsName -Type "CNAME" -Name "selector2._domainkey.${domain}" -ErrorAction SilentlyContinue).NameHost;
        $dns_auto = (Resolve-DnsName -ErrorAction SilentlyContinue -Type "CNAME" -Name "autodiscover.${domain}").NameHost;
        $dns_txt = (Resolve-Dnsname -Type "TXT" -Name $domain -ErrorAction SilentlyContinue);
        #$dns_dmarc = ();
        }
    if ($m365_teams) {
        $dns_sfb1 = (Resolve-Dnsname -ErrorAction SilentlyContinue -Type "CNAME" -Name "lyncdiscover.${domain}").NameHost;
        $dns_sfb2 = (Resolve-Dnsname -ErrorAction SilentlyContinue -Type "CNAME" -Name "sip.${domain}").NameHost;
        $dns_sfbsrv1 = (Resolve-DnsName -ErrorAction SilentlyContinue -Type "SRV" -Name "_sip._tls.${domain}");
        $dns_sfbsrv2 = (Resolve-DnsName -ErrorAction SilentlyContinue -Type "SRV" -Name "_sipfederationtls._tcp.${domain}");
        }
    if ($m365_mdm) {
        $dns_mdm1 = (Resolve-Dnsname -ErrorAction SilentlyContinue -Type "CNAME" -Name "enterpriseregistration.${domain}").NameHost;
        $dns_mdm2 = (Resolve-Dnsname -ErrorAction SilentlyContinue -Type "CNAME" -Name "enterpriseenrollment.${domain}").NameHost;
        }
    }
Write-Host;
Write-Host -Fore Green "DNS results";
Write-Host -NoNewline -Fore Yellow "Autodiscover: "; Write-Host $dns_auto;
Write-Host -NoNewline -Fore Yellow "DKIM 1: "; Write-Host $dns_dkim1;
Write-Host -NoNewline -Fore Yellow "DKIM 2: "; Write-Host $dns_dkim2;
Write-Host -NoNewline -Fore Yellow "MDM 1: "; Write-Host $dns_mdm1;
Write-Host -NoNewline -Fore Yellow "MDM 2: "; Write-Host $dns_mdm2;
Write-Host -NoNewline -Fore Yellow "SFB CNAME 1: "; Write-Host $dns_sfb1;
Write-Host -NoNewline -Fore Yellow "SFB CNAME 2: "; Write-Host $dns_sfb2;
Write-Host -NoNewline -Fore Yellow "SFB SRV 1: "; $dns_sfbsrv1.NameTarget + ":" + $dns_sfbsrv1.Port
Write-Host -NoNewline -Fore Yellow "SFB SRV 2: "; $dns_sfbsrv2.NameTarget + ":" + $dns_sfbsrv2.Port
Write-Host -NoNewline -Fore Green "TXT records: "; $dns_txt;
Write-Host -NoNewline -Fore Green "MX records: "; $dns_mx;
Write-Host -Fore Red "===============";
$doitagain = Read-Host -Prompt "Do you wish to lookup another domain? <y/n>";
}
while ($doitagain -like "y*")
