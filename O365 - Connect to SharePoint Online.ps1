<#
.SYNOPSIS
    Connecting to SharePoint Online
.NOTES
    Connect-SPOService
        You must be a SharePoint Online global administrator to run the cmdlet.
        Only a single SharePoint Online service connection is maintained from any single Windows PowerShell session.
        In other words, this is a per-organization administrator connection.
        Running the Connect-SPOService cmdlet twice implicitly disconnects the previous connection.
        The Windows PowerShell session will be set to serve the new SharePoint Online global administrator specified.
        A delegated partner administrator has to swap connections for different organizations within the same Windows PowerShell session.
.LINK
    https://docs.microsoft.com/en-us/powershell/sharepoint/sharepoint-online/connect-sharepoint-online?view=sharepoint-ps
    https://www.microsoft.com/en-us/download/details.aspx?id=35588
#>

<# Connect to SharePoint Online. #>
$me = "admin@domain.com";
$tenant = "tenantname";
Connect-SPOService -Url "https://${tenant}-admin.sharepoint.com";

<# Connect to SharePoint Online without MFA. #>
$me = "admin@tenantname.onmicrosoft.com";
$tenant = "tenantname";
$creds = Get-Credential -UserName $me -Message "Login:";
Connect-SPOService -Url "https://${tenant}-admin.sharepoint.com" -Credential $creds;

<# Clear cached credentials? #>
$creds = $null;

<# Connect to SharePoint Online without MFA or cached credentials. #>
$me = "admin@tenantname.onmicrosoft.com";
$tenant = "tenantname";
Connect-SPOService -Url "https://${tenant}-admin.sharepoint.com" -Credential (Get-Credential -UserName $me -Message "Login:");


<# Module installed? #>
Get-Module -Name Microsoft.Online.SharePoint.PowerShell -ListAvailable | Select Name,Version;

<# Install module as administrator? #>
Install-Module Microsoft.Online.SharePoint.PowerShell;

<# Install module as user? #>
Install-Module -Scope CurrentUser Microsoft.Online.SharePoint.PowerShell;
