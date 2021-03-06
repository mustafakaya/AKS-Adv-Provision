#!/bin/bash

#Set some variables
# Any vars with REPLACE value you need to update via direct assignment or execute the instructed CLI commands

# - Project Variables
# - Azure Subscription Information
# - Resource groups
# - Azure Monitor
# - Networking
# - Key Vault
# - API Management
# - AAD Integration
# - ACR
# - Application Gateway
# - Azure Firewall
# - AKS Cluster
# - Public IPs

### Project Variables
# Have a project code (short like 2 or 3 letters)
# I selected "cap" for crowd-analytics-platform project I worked on

PROJECT_CODE="cap"
# Set the environment that this deployment represent (dev, qa, prod,...)
ENVIRONMENT="dev"
SUBSCRIPTION_CODE="vse"

echo export PROJECT_CODE=$PROJECT_CODE >> ./aks.vars
echo export ENVIRONMENT=$ENVIRONMENT >> ./aks.vars
echo export SUBSCRIPTION_CODE="vse" >> ./aks.vars

# Prefix is a combination of project and environment
PREFIX="${ENVIRONMENT}${PROJECT_CODE}"
echo export PREFIX=$PREFIX >> ./aks.vars

# Primary location
LOCATION="westeurope"
# Location code will be used to setup multi-region resources
LOCATION_CODE="weu"
echo export LOCATION=$LOCATION >> ./aks.vars
echo export LOCATION_CODE=$LOCATION_CODE >> ./aks.vars

# Azure subscription vars
SUBSCRIPTION_ID="REPLACE"
TENANT_ID="REPLACE"
echo export SUBSCRIPTION_ID=$SUBSCRIPTION_ID >> ./aks.vars
echo export TENANT_ID=$TENANT_ID >> ./aks.vars

### Resource groups
echo export RG_AKS="${PREFIX}-aks-${SUBSCRIPTION_CODE}-${LOCATION_CODE}" >> ./aks.vars
echo export RG_AKS_NODES="${PREFIX}-aks-nodes-${SUBSCRIPTION_CODE}-${LOCATION_CODE}" >> ./aks.vars
echo export RG_INFOSEC="central-infosec-${SUBSCRIPTION_CODE}-${LOCATION_CODE}" >> ./aks.vars
echo export RG_SHARED="${PREFIX}-shared-${SUBSCRIPTION_CODE}-${LOCATION_CODE}" >> ./aks.vars
echo export RG_DEVOPS="${PREFIX}-devops-${SUBSCRIPTION_CODE}-${LOCATION_CODE}" >> ./aks.vars

### Azure Monitor
echo export SHARED_WORKSPACE_NAME="${PREFIX}-${SUBSCRIPTION_CODE}-shared-logs" >> ./aks.vars
echo export HUB_EXT_WORKSPACE_NAME="${PREFIX}-${SUBSCRIPTION_CODE}-hub-logs" >> ./aks.vars

# Creating Application Insights for each app
echo export APP_NAME="${PREFIX}-REPLACE-insights-${SUBSCRIPTION_CODE}-${LOCATION_CODE}" >> ./aks.vars

### Virtual networks
echo export PROJ_VNET_NAME="spoke-${PREFIX}-${SUBSCRIPTION_CODE}-${LOCATION_CODE}" >> ./aks.vars
echo export HUB_EXT_VNET_NAME="hub-ext-vnet-${SUBSCRIPTION_CODE}-${LOCATION_CODE}" >> ./aks.vars
# HUB_INT_VNET_NAME can be added to introduce on-premise connectivity


# AKS primary subnet
echo export AKS_SUBNET_NAME="${PREFIX}-aks" >> ./aks.vars

# AKS exposed services subnet
echo export SVC_SUBNET_NAME="${PREFIX}-svc" >> ./aks.vars

# Virutal nodes subnet (for serverless burst scaling)
echo export VN_SUBNET_NAME="${PREFIX}-vn" >> ./aks.vars

# Development API Management subnet
echo export APIM_HOSTED_SUBNET_NAME="${PREFIX}-apim-hosted" >> ./aks.vars

# Project devops/jump-box subnet
echo export PROJ_DEVOPS_AGENTS_SUBNET_NAME="${PREFIX}-devops" >> ./aks.vars

# Production/hub API Management subnet
echo export APIM_SUBNET_NAME="hub-apim" >> ./aks.vars

# Production/hub self hosted agents
echo export DEVOPS_AGENTS_SUBNET_NAME="hub-devops" >> ./aks.vars

# Application gateway subnet
echo export AGW_SUBNET_NAME="hub-agw" >> ./aks.vars

# Azure Firewall Subnet name must be AzureFirewallSubnet
echo export FW_SUBNET_NAME="AzureFirewallSubnet" >> ./aks.vars

# IP ranges for each subnet (for simplicity some are created with /24)
# Always carefully plan your network size based on expected workloads
# Sizing docs: https://docs.microsoft.com/en-us/azure/aks/configure-azure-cni

