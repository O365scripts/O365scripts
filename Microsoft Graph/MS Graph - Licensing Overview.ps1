<#
#>

Connect-MgGprah;
Select-MgProfile beta;




<# Pass through each SKU to list the service plans. #>
[Array]$ListSkus = Get-MgSubscribedSku;
$ReportPlans = [System.Collections.Generic.List[Object]]::new();
ForEach ($Sku in $ListSkus) {
#	Write-Host "Current SKU:" -NoNewline; $SP.SkuPartNumber | fl;
	ForEach ($Plan in $Sku.ServicePlans) {
		Write-Host "Current Plan:" -NoNewline; $Plan | fl
		$ReportLine = [PSCustomObject][Ordered]@{
			ServicePlanId = $Plan.ServicePlanId
			ServicePlanName = $Plan.ServicePlanName
			DisplayName = $Plan.ServicePlanName	
			};
		$ReportPlans.Add($ReportLine);
		}
	}
$ReportPlans | Sort ServicePlanId -Unique | Sort ServicePlanName;

<# Subscription output. #>
$ListSkus;
$ListSkus | Select -First 1 *;
$ListSkus | Select SkuPartNumber, SkuId | Out-GridView;
$ListSkus | Export-Csv -NoTypeInformation "$env:USERPROFILE\Desktop\M365LicensingOverview.csv";

<# Service plan output. #>
$ReportPlans | Sort ServicePlanId | Format-Table -AutoSize;
$ReportPlans | Sort ServicePlanId -Unique | Sort ServicePlanName;
#$SPData | Sort ServicePlanId -Unique | Export-Csv -NoTypeInformation "$env:USERPROFILE\Desktop\M365LicensingOverview.csv";


$X = $ReportPlans | Out-GridView -PassThru;