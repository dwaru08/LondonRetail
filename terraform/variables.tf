variable "username" {
  type = list(string)
  default = ["Ben","Mani","Nneka"]
}

variable "environment" {
  type = string
  default = "purple_beard"
}

variable "region" {
  type = string
  default = "eu-west-1"
}