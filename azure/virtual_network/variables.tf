variable "location" {
  type = string
  description = "Escolha a Região para criação dos recursos"
  default = "eastus"
}

variable "create_rg" {
  type = bool
  description = "Marque a caixa de seleção para criar im novo Grupo de Recursos ou deixe desmarcada para escolher um Grupo de Recursos Existente."
  default = false
}

variable "rg_name" {
  type = string
  default = "brd_rg"
}

variable "vn_name" {
  type = string
  description = "Digite o nome da Rede Virtual"
	default = "brd_vn"
}

variable "address_space" {
  description = "Digite o espaço de endereços para a Rede Virtual no formato CIDR"
  default = ["10.0.0.0/16"]
}

variable "dns_servers" {
  description = "Adicione um ou mais servidores de DNS"
  default = ["10.10.10.10", "10.20.0.0"]
}

variable "environment" {
  description = "Escolha em que ambiente deseja criar os recursos para adição de etiquetas (tags)."
	default = "prod"
}

variable "subnet" {
  type = list(object({
    name = string
    address = list(string)
    }))
  description = "Adicione uma ou mais sub-redes em formato CIDR. As sub-redes devem estar contidas dentro do espaço de endereços configurados anteriormente."
  default = [
    {
      name = "brd-1"
      address = ["10.0.1.0/24"],
      name = "brd-2"
      address = ["10.0.2.0/24"]
    }
  ]
}
