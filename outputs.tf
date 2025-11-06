# EKS 클러스터 엔드포인트 출력
output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

# EKS 클러스터 보안 그룹 ID 출력
output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane"
  value       = module.eks.cluster_security_group_id
}

# ECR 저장소 URL 출력
output "ecr_repository_url" {
  description = "The URL of the ECR repository"
  value       = module.ecr.repository_url
}

# Bastion PIP 출력
output "bastion_ssh_command" {
  description = "SSH command to connect (replace KEY_PATH with your pem file)"
  value       = "ssh -i ${var.bastion_key_name}.pem ubuntu@${module.bastion.bastion_public_ip}"
}

