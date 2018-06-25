##### Dependencies
  - Ansible 2.5.1

# Important note` before execute code
 To create a snaphot specify your valeus in ansible variable
 - REGION: 
 - instance_ID
 - volume_ID
 - device_NAME
 - Snap_Description
 - Snap_Tag_Value: "{{DATE}}"
 

  
===============================================================

# How to perform Snapshot
## Note
  - Terraform code also include Ansilbe playbook to deploye Jenkins Master with updated changes if required. here is the yaml file "jenkins-upgrade-terraform/mongo-ansible-code/playbooks/jenkins-master.yml"
  - To skip Jenkins Master Upgrade ansible playbook then comment all section for moduel "jenkins-ansible-master-changes" in file "jenkins-upgrade-terraform/mongo-supporting-infra-terraform/stack-deployment/main.tf"
  - Terraform Module Path for Ansible to deploy Jenkins Master: "jenkins-upgrade-terraform/mongo-supporting-infra-terraform/modules/jenkins-master-ansible"
  
  
  

  # Deploy Terraform to build Jenkins Infrastructer without Upgrade Jenkins Master - Check above Note before perform this steps
  	- # cd jenkins-upgrade-terraform/mongo-supporting-infra-terraform/stack-deployment
  	- # terraform plan
  	- # terraform apply
  
  
  
