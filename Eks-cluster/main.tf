provider "aws" {
  region = var.aws_region
}

# VPC module
module "vpc_eks" {
  source                = "./vpc"
  cluster_name          = var.cluster_name
  vpc_cidr_block        = var.vpc_cidr_block
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
  database_subnet_cidrs = var.database_subnet_cidrs
  tags                  = var.tags
}

# IAM module (creates roles & policies)¯
module "iam" {
  source = "./iam"

  cluster_name = var.cluster_name
  tags         = var.tags
}

# EKS module
module "eks" {
  source = "./eks"

  cluster_name         = var.cluster_name
  cluster_version      = var.cluster_version
  vpc_id               = module.vpc.vpc_id
  public_subnets       = module.vpc.public_subnets
  private_subnets      = module.vpc.private_subnets
  eks_cluster_role_arn = module.iam.eks_cluster_role_arn
  eks_node_role_arn    = module.iam.eks_node_role_arn

  node_group_instance_types = var.node_group_instance_types
  node_group_min_size       = var.node_group_min_size
  node_group_desired_size   = var.node_group_desired_size
  node_group_max_size       = var.node_group_max_size
  node_volume_size          = var.node_volume_size
  tags                      = var.tags
}
