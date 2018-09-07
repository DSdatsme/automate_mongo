####REQUIRED gcloud auth login and bucket access
PROJECT=''
ZONE='us-east1-b'
INSTANCE_NAME="b-instance"
DISK_NAME="bdisk"

#create instance & install MongoDB
gcloud compute instances create $INSTANCE_NAME \
--zone $ZONE \
--machine-type=n1-standard-1 \
--metadata=email=darshitkumar.suratwala@quantiphi.com,office-time=Mumbai-10,startup-script=sudo\ apt-get\ install\ dirmngr\ \&\&\ sudo\ apt-key\ adv\ --keyserver\ hkp://keyserver.ubuntu.com:80\ --recv\ 9DA31620334BD75D9DCB49F368818C72E52529D4\ \&\&\ echo\ \"deb\ http://repo.mongodb.org/apt/debian\ stretch/mongodb-org/4.0\ main\"\ \|\ sudo\ tee\ /etc/apt/sources.list.d/mongodb-org-4.0.list\ \&\&\ sudo\ apt-get\ update\ \&\&\ sudo\ apt-get\ install\ -y\ mongodb-org

gcloud compute ssh --zone $ZONE $INSTANCE_NAME --command 'mkdir /mnt/okay'
###################disk attaching
#disk attach
gcloud compute disks create $DISK_NAME --zone $ZONE --type=pd-standard --size=10GB
gcloud compute instances attach-disk $INSTANCE_NAME --disk $DISK_NAME --zone $ZONE

#formatting disks so that it can be mounted
sudo mkfs.ext4 -m 0 -F -E lazy_itable_init=0,lazy_journal_init=0,discard /dev/sdb
#creating mount target
sudo mkdir -p /mnt/new_vol
sudo mount -o discard,defaults /dev/disk/by-id/google-persistent-disk-1 /mnt/new_vol

sudo mkdir /mnt/new_vol/data
sudo gsutil cp gs://darshit-source/enron.json /mnt/new_vol/data/


touch do_not_delete.txt
echo "$INSTANCE_NAME $ZONE $DISK_NAME"  > do_not_delete.txt
