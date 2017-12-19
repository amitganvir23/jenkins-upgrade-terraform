/*
-----------------------------------------------------------------
- This deploys entire application stack
- Environment variable will control the naming convention
- Setup creds and region via env variables
- For more details: https://www.terraform.io/docs/providers/aws
-----------------------------------------------------------------
Notes:
 - control_cidr changes for different modules
 - Instance class also changes for different modules
 - Bastion should be minimum t2.medium as it would be executing config scripts
 - Default security group is added where traffic is supposed to flow between VPC
 */

/********************************************************************************/
provider "aws" {
  region = "${var.region}"
}


/****
/********************************************************************************/


resource "aws_key_pair" "aws-terra-keypair" {
  key_name = "${var.aws_key_name}"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD4Y80108e92JiHofnbStYc+CQVGlIMQtjMIPIctfBCSgHJdA/x82gfE6bB9zHsoMKVivR3GK3Lmf21ci/x4fH4hYDjUrDSyVJjt5U0sC339ZmEIOB/TKA01b6ATPza0flJadfhZ0m/PKf//7ryF9vcdQB0lNOLu25q9xaVY1ttVF2AdZNWoWDFh5l1fQyCYuRGo36+Z8PWqZKnVAZ6SZQ6JDeCl+6O8C/MlDLizRPETbg5PSsGy3PbAy6SV+IkdvYAIhSKkhVf221edhhIq8fKY/M2hiBRNIjwGaAvvIjBnX1a0T6RmMNCmgDvxMSa72gugEGi6/j0PD4n57wry3f9 root@amit-server"
}

module "mongo-vpc" {
   source                   = "../modules/vpc"
   azs                      = "${var.azs}"
   vpc_cidr                 = "${var.vpc_cidr}"
   public_sub_cidr          = "${var.public_sub_cidr}"
   private_sub_cidr         = "${var.private_sub_cidr}"
   enable_dns_hostnames     = true
   vpc_name                 = "${var.vpc_name}-${var.environment}"
   environment              = "${var.environment}"
}


module "jenkins-master" {
   source                = "../modules/jenkins-master"
   public_sub_cidr       = "${var.public_sub_cidr}"
   mongo-vpc-id            = "${module.mongo-vpc.vpc_id}"
   pub_sub_id            = "${module.mongo-vpc.aws_pub_subnet_id[0]}"
   region                = "${var.region}"
   jenkins_master_instance_type = "${var.jenkins_master_instance_type}"
   jenkins-master-ami    = "${var.jenkins-master-ami}"
   //keypair_public_key    = "${var.keypair_public_key}"
   //aws_key_name          = "${var.aws_key_name}"
   aws_key_name          = "${var.aws_key_name}"
   vpc_cidr              = "${var.vpc_cidr}"
   control_cidr          = "${var.control_cidr}"
   proxy_cidr            = "${var.proxy_cidr}"
   environment           = "${var.environment}"
}

module "jenkins-dynamic-slave" {
   source                = "../modules/jenkins-slave"
   mongo-vpc-id            = "${module.mongo-vpc.vpc_id}"
   vpc_cidr              = "${var.vpc_cidr}"
   jenkins_slave_sg	 = "${var.jenkins_slave_sg}"
   environment         = "${var.environment}"
}


module "jenkins-external-elb" {
   source              = "../modules/elb-jenkins"
   vpc_id              = "${module.mongo-vpc.vpc_id}"
   subnets             = "${module.mongo-vpc.aws_pub_subnet_id}"
   elb_is_internal     = "false"
   jenkins_master_id   = "${module.jenkins-master.jenkins_master_id}"
   elb_name            = "${var.jenkins_elb_name}-${var.environment}"
   elb_control_cidr    = "${var.control_cidr}"
   elb_sg_name         = "${var.jenkins_elb_sg_name}"
   healthy_threshold   = "${var.jenkins_elb_healthy_threshold}"
   unhealthy_threshold = "${var.jenkins_elb_unhealthy_threshold}"
   timeout             = "${var.jenkins_elb_timeout}"
   elb_health_target   = "${var.jenkins_elb_elb_health_target}"
   interval            = "${var.jenkins_elb_interval}"
   ssl_certificate_id  = "${var.jenkins_ssl_certificate_id}"
   environment         = "${var.environment}"
}


module "jenkins-saurcelab-slave" {
   source                		= "../modules/jenkins-SauceLab_slave"
   region                		= "${var.region}"
   jenkins_saurcelab_ami    		= "${var.jenkins_saurcelab_ami}"
   jenkins_slave_sg_id	 		= "${module.jenkins-dynamic-slave.jenkins_slave_sg_id}"
   jenkins_saurcelab_instance_type	= "${var.jenkins_saurcelab_instance_type}"
   slave_iam_name	 		= "${module.jenkins-dynamic-slave.slave_iam_name}"
   public_sub_cidr       		= "${var.public_sub_cidr}"
   mongo-vpc-id            		= "${module.mongo-vpc.vpc_id}"
   pub_sub_id            		= "${module.mongo-vpc.aws_pub_subnet_id[0]}"
   aws_key_name          		= "${var.aws_key_name}"
   vpc_cidr             		= "${var.vpc_cidr}"
   control_cidr         		= "${var.control_cidr}"
   proxy_cidr            		= "${var.proxy_cidr}"
   environment          		= "${var.environment}"
}

module "jenkins-Window-Server-Tester-slave" {
   source                		= "../modules/jenkins-Window-Server-Tester-slave"
   region                		= "${var.region}"
   jenkins_win_server_ami    		= "${var.jenkins_win_server_ami}"
   jenkins_win_server_instance_type	= "${var.jenkins_win_server_instance_type}"
   public_sub_cidr       		= "${var.public_sub_cidr}"
   mongo-vpc-id            		= "${module.mongo-vpc.vpc_id}"
   pub_sub_id            		= "${module.mongo-vpc.aws_pub_subnet_id[0]}"
   aws_key_name          		= "${var.aws_key_name}"
   vpc_cidr             		= "${var.vpc_cidr}"
   control_cidr         		= "${var.control_cidr}"
   proxy_cidr            		= "${var.proxy_cidr}"
   environment          		= "${var.environment}"
}

module "jenkins-ansible-master-changes" {
   source                = "../modules/jenkins-master-ansible"
   pub_sub_id            = "${module.mongo-vpc.aws_pub_subnet_id[0]}"
   jenkins_slave_sg	 = "${var.jenkins_slave_sg}"
   slave_ami		 = "${var.slave_ami}"
   slave_tag		 = "${var.slave_tag}"
   slave_iam		 = "${module.jenkins-dynamic-slave.slave_iam_arn}"
}
