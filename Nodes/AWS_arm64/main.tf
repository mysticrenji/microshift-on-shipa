module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name                   = "microshift"
  ami                    = "ami-0358b31fd020c4812"
  instance_type          = "a1.large"
  key_name               = "microshift"
  monitoring             = true
  vpc_security_group_ids = ["microshift-security-group"]
  subnet_id              = module.vpc.private_subnets[0]
  

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
  depends_on = [module.security_group]
}