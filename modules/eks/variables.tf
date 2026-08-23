variable "project_name" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}
variable "node_instance_type" {
  type    = string
  default = "t3.small"
}

variable "desired_size" {
  type    = number
  default = 6
}

variable "max_size" {
  type    = number
  default = 6
}

variable "min_size" {
  type    = number
  default = 5
}
