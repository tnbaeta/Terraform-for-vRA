variable "location" {
  type = string
  description = "Escolha a Região para criação dos recursos"
  title = "Região"
  default = "eastus"
}

variable "create_rg" {
  type = bool
  description = "Criar novo Grupo de Recursos"
  default = false
}
variable "rg_name" {
  type = string
  description = "Nome do Grupo de Recursos"
  default = "brd_rg"
}

variable "vn_name" {
  type = string
  description = "Nome da Rede Virtual"
	default = "brd_vn"
}

variable "address_space" {
  description = "Espaço de Endereço (CIDR)"
  default = ["10.0.0.0/16"]
}

variable "dns_servers" {
  description = "Servidor(es) de DNS"
  default = ["10.10.10.10", "10.20.0.0"]
}

variable "environment" {
  description = "Ambiente"
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
      address = ["10.0.1.0/24"],
      name = "brd-2"
      address = ["10.0.2.0/24"]
    }
  ]
}
