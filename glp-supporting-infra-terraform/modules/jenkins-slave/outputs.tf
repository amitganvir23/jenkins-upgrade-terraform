output "jenkins_slave_sg_id" {
   value = "${aws_security_group.jenkins-slave-sg.id}"
}

output "slave_iam_arn" {
  value = "${aws_iam_instance_profile.jenkins_slave_profile.arn}"
}

output "slave_iam_name" {
  value = "${aws_iam_instance_profile.jenkins_slave_profile.name}"
}
