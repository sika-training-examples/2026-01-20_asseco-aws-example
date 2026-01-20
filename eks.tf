module "eks" {
  source                 = "terraform-aws-modules/eks/aws"
  version                = "21.14.0"
  name                   = "asseco-ondrejsika"
  kubernetes_version     = "1.33"
  endpoint_public_access = true

  enable_cluster_creator_admin_permissions = true

  compute_config = {
    enabled    = true
    node_pools = ["general-purpose"]
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    asseco-ondrejsika = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      instance_types = ["m6i.large"]
      ami_type       = "AL2023_x86_64_STANDARD"

      min_size = 2
      max_size = 5
      # This value is ignored after the initial creation
      # https://github.com/bryantbiggs/eks-desired-size-hack
      desired_size = 2
    }
  }
}

output "aws_eks_login_command" {
  value = "aws eks update-kubeconfig --name ${module.eks.name}"
}
