variable "location" {
  type        = string
  description = "Digite o nome da região em que deseja criar o Grupo de Recursos"
  default     = "eastus"
}

variable "rg_name" {
  type        = string
  description = "Digite o nome do Grupo de Recursos"
  default     = "vra_rg"
}

