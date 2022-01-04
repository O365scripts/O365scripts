<#
.SYNOPSIS
M365 Compliance Search Action (aka Seek & Destroy)
(link)
.NOTES
    > Use the New-ComplianceSearchAction cmdlet to create actions for content searches in Exchange Server and in the Office 365 Security & Compliance Center.
    > The -Purge switch specifies the action for the content search is to remove items that match the search criteria.
    > This action isn't intended to clean up user mailboxes. A maximum of 10 items per mailbox can be removed at one time.
    > Because the capability to search for and remove messages is intended to be an incident-response tool, this limit helps ensure that messages are quickly removed from mailboxes.
    > You can remove items from a maximum of 50,000 mailboxes using a single content search.
    > To remove items from more than 50,000 mailboxes, you'll have to create separate content searches.
    > The -PurgeType parameter specifies how to remove items when the action is Purge.
    > Unindexed items aren't removed from mailboxes when you use this switch.
    > Valid values are "SoftDelete" or "HardDelete".
    > If multiple passes are required then would need to calculate and sotre how many items to delete that were initially present that matched the initial content search to know how many passes are required?
.LINK
Reference:
https://docs.microsoft.com/en-us/powershell/module/exchange/get-compliancesearch?view=exchange-ps
https://docs.microsoft.com/en-us/powershell/module/exchange/set-compliancesearch?view=exchange-ps
https://docs.microsoft.com/en-us/powershell/module/exchange/remove-compliancesearch?view=exchange-ps
https://docs.microsoft.com/en-us/powershell/module/exchange/new-compliancesearchaction?view=exchange-ps
https://docs.microsoft.com/en-us/powershell/module/exchange/get-compliancesearchaction?view=exchange-ps
https://docs.microsoft.com/en-us/powershell/module/exchange/remove-compliancesearchaction?view=exchange-ps
#>

<# Start by creating the content search query using the interface or by using New-ComplianceSearch. #>
#ew-ComplianceSearch;

<# Purge or delete items? #>
$purge_type = "SoftDelete vs HardDelete";
#$purge_type = "SoftDelete", "HardDelete" | Out-GridView -OutputMode Single -PassThru;

<# Specify the search name manually vs interactively? #>
$search_name = "Test Search";
$search_name = Get-ComplianceSearch | Out-GridView -Title "Which compliance search do you want to use?" -PassThru;

<# Warning: Remove items based on the specified content search query and delete/purge up to 10 items per mailbox per pass. #>
New-ComplianceSearchAction -SearchName $search_name -Purge -PurgeType $purge_type -Confirm:$false;

<# Remove the search action so it can be started to delete more result items. #>
$purge_name = "${search_name}_Purge";
Remove-ComplianceSearchAction $purge_name -Confirm:$false

<# Verify search action has been removed. #>
Get-ComplianceSearchAction $purge_name;
