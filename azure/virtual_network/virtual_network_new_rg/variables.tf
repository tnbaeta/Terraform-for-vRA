variable "location" {
  type = string
  default = "westus2"
}

variable "rg_name" {
  type = string
  default = "brd_rg"
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

variable "environment" {
	default = "prod"
}

variable "subnet" {
  type = list(object({
    name = string
    address = list(string)
    }))
  default = [
    {
      name = "brd-1"
      address = ["addr-1"]
    }
  ]
}
