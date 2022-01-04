<#
.SYNOPSIS
.NOTES
.LINK
https://docs.microsoft.com/en-us/powershell/module/msonline/remove-msoluser?view=azureadps-1.0
https://docs.microsoft.com/en-us/office365/enterprise/powershell/delete-and-restore-user-accounts-with-office-365-powershell
#>

<# Connect to MSOL. #>
Connect-MsolService;
#Connect-MsolService -Credential $Creds;

<# WARNING: Get list of DELETED accounts and purge selected one(s) PERMANENTLY! #>
$users = Get-MsolUser -All -ReturnDeletedUsers | Select-Object Displayname,UserPrincipalName,ObjectID,WhenCreated | Out-GridView -PassThru -Title "Select which account(s) you wish to permanently remove...";
if ($null -ne $users) {
	Write-Host -Fore Red -NoNewline "WARNING: ";
	Write-Host -Fore Yellow -NoNewline "Are you certain you wish to proceed with purging the selected deleted accounts permanently? ";
	$input = Read-Host;
	if ($input -like "yes") {
		if ($users -is [array]) {
			foreach ($u in $users) {
				Write-Host -Fore Yellow -NoNewline "Purging: "; Write-Host $u.UserPrincipalName;
				Remove-MsolUser -ObjectId $u.ObjectId -RemoveFromRecycleBin -Force -WhatIf;
			}
		}
		else {
			Write-Host -Fore Yellow -NoNewline "Purging: "; Write-Host $users.UserPrincipalName;
			Remove-MsolUser -ObjectId $users.ObjectId -RemoveFromRecycleBin -Force -WhatIf;
			}
		}
	else {Write-Host "Purge cancelled.";}
	}
