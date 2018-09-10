PROJECT=''
ZONE='us-east1-b'
INSTANCE_NAME="b-instance"
DISK_NAME="bdisk"

gcloud compute instances create $INSTANCE_NAME \
--zone $ZONE \
--machine-type=n1-standard-1 \
--metadata=email=darshitkumar.suratwala@quantiphi.com,office-time=Mumbai-10,startup-script=sudo\ gsutil\ cp\ gs://darshit-source1/q.sh\ /mnt$'\n'sudo\ chmod\ \+x\ /mnt/q.sh$'\n'sudo\ bash\ /mnt/q.sh


gcloud compute disks create $DISK_NAME --zone $ZONE --type=pd-standard --size=10GB
gcloud compute instances attach-disk $INSTANCE_NAME --disk $DISK_NAME --zone $ZONE
touch yes1.txt
gsutil cp yes1.txt gs://darshit-source1
touch do_not_delete.txt
echo "$INSTANCE_NAME $ZONE $DISK_NAME"  > do_not_delete.txt
#rm yes1.txt
#gsutil rm gs://darshit-source/yes1.txt

#sudo gsutil cp gs://darshit-source/a.sh /mnt
#sudo chmod +x /mnt/a.sh
#sudo bash /mnt/a.sh
