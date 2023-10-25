#!/bin/bash

#if you catch the error "ValueError: allow_broker=True is only supported in PublicClientApplication", use command: az config unset core.allow_broker

az login
echo "Create s3 bucket if not exists"
read -p "Who are you: " creator
read -p "Enter project name (no capitalize letter): " prj
read -p "Enter environment: " environment
read -p "Enter location: " location
read -p "Enter Blob storage Terraform bucket name (no capitalize letter): " blobst

cd ../envs/${environment}
rg_name="${prj}-${environment}-RG"
az group create  --name "${rg_name}" --location "${location}" --tags Project=${prj} Environment=${environment} Creator=${creator}

az storage account create --name "${blobst}" --resource-group "${rg_name}" --location "${location}" --sku Standard_LRS
az storage container create -n "${prj}-${environment}-terraform-backend" --account-name "${blobst}"
# az storage container set-permission -n "${prj}-${environment}-terraform-backend" --public-access off
# sed -i "s/default = \"unsed-name\"/default = \"$prj\"/" variables.tf
# sed -i "s/default = \"unsed-creator\"/default = \"$creator\"/" variables.tf
# sed -i "s/default = \"unsed-env\"/default = \"$environment\"/" variables.tf
# sed -i "s/default = \"unsed-rg_name\"/default = \"$rg_name\"/" variables.tf
# sed -i "s/default = \"unsed-rg_location\"/default = \"$location\"/" variables.tf

# # Update Terraform Backend
echo "Updating terraform file..."


terraform init \
    -backend-config="resource_group_name=${prj}-${environment}-RG" \
    -backend-config="storage_account_name=${blobst}" \
    -backend-config="container_name=${prj}-${environment}-terraform-backend" \
    -backend-config="key=prod.terraform.tfstate" \
