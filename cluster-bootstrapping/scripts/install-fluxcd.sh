#!/bin/bash

set -xe

FLUX_RESOURCEGROUP="flux-demo-rg"
CLUSTER_NAME="flux-ske"
CLUSTER_CONFIG="cluster-config"
NAMESPACE="cluster-config"
CLUSTER_TYPE="connectedClusters"
SCOPE="cluster"
FLUX_REPO="https://github.com/Azure/gitops-flux2-kustomize-helm-mt"
BRANCH="main"

# Registration of your subscription with the AKS-ExtensionManager feature flag
az feature register --namespace Microsoft.ContainerService --name AKS-ExtensionManager

# Registration of the following Azure service providers. 

az provider register --namespace Microsoft.Kubernetes
az provider register --namespace Microsoft.ContainerService
az provider register --namespace Microsoft.KubernetesConfiguration

# az provider show -n Microsoft.KubernetesConfiguration -o table

# Install/Update the latest k8s-configuration and k8s-extension CLI extension packages
az extension add -n k8s-configuration
az extension add -n k8s-extension
az extension update -n k8s-configuration
az extension update -n k8s-extension
az extension list -o table

# Apply a Flux configuration
az k8s-configuration flux create \
	-g $FLUX_RESOURCEGROUP \
	-c $CLUSTER_NAME \
	-n $CLUSTER_CONFIG \
	--namespace $NAMESPACE \
	-t $CLUSTER_TYPE \
	--scope $SCOPE \
	-u $FLUX_REPO \
	--branch $BRNACH \
	--kustomization name=infra path=./infrastructure prune=true --kustomization name=apps path=./apps/staging prune=true dependsOn=["infra"]

# Show the configuration after allowing time to finish reconciliations.
az k8s-configuration flux show \
	-g $FLUX_RESOURCEGROUP \
	-c $CLUSTER_NAME \
	-n $CLUSTER_CONFIG \
	-t $CLUSTER_TYPE

# List the Flux agent, controller pods, and crds
kubectl get pods -n flux-system
kubectl get crds
