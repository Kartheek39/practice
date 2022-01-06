output "shell_vars" {
  description = "varibles to be exported for kubectl commands"

  value = <<EOF
export AWS_REGION="${var.vpc_region}"
kops export kubecfg ${var.cluster_name}.${var.dns_zone} --state s3://${var.kops_cluster.state_bucket}
EOF
}
