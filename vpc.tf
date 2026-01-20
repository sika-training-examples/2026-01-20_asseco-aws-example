module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.6.0"

  name = "eks-asseco-ondrejsika-vpc"
  cidr = "10.10.0.0/16"

  azs = [
    "eu-central-1a",
    "eu-central-1b",
    "eu-central-1c",
  ]
  private_subnets = ["10.10.0.0/24"]
  public_subnets  = ["10.10.1.0/24"]
  intra_subnets   = ["10.10.2.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }
}