# 2046 allocated addresses (from 8.0 to 15.255)
echo export PROJ_VNET_ADDRESS_SPACE_1="10.165.8.0/21" >> ./aks.vars
# 2046 allocated addresses (from 16.0 to 23.255)
echo export PROJ_VNET_ADDRESS_SPACE_2="10.165.16.0/21" >> ./aks.vars
# Incase you need the next address space, you can use this
# echo export PROJ_VNET_ADDRESS_SPACE_3="10.165.24.0/22" >> ./aks.vars

# This /21 size would support around 60 node cluster (given that 30 pods/cluster is used)
echo export AKS_SUBNET_IP_PREFIX="10.165.8.0/21" >> ./aks.vars
echo export VN_SUBNET_IP_PREFIX="10.165.16.0/22" >> ./aks.vars
echo export SVC_SUBNET_IP_PREFIX="10.165.20.0/24" >> ./aks.vars
echo export APIM_HOSTED_SUBNET_IP_PREFIX="10.165.21.0/24" >> ./aks.vars
echo export PROJ_DEVOPS_AGENTS_SUBNET_IP_PREFIX="10.165.22.0/24" >> ./aks.vars

# 2048 allocated addresses (from 0.0 to 7.255)
echo export HUB_EXT_VNET_ADDRESS_SPACE="10.165.0.0/21" >> ./aks.vars

echo export FW_SUBNET_IP_PREFIX="10.165.1.0/24" >> ./aks.vars
echo export AGW_SUBNET_IP_PREFIX="10.165.2.0/24" >> ./aks.vars
echo export APIM_SUBNET_IP_PREFIX="10.165.3.0/24" >> ./aks.vars
echo export DEVOPS_AGENTS_SUBNET_IP_PREFIX="10.165.4.0/24" >> ./aks.vars

### Key Vault
echo export KEY_VAULT_PRIMARY="${PREFIX}-shared-${SUBSCRIPTION_CODE}-${LOCATION_CODE}" >> ./aks.vars

### API Management
echo export APIM_NAME=$PREFIX-shared-apim  >> ./aks.vars
echo export APIM_ORGANIZATION_NAME="Mohamed-Saif" >> ./aks.vars
echo export APIM_ADMIN_EMAIL="mohamed.saif@outlook.com" >> ./aks.vars
echo export APIM_SKU="Developer" >> ./aks.vars #Replace with "Premium" if you are deploying to production

### AAD Integration

# AKS Service Principal
echo export AKS_SP_NAME="${PREFIX}-aks-sp-${SUBSCRIPTION_CODE}-${LOCATION_CODE}" >> ./aks.vars
# The following will be loaded by AAD module
# AKS_SP_ID="REPLACE"
# AKS_SP_PASSWORD="REPLACE"
# echo export AKS_SP_NAME=$AKS_SP_NAME >> ./aks.vars
# echo export AKS_SP_ID=$AKS_SP_ID >> ./aks.vars
# echo export AKS_SP_PASSWORD=$AKS_SP_PASSWORD >> ./aks.vars

# AAD Enabled Cluster
SERVER_APP_ID=REPLACE
echo export SERVER_APP_ID=$SERVER_APP_ID >> ./aks.vars
SERVER_APP_SECRET=REPLACE
echo export SERVER_APP_SECRET=$SERVER_APP_SECRET >> ./aks.vars
CLIENT_APP_ID=REPLACE
echo export CLIENT_APP_ID=$CLIENT_APP_ID >> ./aks.vars

# AKS Pod Identity
PODS_MANAGED_IDENTITY_NAME="${PREFIX}-pod-identity-${SUBSCRIPTION_CODE}-${LOCATION_CODE}"
PODS_MANAGED_IDENTITY_CLIENTID=REPLACE
PODS_MANAGED_IDENTITY_ID=REPLACE
PODS_MANAGED_IDENTITY_SP_ID=REPLACE
# Saving the MSI for later use
echo export PODS_MANAGED_IDENTITY_NAME=$PODS_MANAGED_IDENTITY_NAME >> ./aks.vars
echo export PODS_MANAGED_IDENTITY_CLIENTID=$PODS_MANAGED_IDENTITY_CLIENTID >> ./aks.vars
echo export PODS_MANAGED_IDENTITY_ID=$PODS_MANAGED_IDENTITY_ID >> ./aks.vars
echo export PODS_MANAGED_IDENTITY_SP_ID=$PODS_MANAGED_IDENTITY_SP_ID >> ./aks.vars

