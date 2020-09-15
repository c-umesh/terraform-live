terraform {
  backend "s3" {
    bucket = "umesh-terraform-backend-tf-state1"
    key = "Terraform_Project_A/Stage/compute/terraform.tfstate"
    region = "ap-south-1"
  }
}

module "webserver_cluster" {
  source = "../../../Modules/services/webserver-cluster"
  cluster_name = "websrvr-stage"
  min_size = 1
  max_size = 2
  instance_type = "t2.micro"
}
