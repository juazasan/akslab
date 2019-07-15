#!/bin/bash

echo "Register Providers"
echo "Provider register: Register the Azure Kubernetes Services provider"
az provider register --namespace Microsoft.ContainerService
echo "Provider register: Register the Azure Policy provider"
az provider register --namespace Microsoft.PolicyInsights

echo "Install and upgrade azure-cli aks preview extension"
az extension add --name aks-preview
az extension update --name aks-preview

### register features

echo "Registering Preview Features...."
echo "Feature Register: Windows Nodes"
az feature register --name WindowsPreview --namespace Microsoft.ContainerService
echo "Feature Register: Limit Egress Traffic"
az feature register --name AKSLockingDownEgressPreview --namespace Microsoft.ContainerService
echo "Feature register: enables installing the Azure Policy add-on"
az feature register --namespace Microsoft.ContainerService --name AKS-AzurePolicyAutoApprove
echo "Feature register: enables the add-on to call the Azure Policy resource provider"
az feature register --namespace Microsoft.PolicyInsights --name AKS-DataplaneAutoApprove
echo "Feature Register: Cluster Autoscaler"
az feature register --namespace "Microsoft.ContainerService" --name "VMSSPreview"
echo "Feature Register: Azure Load Balancer Standard SKU"
az feature register --namespace "Microsoft.ContainerService" --name "AKSAzureStandardLoadBalancer"
echo "Feature Register: AZ"
az feature register --name AvailabilityZonePreview --namespace Microsoft.ContainerService
echo "Feature Register: Multiple-node pools"
az feature register --name MultiAgentpoolPreview --namespace Microsoft.ContainerService
echo "Feature register: Pod Security Policy"
az feature register --name PodSecurityPolicyPreview --namespace Microsoft.ContainerService
echo "Feature register: Secure access to API servers using authorized IP addresses"
az feature register --name APIServerSecurityPreview --namespace Microsoft.ContainerService

### Verify features enablement
echo "Verify Feature Enablement: Windows Nodes"
enabledFeature=$(az feature list --query "[?contains(name, 'Microsoft.ContainerService/WindowsPreview')].properties.state" -o json)
while [[ "$enabledFeature" == *"Pending"* ]]; do
    sleep 30s
    enabledFeature = $(az feature list --query "[?contains(name, 'Microsoft.ContainerService/WindowsPreview')].properties.state" -o json)
done
echo "WindowsPreview feature successfully enabled"
echo "Verify Feature Enablement: Limit Egress Traffic"
enabledFeature=$(az feature list --query "[?contains(name, 'Microsoft.ContainerService/AKSLockingDownEgressPreview')].properties.state" -o json)
while [[ "$enabledFeature" == *"Pending"* ]]; do
    sleep 30s
    enabledFeature=$(az feature list --query "[?contains(name, 'Microsoft.ContainerService/AKSLockingDownEgressPreview')].properties.state" -o json)
done
echo "AKSLockingDownEgressPreview feature successfully enabled"
echo "Verify Feature Enablement: Azure Policy add-on"
enabledFeature=$(az feature list --query "[?contains(name, 'Microsoft.ContainerService/AKS-AzurePolicyAutoApprove')].properties.state" -o json)
while [[ "$enabledFeature" == *"Pending"* ]]; do
    sleep 30s
    enabledFeature=$(az feature list --query "[?contains(name, 'Microsoft.ContainerService/AKS-AzurePolicyAutoApprove')].properties.state" -o json)
done
enabledFeature=$(az feature list --query "[?contains(name, 'Microsoft.PolicyInsights/AKS-DataplaneAutoApprove')].properties.state" -o json)
while [[ "$enabledFeature" == *"Pending"* ]]; do
    sleep 30s
    enabledFeature=$(az feature list --query "[?contains(name, 'Microsoft.PolicyInsights/AKS-DataplaneAutoApprove')].properties.state" -o json)
done
echo "AKS-AzurePolicyAutoApprove feature successfully enabled"
echo "Verify Feature Enablement: Cluster Autoscaler"
enabledFeature=$(az feature list --query "[?contains(name, 'Microsoft.ContainerService/VMSSPreview')].properties.state" -o json)
while [[ "$enabledFeature" == *"Pending"* ]]; do
    sleep 30s
    enabledFeature=$(az feature list --query "[?contains(name, 'Microsoft.ContainerService/VMSSPreview')].properties.state" -o json)
done
echo "VMSSPreview feature successfully enabled"
echo "Verify Feature Enablement: Azure Load Balancer Standard SKU"
enabledFeature=$(az feature list --query "[?contains(name, 'Microsoft.ContainerService/AKSAzureStandardLoadBalancer')].properties.state" -o json)
while [[ "$enabledFeature" == *"Pending"* ]]; do
    sleep 30s
    enabledFeature=$(az feature list --query "[?contains(name, 'Microsoft.ContainerService/AKSAzureStandardLoadBalancer')].properties.state" -o json)
done
echo "AKSAzureStandardLoadBalancer feature successfully enabled"
echo "Verify Feature Enablement: AZ"
enabledFeature=$(az feature list --query "[?contains(name, 'Microsoft.ContainerService/AvailabilityZonePreview')].properties.state" -o json)
while [[ "$enabledFeature" == *"Pending"* ]]; do
    sleep 30s
    enabledFeature=$(az feature list --query "[?contains(name, 'Microsoft.ContainerService/AvailabilityZonePreview')].properties.state" -o json)
done
echo "AvailabilityZonePreview feature successfully enabled"
echo "Verify Feature Enablement: Multiple-node pools"
enabledFeature=$(az feature list --query "[?contains(name, 'Microsoft.ContainerService/MultiAgentpoolPreview')].properties.state" -o json)
while [[ "$enabledFeature" == *"Pending"* ]]; do
    sleep 30s
    enabledFeature=$(az feature list --query "[?contains(name, 'Microsoft.ContainerService/MultiAgentpoolPreview')].properties.state" -o json)
done
echo "MultiAgentpoolPreview feature successfully enabled"
echo "Verify Feature Enablement: Pod Security Policy"
enabledFeature=$(az feature list --query "[?contains(name, 'Microsoft.ContainerService/PodSecurityPolicyPreview')].properties.state" -o json)
while [[ "$enabledFeature" == *"Pending"* ]]; do
    sleep 30s
    enabledFeature=$(az feature list --query "[?contains(name, 'Microsoft.ContainerService/PodSecurityPolicyPreview')].properties.state" -o json)
done
echo "MultiAgentpoolPreview feature successfully enabled"
echo "Verify Feature Enablement: Secure access to API servers using authorized IP addresses"
enabledFeature=$(az feature list --query "[?contains(name, 'Microsoft.ContainerService/APIServerSecurityPreview')].properties.state" -o json)
while [[ "$enabledFeature" == *"Pending"* ]]; do
    sleep 30s
    enabledFeature=$(az feature list --query "[?contains(name, 'Microsoft.ContainerService/APIServerSecurityPreview')].properties.state" -o json)
done
echo "APIServerSecurityPreview feature successfully enabled"

echo "Re-Register related providers..."
az provider register -n Microsoft.PolicyInsights
az provider register -n Microsoft.ContainerService