#!/bin/bash

set -xe

ResourceGroup=""
ClusterName=""
KUBECONFIG="~/.kube/${ClusterName}"

# Install the connectedk8s Azure CLI extension  
az extension add --name connectedk8s

# If you've already installed the connectedk8s extension, update the extension to the latest version
az extension update --name connectedk8s

# Get Arc-Enabled cluster ID
ARM_ID_CLUSTER=$(az connectedk8s show -n $CLUSTER_NAME -g $RESOURCE_GROUP --query id -o tsv)

# Register providers for Azure Arc-enabled Kubernetes
az connectedk8s enable-features --features cluster-connect -n $CLUSTER_NAME -g $RESOURCE_GROUP

# Service account token authentication option
kubectl create serviceaccount demo-user

# Create ClusterRoleBinding or RoleBinding to grant this service account the appropriate permissions on the cluster
kubectl create clusterrolebinding demo-user-binding --clusterrole cluster-admin --serviceaccount default:demo-user

# Create a service account token
kubectl apply -f - <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: demo-user-secret
  annotations:
    kubernetes.io/service-account.name: demo-user
type: kubernetes.io/service-account-token
EOF

TOKEN=(kubectl get secret demo-user-secret -o jsonpath='{$.data.token}' | base64 -d | sed $'s/$/\\\n/g')

# Access your cluster
az connectedk8s proxy -n $CLUSTER_NAME -g $RESOURCE_GROUP
az connectedk8s proxy -n $CLUSTER_NAME -g $RESOURCE_GROUP --token $TOKEN
kubectl get no -o wide
