provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "cluster-kops"
    key    = "dev/terraform"
    region = "us-east-1"
  }
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

locals {
  azs                    = ["us-east-1a", "us-east-1b", "us-east-1c"]
  environment            = "test"
  kops_state_bucket_name = "cluster-kops"
  // Needs to be a FQDN
  kubernetes_cluster_name = "sample.jainankur229.xyz"
  ingress_ips             = ["10.0.0.100/32", "10.0.0.101/32"]
#  vpc_name                = "${local.environment}-vpc"

  tags = {
    environment = "${local.environment}"
    terraform   = true
  }
}

data "aws_region" "current" {}
