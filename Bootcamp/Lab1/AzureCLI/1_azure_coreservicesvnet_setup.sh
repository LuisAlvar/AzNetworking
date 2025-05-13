#!/bin/bash

# Set variables
RESOURCE_GROUP="ContosoResourceGroup"
LOCATION="westus2"
VNET_NAME="CoreServicesVnet"
ADDRESS_PREFIX="10.20.0.0/16"

# Create the resource group if it doesn't exist
az group create --name $RESOURCE_GROUP --location $LOCATION

# Create the virtual network
az network vnet create \
  --resource-group $RESOURCE_GROUP \
  --name $VNET_NAME \
  --location $LOCATION \
  --address-prefixes $ADDRESS_PREFIX

# Define an array of subnet names and address prefixes
declare -A SUBNETS=(
    ["GatewaySubnet"]="10.20.0.0/27"
    ["SharedServicesSubnet"]="10.20.10.0/24"
    ["DatabaseSubnet"]="10.20.20.0/24"
    ["PublicWebServiceSubnet"]="10.20.30.0/24"
)

# Create each subnet
for SUBNET_NAME in "${!SUBNETS[@]}"; do
    az network vnet subnet create \
      --resource-group $RESOURCE_GROUP \
      --vnet-name $VNET_NAME \
      --name $SUBNET_NAME \
      --address-prefix "${SUBNETS[$SUBNET_NAME]}"
done

# Verify the network and subnets
echo "Virtual Network and Subnets Created Successfully!"
az network vnet show --resource-group $RESOURCE_GROUP --name $VNET_NAME --query subnets


# azure_coreservicesvnet_setup.sh
# first time run chmod +x azure_coreservicesvnet_setup.sh
# Execute ./azure_coreservices_setup.sh