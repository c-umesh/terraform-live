terraform {
  backend "s3" {
    bucket = "umesh-terraform-backend-tf-state1"
    key = "Terraform_Project_A/Prd/compute/terraform.tfstate"
    region = "ap-south-1"
  }
}

module "webserver_cluster" {
  source = "../../../Modules/services/webserver-cluster"
  cluster_name = "websrvr-prod"
  min_size = 1
  max_size = 5
  instance_type = "t2.micro"
}

resource "aws_autoscaling_schedule" "scale_out_business_hours" {
  autoscaling_group_name = module.webserver_cluster.asg_name
  scheduled_action_name = "scale-out-during-business-hours"
  min_size              = 2
  max_size              = 10
  desired_capacity      = 10
  recurrence            = "0 9 * * *"
}
resource "aws_autoscaling_schedule" "scale_in_at_night" {
  autoscaling_group_name = module.webserver_cluster.asg_name
  scheduled_action_name = "scale-in-at-night"
  min_size              = 2
  max_size              = 10
  desired_capacity      = 2
  recurrence            = "0 17 * * *"
}