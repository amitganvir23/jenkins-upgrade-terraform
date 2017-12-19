##### Dependencies

  - Terraform > 0.9
  - AWS keys exported as env variables
  - Packer > 1.1.2
  - Dynamic inventory setup
  - Python > 2.7
  - Ansible

# Terraform mongo Jenkkns Upgrade
  - Terraform to deploy Supporting Infra AWS stack for Jenkins Support
  - File terraform.tfvars has containe variable values
  
========================================================================================================  

# How to perform terraform
## Note
  - Terraform code also include Ansilbe playbook to deploye Jenkins Master with updated changes if required. here is the yaml file "jenkins-upgrade-terraform/mongo-ansible-code/playbooks/jenkins-master.yml"
  - To skip Jenkins Master Upgrade ansible playbook then comment all section for moduel "jenkins-ansible-master-changes" in file "jenkins-upgrade-terraform/mongo-supporting-infra-terraform/stack-deployment/main.tf"
  - Terraform Module Path for Ansible to deploy Jenkins Master: "jenkins-upgrade-terraform/mongo-supporting-infra-terraform/modules/jenkins-master-ansible"
  
  
  

  # Deploy Terraform to build Jenkins Infrastructer without Upgrade Jenkins Master - Check above Note before perform this steps
  	- # cd jenkins-upgrade-terraform/mongo-supporting-infra-terraform/stack-deployment
  	- # terraform plan
  	- # terraform apply
  
  
  
========================================================================================================  
  
  
  # Deploye Terraform to build Jenkins Infrastructer including Upgrade Jenkins Master

  # 1) Check and set below values in terraform var file before deploy
    File Path: "jenkins-upgrade-terraform/mongo-supporting-infra-terraform/stack-deployment/terraform.tfvars"
     //jenkins Master
      aws_key_name = "terraform-support-keys"
      jenkins-master-ami = "ami-66d9dc06"
    // Jenkins-slave for dynamic
      jenkins_slave_sg = "jenkins-slave-sg"
      slave_ami = "ami-54e1da34"
      slave_tag = "JenkinsDynamicSlaves-EFS-12-DEC"
    
  # 2) Check and set below values in Ansible var file before deploy
    File Path: "jenkins-upgrade-terraform/mongo-ansible-code/playbooks/roles/jenkins_master/defaults/my_var.yml"
    // Update Jenkins Version if you want upgrade Jenkins
      jenkins_version: "2.73.3"
      jenkins_plug_url: "https://updates.jenkins-ci.org/stable-2.73/latest"
	// If Jenkins SCM repo is changed then update below variable values
	  jenkins_bucket: "/tmp/jenkins-config-bucket-1"
	  jenkins_bucket_url: "ssh://git@github.com/mongoin/mongo-scm-sync-jenkins-data-devops.git"
	// Can also plugins name if you want to install on jenkins
      jenkins_plugins:
		- ace-editor.hpi
    // Please check other variable as well if there is any required updates
    
   # 3) Download Private key in below location to run ansible play book
   - /root/terra-private-key

   # 4) Once you Done the changes on Ansible and terraform var then run below command to deploy Jenkins infra

	- # cd jenkins-upgrade-terraform/mongo-supporting-infra-terraform/stack-deployment
    - # terraform plan
    - # terraform apply
    
 ========================================================================================================   
    
 # Deploy Only Ansilbe playbook manually on Running Jenkins Master Instance - Also update values in varible
     - # ansible-playbook jenkins-upgrade-terraform/mongo-ansible-code/playbooks/jenkins-master.yml \
	 --private-key=/root/terra-private-key \
	 -i ../../mongo-ansible-code/hosts/ec2.py \
	 -e slave_subnet=subnet-f9518ca2 \
	 -e slave_sg=jenkins-slave-sg \
	 -e slave_ami=ami-54e1da34 \
	 -e slave_tag=JenkinsDynamicSlaves-EFS-12-DEC \
	 -e slave_iam=arn:aws:iam::9595136724:instance-profile/jenkins_slave_profile-support \
	 -e master_hostname=tag_Name_Jenkins_Master
    
    
========================================================================================================
    
# Creating Jenkins Master AMI using Packer
  #Before create AMI please check your Jenkins Master playbook in this dir location 'jenkins-upgrade-terraform/mongo-ansible-code/playbooks/' and update it if needed
  #No need to define values for dynamic slave so skip this part because any how terraform will apply dynamic values while deploying.
  
   	- # cd jenkins-upgrade-terraform/mongo-jenkins-packer-ami
   	- # packer build jenkins-master.json
========================================================================================================
# IMP Note: After deployment

   # By default jenkins service is diabled on OS, so you have run below command to enable and start service manually
  		- # service jenkins start
  		- # chkconfig jenkins on
    
  - # Login on Jenkins and update check or update below things
  	1) Jenkins smpt password in "Configure System"
    2) Update Amazone EC2 private key in "Configure System"
    3) jenkins AWS Secret credentials for "(Jenkins-dynamicslave-ec2-user)" in "credentials"
    4) Update Private key for "mongo.Builder (New-mongo.Builder-account)" in "credentials"
    5) Disable authentication DSL script to allow DSL in "Configure Global Security"
