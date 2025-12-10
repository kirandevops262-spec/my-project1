resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  version  = var.cluster_version
  role_arn = var.eks_cluster_role_arn

  vpc_config {
    subnet_ids             = concat(var.public_subnets, var.private_subnets)
    endpoint_public_access = true
  }

  tags = merge(var.tags, { Name = var.cluster_name })
}

resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${var.cluster_name}-ng"
  node_role_arn   = var.eks_node_role_arn
  subnet_ids      = var.private_subnets

  scaling_config {
    desired_size = var.node_group_desired_size
    max_size     = var.node_group_max_size
    min_size     = var.node_group_min_size
  }

  instance_types = var.node_group_instance_types
  disk_size      = var.node_volume_size

  tags = merge(var.tags, { Name = "${var.cluster_name}-ng" })
}
