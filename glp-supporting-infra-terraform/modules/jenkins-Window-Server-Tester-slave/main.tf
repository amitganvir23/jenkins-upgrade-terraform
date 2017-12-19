resource "aws_instance" "jenkins-win_server-slave" {
    ami                         = "${var.jenkins_win_server_ami}"
    instance_type               = "${var.jenkins_win_server_instance_type}"
    key_name                    = "${var.aws_key_name}"
    vpc_security_group_ids      = ["${aws_security_group.Windwos-slave-sg.id}"]
    subnet_id                   = "${var.pub_sub_id}"
    associate_public_ip_address = true
    source_dest_check           = false
    root_block_device {
      volume_type = "gp2"
      volume_size = 60
      delete_on_termination = true
      //delete_on_termination = false
        }
     volume_tags = {
                Name = "win_server-slave-volume"
                }

    tags = {
      Name        = "win_server_slave"
      Environment = "${var.environment}"
      Stack       = "Supporting-mongo"
    }

}
