# Cluster role
data "aws_iam_policy_document" "eks_cluster_assume" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "eks_cluster" {
  name               = "${var.cluster_name}-eks-cluster-role"
  assume_role_policy = data.aws_iam_policy_document.eks_cluster_assume.json
  tags               = var.tags
}

# Create custom policy from file and attach to cluster role
resource "aws_iam_policy" "eks_cluster_custom" {
  name   = "${var.cluster_name}-eks-cluster-policy"
  policy = file("${path.module}/policies/cluster-policy.json")
}

resource "aws_iam_role_policy_attachment" "eks_cluster_attach" {
  role       = aws_iam_role.eks_cluster.name
  policy_arn = aws_iam_policy.eks_cluster_custom.arn
}

# Node role
data "aws_iam_policy_document" "eks_node_assume" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "eks_node" {
  name               = "${var.cluster_name}-eks-node-role"
  assume_role_policy = data.aws_iam_policy_document.eks_node_assume.json
  tags               = var.tags
}

resource "aws_iam_policy" "eks_node_custom" {
  name   = "${var.cluster_name}-eks-node-policy"
  policy = file("${path.module}/policies/nodegroup-policy.json")
}

resource "aws_iam_policy" "eks_cni_custom" {
  name   = "${var.cluster_name}-eks-cni-policy"
  policy = file("${path.module}/policies/cni-policy.json")
}

resource "aws_iam_policy" "ecr_readonly_custom" {
  name   = "${var.cluster_name}-ecr-readonly-policy"
  policy = file("${path.module}/policies/ecr-readonly-policy.json")
}

resource "aws_iam_role_policy_attachment" "node_attach_worker" {
  role       = aws_iam_role.eks_node.name
  policy_arn = aws_iam_policy.eks_node_custom.arn
}

resource "aws_iam_role_policy_attachment" "node_attach_cni" {
  role       = aws_iam_role.eks_node.name
  policy_arn = aws_iam_policy.eks_cni_custom.arn
}

resource "aws_iam_role_policy_attachment" "node_attach_ecr" {
  role       = aws_iam_role.eks_node.name
  policy_arn = aws_iam_policy.ecr_readonly_custom.arn
}

# Outputs
output "eks_cluster_role_arn" {
  value = aws_iam_role.eks_cluster.arn
}

output "eks_node_role_arn" {
  value = aws_iam_role.eks_node.arn
}
