variable "location" {
  type = string
  default = "westus2"
}

variable "rg_name" {
  type = string
  default = "brd_rg"
}
variable "nsg_name" {
  type = string
	default = "brd_nsg"
}

variable "vn_name" {
  type = string
	default = "brd_vn"
}

variable "address_space" {
  default = ["10.0.0.0/16"]
}

variable "dns_servers" {
  default = ["10.10.10.10", "10.20.0.0"]
}

variable "subnet_names" {
	default = ["brd_subnet-01","brd_subnet-02"]
}

variable "address_prefixes" {
  default = ["10.0.1.0/24","10.0.2.0/24"]
}

variable "environment" {
	default = "prod"
}

variable "subnet_count" {
  type = number
  default = 2
}
