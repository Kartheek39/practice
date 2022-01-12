variable "vpc" {
  type = object({
    cidr = string
    public_subnets = list(string)
    private_subnets = list(string)
    rds_subnets     = list(string)
#    elasticache_subnets = list(string)
    dns_hostnames = bool
    dns_support   = bool
    tenancy       = string
  })
  description = "Map of AWS VPC settings"

  default = {
    cidr            = "172.31.0.0/16"
    public_subnets  = ["172.31.0.0/24","172.31.1.0/24"]
    private_subnets = ["172.31.3.0/24","172.31.4.0/24","172.31.5.0/24"]
    rds_subnets     = []
#    elasticache_subnets = []
    dns_hostnames   = true
    dns_support     = true
    tenancy         = "default"
  }
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "cluster_name" {
  type    = string
  default = "unitq"
}

variable "vpc_to_connect" {
  type = map
  description = "Id and cidr [vpc_id,vpc_cidr] of the vpcs to create the peering connection"
  default = {}
}