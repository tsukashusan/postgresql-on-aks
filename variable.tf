variable "region" {
    type    = string
    default = "japaneast"
}

variable "resourcegroupname" {
    type    = string
    default = "_prefix_netappk8s"
}

variable "virtualnetworkname" {
    type    = string
    default = "kubernetesvnet"  
}
# https://docs.microsoft.com/ja-jp/azure/aks/configure-azure-cni#prerequisites (cannot use 169.254.0.0/16,172.30.0.0/16,172.31.0.0/16,192.0.2.0/24 )
variable "networkaddress" {
    type    = list(string)
    default = ["192.168.128.0/17"]  
}

variable "k8ssubnet" {
    type    = list(string)
    default = ["192.168.128.0/22"]
}

variable "netappsubnet" {
    type    = list(string)
    default = ["192.168.255.0/24"]  
}

variable "aksname" {
    type    = string
    default = "_prefix_k8s"
}

variable "netappname" {
    type    = string
    default = "_prefix_netapp"
}

variable "aksnodepoolname" {
    type    = string
    default = "akspool"
}

variable "aksnodepoolvmsize" {
    type    = string
    default = "Standard_DS2_v2"
}

variable "aksnodepoolnodecount" {
    type    = string
    default = "1"
}
variable "client_id" {
    type    = string
    default = "_clientid_"
}
variable "client_secret" {
    type = string
    default = "_clientsecret_"
}
variable "ssh_public_key" {
    type = string
    default = "_publickey_"
}
variable "log_analytics_workspace_name" {
    type    = string
    default = "_prefix_akslognalytics"
}
variable "log_analytics_workspace_sku" {
    type    = string
    default = "PerGB2018"
}
variable "aks-identity" {
    type    = string
    default = "user_assigned_identity_id"
}
variable "aksaddon-oms-enable" {
    type    = string
    default = "true"
}

variable "netapp-account-name" {
    type    = string
    default = "_prefix_netapp"
}

variable "netapp-pool-name" {
    type    = string
    default = "_prefix_netapp"
}

variable "netapp-pool-service_level" {
    type    = string
    default = "Standard" 
}

variable "netapp-size_in_tb" {
    type    = string
    default = "4" 
}

variable "netapp-volume-service_level" {
    type    = string
    default = "Standard" 
}

variable "volume-protocols" {
    type    = list(string)
    default = ["NFSv4.1"]
}
variable "volume_path" {
    type    = string
    default = "_volumepath_" 
}
variable "storage_quota_in_gb" {
    type    = string
    default = "100" 
}

variable "container_registry_name" {
    type = string
    default = "_prefix_k8s4acr"
}

variable "container_registry_sku" {
    type = string
    default = "Standard"
}