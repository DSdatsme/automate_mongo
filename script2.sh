PROJECT="pe-training"
ZONE='us-east1-b'
INSTANCE_NAME="b-instance"
NEW_INSTANCE_NAME="new-instance"
DISK_NAME="bdisk"
DATABASE_NAME="darshit"
SNAPSHOT_NAME="snapshot"

#start the mongo service
sudo service mongo start 

#importing the json file in mongodb

mongoimport --db $DATABASE_NAME --file enron.json

sudo umount /dev/disk/by-id/google-persistent-disk-1 
gcloud compute instances detach-disk $INSTANCE_NAME --disk $DISK_NAME --zone=us-east1-b


gcloud compute  disks snapshot $DISK_NAME --zone $ZONE --snapshot-names $SNAPSHOT_NAME
gcloud compute instances delete $INSTANCE_NAME --zone $ZONE 

gcloud compute --project $PROJECT disks create $NEW_INSTANCE_NAME --size "10" --zone $ZONE --source-snapshot $SNAPSHOT_NAME --type "pd-standard"

gcloud compute instances create $NEW_INSTANCE_NAME --zone $ZONE --machine-type=n1-standard-1 --subnet default --disk=name=$NEW_INSTANCE_NAME,device-name=$NEW_INSTANCE_NAME,mode=rw,boot=yes
gcloud compute instances create instance-3 --zone=us-east1-b --machine-type=n1-standard-1 --subnet=default --disk=name=new-instance,device-name=new-instance,mode=rw,boot=yes


#####add this inside startup script of instance which uses snapshot
sudo systemctl enable mongod
sudo service mongod restart
