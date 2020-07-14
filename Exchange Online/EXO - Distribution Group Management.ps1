<#
.SYNOPSIS
.NOTES
.LINK
#>


<# Full Distribution Group Membership Overview. #>
$report = @();
$list_dg = Get-DistributionGroup -ResultSize Unlimited;
$count_dg = $groups.Count;
$i = 1;
$list_dg | % {
    Write-Progress -Activity "Exporting list of members from $_" -Status "$i out of $count_dg distribution groups.";
    $group = $_;
    Get-DistributionGroupMember -Identity $group.Name -ResultSize Unlimited | ForEach-Object {
        $member = $_
        $report += New-Object PSObject -Property @{
            GroupDisplayName    = $group.DisplayName
            GroupPrimarySmtp    = $group.PrimarySmtpAddress
            MemberDisplayName   = $member.DisplayName
            MemberPrimarySmtp   = $member.PrimarySMTPAddress
            MemberRecipientType = $member.RecipientType
            }
        }
    $i++
    };
$report | Out-GridView;

<# Export results to CSV file. #>
$path_csvout = "$env:USERPROFILE\Desktop\list_dgmembers.csv"
$report | Export-Csv -Path $path_csvout -NoTypeInformation -Force;