# AGIC Managed Identity
AGIC_MANAGED_IDENTITY_NAME="${PREFIX}-agic-identity-${SUBSCRIPTION_CODE}-${LOCATION_CODE}"
echo export AGIC_MANAGED_IDENTITY_NAME=$AGIC_MANAGED_IDENTITY_NAME >> ./aks.vars
# or use Service Principal
AGIC_SP_NAME="${PREFIX}-agic-sp-${SUBSCRIPTION_CODE}-${LOCATION_CODE}"
# AGIC_SP_ID=REPLACE
# AGIC_SP_Password=REPLACE
echo export AGIC_SP_NAME=$AGIC_SP_NAME >> ./aks.vars
echo export AGIC_SP_ID=$AGIC_SP_ID >> ./aks.vars
echo export AGIC_SP_Password=$AGIC_SP_Password >> ./aks.vars

### Azure Container Registry (ACR)
echo export CONTAINER_REGISTRY_NAME="acr${PREFIX}${SUBSCRIPTION_CODE}${LOCATION_CODE}" >> ./aks.vars

### Application Gateway (AGW)
echo export AGW_NAME="${PREFIX}-agw-${SUBSCRIPTION_CODE}-${LOCATION_CODE}" >> ./aks.vars
echo export AGW_PRIVATE_IP="10.165.2.10" >> ./aks.vars
# echo export AGW_RESOURCE_ID=REPLACE >> ./aks.vars

### Azure Firewall
FW_NAME="${PREFIX}-ext-fw-${SUBSCRIPTION_CODE}-${LOCATION_CODE}"
FW_IPCONFIG_NAME=$FW_NAME-ip-config
FW_UDR=$FW_NAME-udr
FW_UDR_ROUTE_NAME=$FW_IPCONFIG_NAME-route
echo export FW_NAME=$FW_NAME >> ./aks.vars
echo export FW_IPCONFIG_NAME=$FW_IPCONFIG_NAME >> ./aks.vars
echo export FW_UDR=$FW_UDR >> ./aks.vars
echo export FW_UDR_ROUTE_NAME=$FW_UDR_ROUTE_NAME >> ./aks.vars

### AKS Cluster
AKS_CLUSTER_NAME="${PREFIX}-aks-${SUBSCRIPTION_CODE}-${LOCATION_CODE}"

# AKS version will be set at the cluster provisioning time
# AKS_VERSION=REPLACE

# Default node pool name must all small letters and not exceed 15 letters
AKS_DEFAULT_NODEPOOL="primary"

echo export AKS_CLUSTER_NAME=$AKS_CLUSTER_NAME >> ./aks.vars
echo export AKS_VERSION=$AKS_VERSION >> ./aks.vars
echo export AKS_DEFAULT_NODEPOOL=$AKS_DEFAULT_NODEPOOL >> ./aks.vars

# AKS Networking
# Make sure that all of these ranges are not overlapping to any connected network space (on Azure and otherwise)
# These addresses are lated to AKS internal operations mainly
echo export AKS_SERVICE_CIDR="10.41.0.0/16" >> ./aks.vars
echo export AKS_DNS_SERVICE_IP="10.41.0.10" >> ./aks.vars
echo export AKS_DOCKER_BRIDGE_ADDRESS="172.17.0.1/16" >> ./aks.vars
# Range to be used when using kubenet (not Azure CNI)
echo export AKS_POD_CIDR="10.244.0.0/16" >> ./aks.vars

# If you are using Windows Containers support, you need the following
WIN_USER="localwinadmin"
WIN_PASSWORD="P@ssw0rd1234"
WIN_NODEPOOL="${PREFIX}-win-np"
echo export WIN_USER=$WIN_USER >> ./aks.vars
echo export WIN_PASSWORD=$WIN_PASSWORD >> ./aks.vars
echo export WIN_NODEPOOL=$WIN_NOODEPOOL >> ./aks.vars

### Public IPs
echo export AKS_PIP_NAME="${AKS_CLUSTER_NAME}-pip" >> ./aks.vars
echo export AGW_PIP_NAME="${AGW_NAME}-pip" >> ./aks.vars
echo export FW_PIP_NAME="${FW_NAME}-pip" >> ./aks.vars

### Tags
# Saving the key/value pairs into variables
echo export TAG_ENV_DEV="Environment=DEV" >> ./aks.vars
echo export TAG_ENV_STG="Environment=STG" >> ./aks.vars
echo export TAG_ENV_QA="Environment=QA" >> ./aks.vars
echo export TAG_ENV_PROD="Environment=PROD" >> ./aks.vars
echo export TAG_ENV_DR_PROD="Environment=DR-PROD" >> ./aks.vars
echo export TAG_PROJ_CODE="Project=${PROJECT_CODE}" >> ./aks.vars
echo export TAG_PROJ_SHARED="Project=Shared-Service" >> ./aks.vars
echo export TAG_DEPT_IT="Department=IT" >> ./aks.vars
echo export TAG_STATUS_EXP="Status=Experimental" >> ./aks.vars
echo export TAG_STATUS_PILOT="Status=PILOT" >> ./aks.vars
echo export TAG_STATUS_APPROVED="Status=APPROVED" >> ./aks.vars

# Reload the .bashrc variables
source ./aks.vars

echo "Variables Scripts Execution Completed"