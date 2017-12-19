/*
   Variables for bastion
*/

//variable "keypair_public_key" {}
variable "mongo-vpc-id" {}
variable "region" {}
variable "pub_sub_id" {}
variable "aws_key_name" {}
variable "proxy_cidr" {}
variable "environment" {}
variable "vpc_cidr" {}
variable "dependency_id" {
  default = ""
}

variable "public_sub_cidr" {
     default = []
}

variable "control_cidr" {
}

variable "jenkins_saurcelab_instance_type" {}
variable "jenkins_saurcelab_ami" {}
variable "jenkins_slave_sg_id" {}
variable "slave_iam_name" {}
