# Set variables
$resourceGroup = "ContosoResourceGroup"
$dnsZoneName = "contoso"
$location = "westus2"  # Azure Private DNS zones are global resources

# Create the Private DNS Zone
New-AzPrivateDnsZone -ResourceGroupName $resourceGroup -Name $dnsZoneName

# Define Virtual Networks to link
$vnetNames = @("CoreServicesVnet", "ManufacturingVnet", "ResearchVnet")

# Loop through each Virtual Network and create a link
foreach ($vnetName in $vnetNames) {
    $vnet = Get-AzVirtualNetwork -ResourceGroupName $resourceGroup -Name $vnetName

    if ($vnet) {
        $linkName = "$vnetNamelink"

        New-AzPrivateDnsZoneVirtualNetworkLink -ResourceGroupName $resourceGroup `
            -ZoneName $dnsZoneName `
            -Name $linkName `
            -VirtualNetworkId $vnet.Id `
            -EnableRegistration
        
        Write-Output "Linked $vnetName to $dnsZoneName"
    } else {
        Write-Output "Virtual Network $vnetName not found!"
    }
}

# Verify DNS Zone and Links
Get-AzPrivateDnsZone -ResourceGroupName $resourceGroup -Name $dnsZoneName
Get-AzPrivateDnsZoneVirtualNetworkLink -ResourceGroupName $resourceGroup -ZoneName $dnsZoneName