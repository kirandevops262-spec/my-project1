variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "eks_cluster_role_arn" {
  type = string
}

variable "eks_node_role_arn" {
  type = string
}

variable "node_group_instance_types" {
  type = list(string)
}

variable "node_group_min_size" {
  type = number
}

variable "node_group_desired_size" {
  type = number
}

variable "node_group_max_size" {
  type = number
}

variable "node_volume_size" {
  type = number
}

variable "tags" {
  type = map(string)
}
