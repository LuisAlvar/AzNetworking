# Variables
$resourceGroup = "ContosoResourceGroup"
$vnetName = "ResearchVnet"
$location = "West US 2"
$addressPrefix = "10.40.0.0/16"

# Create virutal network 
New-AzVirtualNetwork -ResourceGroupName $resourceGroup -Location $location -Name $vnetName -AddressPrefix $addressPrefix

# Define subnet
$subnetName = "ResearchSystemSubnet"
$subnetPrefix = "10.40.0.0/24"

# Create subnet configuration 
$subnet = New-AzVirtualNetworkSubnetConfig -Name $subnetName -AddressPrefix $subnetPrefix

# Associate subnet with the virtual network 
$vnet = Get-AzVirtualNetwork -ResourceGroupName $resourceGroup -Name $vnetName
$vnet | Set-AzVirtualNetwork -Subnet $subnet

# Verfiy virtual network 
Get-AzVirtualNetwork -ResourceGroupName $resourceGroup -Name $vnetName | Select-Object -ExpandProperty Subnets