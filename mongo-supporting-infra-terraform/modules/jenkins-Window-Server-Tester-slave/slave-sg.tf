/*
- jenkins-slave-sg
- All traffic in vpc is open since we do not know what all ports we may
  have to open
 */
resource "aws_security_group" "Windwos-slave-sg" {
   name = "Windows_slave_sg"
   vpc_id = "${var.mongo-vpc-id}"

   // allows traffic from the SG itself for tcp
   ingress {
       from_port = 3389
       to_port = 3389
       protocol = "tcp"
       cidr_blocks = ["0.0.0.0/0"]
   }

   ingress {
      from_port = 0
      to_port = 65535
      protocol = "udp"
      cidr_blocks = ["${var.vpc_cidr}"]
   }

   ingress {
      from_port = 0
      to_port = 65535
      protocol = "tcp"
      cidr_blocks = ["${var.vpc_cidr}"]
   }


   egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
   }
}
