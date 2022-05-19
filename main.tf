terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.14.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "demo_instance" {
  ami = "ami-0022f774911c1d690"
  instance_type = "t2.micro"
}