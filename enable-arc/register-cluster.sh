#!/bin/bash

set -xe

ResourceGroup=""
ClusterName=""
KUBECONFIG="~/.kube/${ClusterName}"

# Install the connectedk8s Azure CLI extension 
az extension add --name connectedk8s

# Register providers for Azure Arc-enabled Kubernetes
az provider register --namespace Microsoft.Kubernetes
az provider register --namespace Microsoft.KubernetesConfiguration
az provider register --namespace Microsoft.ExtendedLocation

# Connect an existing Kubernetes cluster
az connectedk8s connect --name $ClusterName --resource-group $ResourceGroup

# Verify cluster connection 
az connectedk8s list --resource-group $ResourceGroup --output table
