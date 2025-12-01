variable "project_name" {
  type        = string
  default     = "myapp"
}

variable "location" {
  type        = string
  default     = "southeastasia"
}

variable "aks_node_count" {
  type        = number
  default     = 2
}

variable "aks_vm_size" {
  type        = string
  default     = "Standard_B4ms"
}

variable "db_admin_login" {
  type        = string
  default     = "pgadmin"
}

variable "db_admin_password" {
  type        = string
  default    = "P@ssw0rd1234"
}

variable "db_name" {
  type        = string
  default     = "appdb"
}


variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "backend_image" {
  type        = string
}

variable "frontend_image" {
  type        = string
}

variable "path_module" {
    type        = string
    default     = "./k8s"
}

variable "jwt_secret" {
  type        = string
  default     = "mysecretjwtkey"
}
variable "jwt_expire_minutes" {
  type        = number
  default     = 60
}