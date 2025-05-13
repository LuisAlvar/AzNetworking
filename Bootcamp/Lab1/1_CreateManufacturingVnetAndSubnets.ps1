# Variables
$resourceGroup = "ContosoResourceGroup"
$vnetName = "ManufacturingVnet"
$location = "West US 2"
$addressPrefix = "10.30.0.0/16"

# Create virutal network 
New-AzVirtualNetwork -ResourceGroupName $resourceGroup -Location $location -Name $vnetName -AddressPrefix $addressPrefix

# Define subnet
$subnetName = "ManufacturingSystemSubnet"
$subnetPrefix = "10.30.10.0/24"

# Create subnet configuration 
$subnet = New-AzVirtualNetworkSubnetConfig -Name $subnetName -AddressPrefix $subnetPrefix

# Associate subnet with the virtual network 
$vnet = Get-AzVirtualNetwork -ResourceGroupName $resourceGroup -Name $vnetName
$vnet | Set-AzVirtualNetwork -Subnet $subnet

# Verfiy virtual network 
Get-AzVirtualNetwork -ResourceGroupName $resourceGroup -Name $vnetName | Select-Object -ExpandProperty Subnets

# Define multiple subnets
$subnets = @(
    New-AzVirtualNetworkSubnetConfig -Name "SensorSubnet1" -AddressPrefix "10.30.20.0/24"
    New-AzVirtualNetworkSubnetConfig -Name "SensorSubnet2" -AddressPrefix "10.30.21.0/24"
    New-AzVirtualNetworkSubnetConfig -Name "SensorSubnet3" -AddressPrefix "10.30.22.0/24"
)

# Retrieve virtual network 
$vnet = Get-AzVirtualNetwork -ResourceGroupName $resourceGroup -Name $vnetName

# Update virtual network with new subnets
$vnet | Set-AzVirtualNetwork -Subnet $subnets

# Verfiy virtual network 
Get-AzVirtualNetwork -ResourceGroupName $resourceGroup -Name $vnetName | Select-Object -ExpandProperty Subnets