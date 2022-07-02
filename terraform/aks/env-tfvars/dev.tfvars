#log Analytics
log_analytics_workspace_name = "laborworkspace"
location                     = "westeurope"

# Virtual Network
vnet_name                   = "labor-vnet"
network_address_space       = "192.168.0.0/16"
aks_subnet_address_prefix   = "192.168.0.0/24"
aks_subnet_address_name     = "aks"
appgw_subnet_address_prefix = "192.168.1.0/24"
appgw_subnet_address_name   = "appgw"

# AKS
aks_name           = "laborakscluster"
kubernetes_version = "1.23.5"
agent_count        = 1
vm_size            = "Standard_D2ads_v5"
ssh_public_key     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCelXjU2G+HKibWSKZeriRbj3PWUqD7oMHupR0ywusFA9NvuiUA+NxZXcMIMptdgRrvLdz76/jOU/kadyElQfFVi8iBLVL8lRQNWmxJMxh9TeZxQrwuaJTfd33j6R07baXY7Qn1rpjfzaZEIMU9r9KdSewBuLjnY1Y6siFr5IuLp+xlc/ajjO3AjTzQAn0RezYPTzzgODxlwJPwGVmSzTO5FU/eXjSo0uMBPivOcVPPznCjwI6yJWAd9iX3QQbEwLY2aFug9jiWNFnOnOad41cgOqkBOm0WQOsK1MocRuU48OklGg7oLpU4ti3yodCLS1Z2IzR7lna5rbIE+Se+HJqcviEj1/16DitYl/uGJNyuNXv2495i9PRtz5lZURvxMA41C0huvFUehRu8LqZBXenNMqKQ2EuZq9e6LnWgKQ9KwXGAHk4XP1os0q0yVJKRSvQTIaxeDHC9mPb/R5xV2wZ//AJNtJ2G/3bZNOGIjLRHh0+gQbkqjXb20DwXP5ylu9c= hsalahi@hsalahi-XPS"

# ACR
acr_name = "laboracr"

environment = "dev"
