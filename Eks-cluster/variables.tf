variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version for EKS control plane"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

variable "database_subnet_cidrs" {
  description = "CIDR blocks for database subnets"
  type        = list(string)
}

variable "node_group_instance_types" {
  description = "Instance types for node group"
  type        = list(string)
}

variable "node_group_min_size" {
  description = "Minimum number of nodes"
  type        = number
}

variable "node_group_desired_size" {
  description = "Desired number of nodes"
  type        = number
}

variable "node_group_max_size" {
  description = "Maximum number of nodes"
  type        = number
}

variable "node_volume_size" {
  description = "Node volume size in GB"
  type        = number
}

variable "tags" {
  description = "Additional resource tags"
  type        = map(string)
}
