#!/bin/bash

# Set variables
RESOURCE_GROUP="ContosoResourceGroup"
DNS_ZONE_NAME="contoso"
LOCATION="westus2"  # Private DNS Zones are global

# Create the Private DNS Zone
az network private-dns zone create --resource-group $RESOURCE_GROUP --name $DNS_ZONE_NAME

# Define an array of Virtual Networks to link
VNET_NAMES=("CoreServicesVnet" "ManufacturingVnet" "ResearchVnet")

# Loop through each Virtual Network and create a link
for VNET_NAME in "${VNET_NAMES[@]}"; do
    VNET_ID=$(az network vnet show --resource-group $RESOURCE_GROUP --name $VNET_NAME --query id --output tsv)

    if [ -n "$VNET_ID" ]; then
        LINK_NAME="${VNET_NAME}link"

        az network private-dns link vnet create \
            --resource-group $RESOURCE_GROUP \
            --zone-name $DNS_ZONE_NAME \
            --name $LINK_NAME \
            --virtual-network $VNET_ID \
            --registration-enabled true

        echo "Linked $VNET_NAME to $DNS_ZONE_NAME"
    else
        echo "Virtual Network $VNET_NAME not found!"
    fi
done

# Verify DNS Zone and Links
az network private-dns zone show --resource-group $RESOURCE_GROUP --name $DNS_ZONE_NAME
az network private-dns link vnet list --resource-group $RESOURCE_GROUP --zone-name $DNS_ZONE_NAME