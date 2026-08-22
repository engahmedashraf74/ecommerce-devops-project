module "vpc" {
  source = "./modules/vpc"

  project_name = var.project_name
  vpc_cidr     = var.vpc_cidr

  public_subnet_1_cidr = var.public_subnet_1_cidr
  public_subnet_2_cidr = var.public_subnet_2_cidr

  private_subnet_1_cidr = var.private_subnet_1_cidr
  private_subnet_2_cidr = var.private_subnet_2_cidr

  az_1 = var.az_1
  az_2 = var.az_2
}
module "eks" {
  source = "./modules/eks"

  project_name       = var.project_name
  private_subnet_ids = module.vpc.private_subnet_ids
}
