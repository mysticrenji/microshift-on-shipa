module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "microshift-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-west-2a", "us-west-2b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway     = true
  enable_vpn_gateway     = true
  one_nat_gateway_per_az = false


  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "microshift-security-group"
  description = "Security group for Microshift cluster"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["10.10.0.0/16"]
  ingress_rules       = ["https-443-tcp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      description = "HTTP"
      cidr_blocks = "0.0.0.0/16"
    },
  ]
}