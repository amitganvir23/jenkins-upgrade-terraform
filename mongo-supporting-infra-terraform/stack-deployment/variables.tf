/*
   Variables for all modules
*/


// VPC
variable "region" {}
variable "vpc_cidr" {}
//variable "aws_key_path" {}
//variable "aws_key_name" {}
//variable "keypair_public_key" {}
variable "vpc_name" {}
variable "environment" {}
variable "private_sub_control_cidr" {}
variable "control_cidr" {}
variable "proxy_cidr" {}

// Generic
variable "azs" {
    default = []
}

//jenkins
variable "aws_key_name" {}
variable "jenkins-master-ami" {}
variable "jenkins_master_instance_type" {}

variable "public_sub_cidr" {
     default = []
}

variable "private_sub_cidr" {
     default = []
}


// ELB jenkins
variable "jenkins_elb_name" {}
variable "jenkins_elb_sg_name" {}
variable "jenkins_elb_healthy_threshold" {}
variable "jenkins_elb_unhealthy_threshold" {}
variable "jenkins_elb_timeout" {}
variable "jenkins_elb_elb_health_target" {}
variable "jenkins_elb_interval" {}
variable "jenkins_ssl_certificate_id" {}

// Jenkins Dynamic slave
variable "jenkins_slave_sg" {}
variable "slave_ami" {}
variable "slave_tag" {}

// Jenkins saurcelab slave
variable "jenkins_saurcelab_instance_type" {}
variable "jenkins_saurcelab_ami" {}

// Jenkins win_server slave
variable "jenkins_win_server_instance_type" {}
variable "jenkins_win_server_ami" {}
