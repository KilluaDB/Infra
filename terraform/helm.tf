
resource "helm_release" "aws_lbc" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"
  version    = "1.8.1"

  set = [{
    name  = "clusterName"
    value = module.eks.cluster_name
    },
    {
    name  = "serviceAccount.create"
    value = "true"
    },
    {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
    },
    {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.alb_controller_irsa.iam_role_arn
    },
    {
    name  = "region"
    value = var.aws_region
    },
    {
    name  = "vpcId"
    value = module.vpc.vpc_id
    }
  ]
  depends_on = [module.eks]
}

resource "helm_release" "cnpg" {
  name       = "cloudnative-pg"
  repository = "https://cloudnative-pg.github.io/charts"
  chart      = "cloudnative-pg"
  namespace  = "cnpg-system"
  version    = "0.21.0"

  create_namespace = true

  depends_on = [module.eks]
}


resource "helm_release" "mongodb_operator" {
  name       = "community-operator"
  repository = "https://mongodb.github.io/helm-charts"
  chart      = "community-operator"
  namespace  = "mongodb-operator"
  version    = "0.10.0"

  create_namespace = true

  set =[{
    name  = "operator.watchNamespace"
    value = "default"
  }
  ]
  depends_on = [module.eks]
}
