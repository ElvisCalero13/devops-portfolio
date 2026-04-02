terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.38"
    }
  }
}

terraform {
  backend "s3" {
    bucket       = "devops-portfolio-terraform-state-375394803225-ap-southeast-2-an"
    key          = "project-1-cicd/dev/terraform.tfstate"
    region       = "ap-southeast-2"
    encrypt      = true
    use_lockfile = true
  }
}
