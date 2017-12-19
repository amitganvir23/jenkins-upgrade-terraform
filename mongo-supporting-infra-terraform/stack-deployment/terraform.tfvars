/*
 Variables for deploying stack
--------------------------------
- ACM certificates have to pre-exist
*/

// General
region            = "us-west-1"
vpc_name          = "mongo-jenkins-Infra"
vpc_cidr          = "172.168.0.0/16"
proxy_cidr        = "172.2.*"
environment       = "support"

/* Classes of instances - has to change based on environment
- Please choose between the following only
- [dev|qa|stage]
*/

# AZs are combintation of az length + subnet cidrs
public_sub_cidr   = ["172.168.0.0/24","172.168.1.0/24"]
private_sub_cidr  = ["172.168.3.0/24","172.168.4.0/24"]
azs               = ["us-west-1b","us-west-1c"]


// For public facing sites and ELBs
// remove 223.176.0.0/16 after a week
// remove 34.207.47.108 after demo
control_cidr = "202.174.0.0/32,139.5.0.0/16,34.193.0.0/16,115.249.0.0/16,159.182.0.0/16,42.111.0.0/16,192.251.0.0/16,54.82.34.148/32,27.5.0.0/16,52.14.5.155/32,223.176.0.0/16,34.207.47.108/32,52.89.89.192/32,27.50.5.103/32"

// Same as vpc cidr for now
private_sub_control_cidr ="172.168.0.0/16"


//jenkins Master
jenkins_master_instance_type         = "t2.medium"
aws_key_name = "terraform-support-keys"
jenkins-master-ami = "ami-66d9dc06"

// Jenkins-slave for dynamic
jenkins_slave_sg = "jenkins-slave-sg"
slave_ami = "ami-54e1da34"
slave_tag = "JenkinsDynamicSlaves-EFS-12-DEC"

// Jenkins-external-elb
jenkins_elb_name                = "jenkins-external"
jenkins_elb_sg_name             = "jenkins-external-elb-sg"
jenkins_elb_healthy_threshold   = 10
jenkins_elb_unhealthy_threshold = 2
jenkins_elb_timeout             = 10
jenkins_elb_elb_health_target   = "TCP:8080"
jenkins_elb_interval            = "15"
// Certificate must be available in IAM or ACM and must match region being deployed in
jenkins_ssl_certificate_id      = "arn:aws:acm:us-west-1:9595136724:certificate/ce79dc73-ceb3-4eb2-8fcf-0976e7058a37"

// Jenkins saurcelab Slave
jenkins_saurcelab_instance_type	= "t2.medium"
jenkins_saurcelab_ami		= "ami-5ae6dd3a"

// Jenkins win server Slave
//jenkins_win_server_instance_type	= "t2.medium"
jenkins_win_server_instance_type	= "m4.xlarge"
jenkins_win_server_ami		= "ami-81e6dde1"
