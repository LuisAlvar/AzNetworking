# Variables
$resourceGroup = "ContosoResourceGroup"
$vnetName = "CoreServicesVnet"
$location = "West US 2"
$addressPrefix = "10.20.0.0/16"

# Create virutal network 
New-AzVirtualNetwork -ResourceGroupName $resourceGroup -Location $location -Name $vnetName -AddressPrefix $addressPrefix

# Define subnet
$subnetName = "GatewaySubnet"
$subnetPrefix = "10.20.0.0/27"

# Create subnet configuration 
$subnet = New-AzVirtualNetworkSubnetConfig -Name $subnetName -AddressPrefix $subnetPrefix

# Associate subnet with the virtual network 
$vnet = Get-AzVirtualNetwork -ResourceGroupName $resourceGroup -Name $vnetName
$vnet | Set-AzVirtualNetwork -Subnet $subnet

# Verfiy virtual network 
Get-AzVirtualNetwork -ResourceGroupName $resourceGroup -Name $vnetName | Select-Object -ExpandProperty Subnets

# Define multiple subnets
$subnets = @(
    New-AzVirtualNetworkSubnetConfig -Name "SharedServicesSubnet"   -AddressPrefix "10.20.10.0/24"
    New-AzVirtualNetworkSubnetConfig -Name "DatabaseSubnet"         -AddressPrefix "10.20.20.0/24"
    New-AzVirtualNetworkSubnetConfig -Name "PublicWebServiceSubnet" -AddressPrefix "10.20.30.0/24"
)

# Retrieve virtual network 
$vnet = Get-AzVirtualNetwork -ResourceGroupName $resourceGroup -Name $vnetName

# Update virtual network with new subnets
$vnet | Set-AzVirtualNetwork -Subnet $subnets

# Verfiy virtual network 
Get-AzVirtualNetwork -ResourceGroupName $resourceGroup -Name $vnetName | Select-Object -ExpandProperty Subnets

Write-Output "Virtual Network and Subnets Created Successfully!"