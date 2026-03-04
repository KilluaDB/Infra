
output "cluster_name" {
  description = "EKS cluster name."
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "EKS API server endpoint."
  value       = module.eks.cluster_endpoint
}

output "cluster_version" {
  description = "Kubernetes version running on the cluster."
  value       = module.eks.cluster_version
}

output "kubeconfig_command" {
  description = "Run this command to update your local kubeconfig."
  value       = "aws eks update-kubeconfig --name ${module.eks.cluster_name} --region ${var.aws_region}"
}

output "vpc_id" {
  description = "VPC ID."
  value       = module.vpc.vpc_id
}

output "private_subnet_ids" {
  description = "Private subnet IDs."
  value       = module.vpc.private_subnets
}

output "public_subnet_ids" {
  description = "Public subnet IDs."
  value       = module.vpc.public_subnets
}


output "ecr_repository_url" {
  description = "Full ECR repository URL. Use this as the image in deployment.yaml."
  value       = aws_ecr_repository.backend_api.repository_url
}

output "docker_push_commands" {
  description = "Commands to authenticate, build, and push the Docker image."
  value       = <<-EOT
    aws ecr get-login-password --region ${var.aws_region} | \
      docker login --username AWS --password-stdin ${aws_ecr_repository.backend_api.repository_url}

    docker build -t ${aws_ecr_repository.backend_api.repository_url}:latest .
    docker push ${aws_ecr_repository.backend_api.repository_url}:latest
  EOT
}


output "meta_db_host" {
  description = "In-cluster DNS name for the CNPG primary (read-write). Use as DB_HOST in configmap.yaml."
  value       = "meta-db-rw.default.svc.cluster.local"
}

output "meta_db_app_secret" {
  description = "Name of the K8s secret CNPG creates for the app user (contains username + password)."
  value       = "meta-db-app"
}

output "meta_db_superuser_secret" {
  description = "Name of the K8s secret CNPG creates for the postgres superuser."
  value       = "meta-db-superuser"
}
