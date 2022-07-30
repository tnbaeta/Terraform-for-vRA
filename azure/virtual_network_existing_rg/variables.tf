variable "location" {
  type = string
  description = "Região"
  default = "eastus"
}

variable "rg_name" {
  type = string
  description = "Resource Group Name"
  default = "brd_rg"
}
variable "nsg_name" {
  type = string
  description = "Network Security Group Name"
	default = "brd_nsg"
}

variable "vn_name" {
  type = string
  description = "Virtual Network Name"
	default = "brd_vn"
}

variable "address_space" {
  description = "Address Space"
  default = ["10.0.0.0/16"]
}

variable "dns_servers" {
  description = "DNS Servers"
  default = ["10.10.10.10", "10.20.0.0"]
}

variable "subnet_names" {
  description = "Subnet Names"
	default = ["brd_subnet-01","brd_subnet-02"]
}

variable "address_prefixes" {
  description = "Address Prefixes"
  default = ["10.0.1.0/24","10.0.2.0/24"]
}

variable "environment" {
  description = "Environment"
	default = "prod"
}

variable "subnet_count" {
  type = number
  description = "Number of Subnets"
  default = 2
}
