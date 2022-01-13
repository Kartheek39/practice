module "dev_vpc" {
  source             = "terraform-aws-modules/vpc/aws"
  version            = "1.46.0"
  name               = "${local.vpc_name}"
  cidr               = "172.31.0.0/16"
  azs                = ["${local.azs}"]
  private_subnets    = ["172.31.1.0/24", "172.31.2.0/24", "172.31.3.0/24"]
  public_subnets     = ["172.31.4.0/24", "172.31.5.0/24", "172.31.6.0/24"]
  enable_nat_gateway = true

  tags = {
    // This is so kops knows that the VPC resources can be used for k8s
    "kubernetes.io/cluster/${local.kubernetes_cluster_name}" = "shared"
    "terraform"                                              = true
    "environment"                                            = "${local.environment}"
  }

  // Tags required by k8s to launch services on the right subnets
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = true
  }

  public_subnet_tags = {
    "kubernetes.io/role/elb" = true
  }
}
