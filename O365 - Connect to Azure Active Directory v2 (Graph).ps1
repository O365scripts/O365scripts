<#
.SYNOPSIS
    Connect with the Azure Active Directory PowerShell for Graph module.
.NOTES
.LINK
    https://docs.microsoft.com/en-us/powershell/azure/active-directory/install-adv2?view=azureadps-2.0
    https://docs.microsoft.com/en-us/powershell/module/azuread/connect-azuread?view=azureadps-2.0
    https://docs.microsoft.com/en-us/powershell/module/azuread/disconnect-azuread?view=azureadps-2.0
    https://docs.microsoft.com/en-us/powershell/module/azuread/?view=azureadps-2.0
#>

<# Connect to Azure AD #>
$me = "admin@tenantname.onmicrosoft.com";
Connect-AzureAD -AccountId $me;

<# Connect to Azure AD without MFA #>
    $me = "admin@tenantname.onmicrosoft.com";
$creds = Get-Credential -UserName $me -Message "Login:";
Connect-AzureAD -AccountId $me -Credential $creds;

<# Close session? #>
Disconnect-AzureAD;


<# Azure AD module installed? #>
Get-Module AzureAD -ListAvailable;

<# Install Azure as Admin or User? #>
Install-Module AzureAD -Confirm:$false -Force;
#Install-Module AzureAD -Scope "CurrentUser" -Confirm:$false -Force;

<# Update Azure module? #>
Update-Module AzureAD -Confirm:$false -Force;
#Update-Module AzureAD -Scope "CurrentUser" -Confirm:$false -Force;

<# Remove Azure module? #>
Remove-Module AzureAD -Confirm:$false -Force;
#Remove-Module AzureAD -Scope "CurrentUser" -Confirm:$false -Force;


<################################################>
<# Azure AD Preview #>

<# Preview module installed? #>
Get-Module AzureADPreview -ListAvailable;

<# Install the Azure preview module as administrator? #>
Install-Module AzureADPreview -Confirm:$false -Force;

<# Install the Azure preview module as user? #>
Install-Module AzureADPreview -Scope "CurrentUser" -Confirm:$false -Force;

<# Update Azure Preview module? #>
Update-Module AzureADPreview -Confirm:$false -Force;
#Update-Module AzureADPreview -Scope "CurrentUser" -Confirm:$false -Force;

<# Remove Azure Preview module? #>
Remove-Module AzureADPreview -Confirm:$false -Force;
#Remove-Module AzureADPreview -Scope "CurrentUser" -Confirm:$false -Force;

<# Disconnect session? #>
<# ... #>