
variable "aws_region" {
  description = "AWS region where all resources will be created."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Short name used as a prefix for all resource names."
  type        = string
  default     = "dbaas"
}

variable "environment" {
  description = "Deployment environment (dev / staging / prod)."
  type        = string
  default     = "prod"
}


variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of AZs to use (must be ≥ 2 for EKS). Leave empty to auto-select."
  type        = list(string)
  default     = []
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets (one per AZ). Worker nodes + RDS live here."
  type        = list(string)
  default     = ["10.0.0.0/19", "10.0.32.0/19", "10.0.64.0/19"]
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets (one per AZ). NAT gateways + ALB live here."
  type        = list(string)
  default     = ["10.0.96.0/19", "10.0.128.0/19", "10.0.160.0/19"]
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS control plane."
  type        = string
  default     = "1.32"
}

variable "node_instance_type" {
  description = "EC2 instance type for the default managed node group."
  type        = string
  default     = "t3.medium"
}

variable "node_min_size" {
  description = "Minimum number of nodes in the default node group."
  type        = number
  default     = 1
}

variable "node_max_size" {
  description = "Maximum number of nodes in the default node group."
  type        = number
  default     = 5
}

variable "node_desired_size" {
  description = "Initial/desired number of nodes in the default node group."
  type        = number
  default     = 2
}

variable "node_disk_size" {
  description = "Root EBS disk size (GiB) per node."
  type        = number
  default     = 50
}


variable "ecr_image_retention_count" {
  description = "Number of tagged images to keep in ECR before lifecycle rules prune older ones."
  type        = number
  default     = 10
}


variable "meta_db_name" {
  description = "PostgreSQL database name for the meta-database (CloudNativePG Cluster)."
  type        = string
  default     = "dbaas"
}

variable "meta_db_owner" {
  description = "PostgreSQL role that owns the meta-database. CNPG will create this user and generate a secret named meta-db-app."
  type        = string
  default     = "dbaas"
}

variable "meta_db_instances" {
  description = "Number of PostgreSQL instances in the CloudNativePG Cluster (1 = primary only, 3 = primary + 2 replicas)."
  type        = number
  default     = 1
}

variable "meta_db_storage_gb" {
  description = "PVC size (GiB) for each CloudNativePG instance."
  type        = number
  default     = 10
}

variable "meta_db_pg_version" {
  description = "PostgreSQL major version for the CloudNativePG Cluster."
  type        = string
  default     = "16"
}


variable "google_redirect_url" {
  description = "OAuth redirect URL registered in Google Cloud Console (must match the ALB/domain)."
  type        = string
  default     = "https://api.yourdomain.com/api/v1/auth/google/callback"
}

variable "app_hostname" {
  description = "Public hostname for the backend API (used in ALB Ingress)."
  type        = string
  default     = "api.yourdomain.com"
}
