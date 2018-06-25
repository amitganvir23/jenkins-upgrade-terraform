##### Dependencies
  - Ansible 2.5.1

# Important note` before execute code
 To create a snaphot specify your valeus in ansible file (snaphost.yml)
 - REGION: 
 - instance_ID
 - volume_ID
 - device_NAME
 - Snap_Description
 - Snap_Tag_Value: "{{DATE}}" (Default value specify to maintain snaphsot)
 
 To delete a snaphot specify your valeus in ansible file (snaphost.yml)
 - Tag_Value_Check: "SNAPSHOT"  (This is Default tag value and JENKINS_MASTER is default tag key for all Sanpshot to identify)
 - Max_Snapshot: 4 (Maximum snapshot can keep)

  
===============================================================

# How to perform Snapshot
  	- # cd jenkins-upgrade-terraform/backup_snapshot
  	- # ansible-playbook snaphost.yml
  
  
  
