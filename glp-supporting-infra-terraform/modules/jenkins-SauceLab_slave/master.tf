resource "aws_instance" "jenkins-saurcelab-slave" {
    ami                         = "${var.jenkins_saurcelab_ami}"
    instance_type               = "${var.jenkins_saurcelab_instance_type}"
    key_name                    = "${var.aws_key_name}"
    vpc_security_group_ids      = ["${var.jenkins_slave_sg_id}"]
    #count                      = "${length(var.public_sub_cidr)}"
    #user_data                  = "${data.template_file.userdata-jenkins.rendered}"
    subnet_id                   = "${var.pub_sub_id}"
    associate_public_ip_address = true
    source_dest_check           = false
    // Implicit dependency
    iam_instance_profile        = "${var.slave_iam_name}"
    root_block_device {
      volume_type = "gp2"
      volume_size = 80
      delete_on_termination = true
      //delete_on_termination = false
        }
     volume_tags = {
                Name = "SauceLab-slave-volume"
                }

    tags = {
      Name        = "saucelab_slave"
      Environment = "${var.environment}"
      Stack       = "Supporting-mongo"
    }

}
