##############################################
# EKS Cluster Module
##############################################
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnets

  # EKS API endpoint 공개
  cluster_endpoint_public_access = true

  # 기본 노드그룹 설정
  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64"
    instance_types = ["t3.medium"]
  }

  # 노드 그룹 정의
  eks_managed_node_groups = var.node_groups

##############################################
# aws-auth ConfigMap 관리 설정
##############################################
  manage_aws_auth_configmap = true

  # 사용자 매핑 (필요 시)
  aws_auth_users = var.aws_auth_users

  # Bastion Role 자동 등록
  aws_auth_roles = concat(
    var.aws_auth_roles,
    [
      {
        rolearn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.cluster_name}-bastion-role"
        username = "bastion"
        groups   = ["system:masters"]
      }
    ]
  )
}

##############################################
# 현재 계정 정보 (동적 account_id)
##############################################
data "aws_caller_identity" "current" {}

