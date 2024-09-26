variable "server_type" {
  type        = string
  description = "Instance type"
  default     = "t3.nano"

}

variable "server_count" {
  type    = number
  default = 1

}

variable "create_igw" {
  type        = bool
  description = "Instance name"
  default     = true
}

variable "include_ipv4" {
  type    = bool
  default = true
}
