<#
.SYNOPSIS
Connect to M365 Commerce
https://github.com/O365scripts/O365scripts/blob/master/Connection/O365ConnectCommerce.ps1

.NOTES

.LINK
https://learn.microsoft.com/microsoft-365/commerce/subscriptions/manage-self-service-purchases-admins
https://learn.microsoft.com/microsoft-365/commerce/subscriptions/allowselfservicepurchase-powershell
#>

# Connect to Commerce PowerShell.
#Set-ExecutionPolicy RemoteSigned -Force -Confirm:$false
Install-Module MSCommerce -AllowClobber -Force -Confirm:$false
#Update-Module MSCommerce -Force -Confirm:$false
Import-Module MSCommerce
Connect-MSCommerce
