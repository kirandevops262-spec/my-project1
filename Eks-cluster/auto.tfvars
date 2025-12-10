aws_region = "us-east-1"

cluster_name    = "demo-eks-cluster"
cluster_version = "1.27"
vpc_cidr_block = "10.0.0.0/16"

public_subnet_cidrs = [
  "10.0.1.0/24",
  "10.0.2.0/24",
  "10.0.3.0/24"
]

private_subnet_cidrs = [
  "10.0.11.0/24",
  "10.0.12.0/24",
  "10.0.13.0/24"
]

database_subnet_cidrs = [
  "10.0.21.0/24",
  "10.0.22.0/24"
]

node_group_instance_types = ["t3.medium"]

node_group_min_size     = 1
node_group_desired_size = 2
node_group_max_size     = 3

node_volume_size = 20

tags = {
  Owner = "terraform"
  Env   = "dev"
}
