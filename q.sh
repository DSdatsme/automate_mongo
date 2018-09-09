PROJECT=''
ZONE='us-east1-b'
INSTANCE_NAME="b-instance"
DISK_NAME="bdisk"
DATABASE_NAME='darshitDB'
sudo apt-get install dirmngr 
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
echo "deb http://repo.mongodb.org/apt/debian stretch/mongodb-org/4.0 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
sudo apt-get update
sudo apt-get install -y mongodb-org
sudo touch /mnt/yes.txt
gsutil cp /mnt/yes.txt gs://darshit-source
a=1
while [ "$a" != "0" ];
do
gsutil -q stat gs://darshit-source/yes1.txt
a=$?
done
#formatting disks so that it can be mounted
sudo mkfs.ext4 -m 0 -F -E lazy_itable_init=0,lazy_journal_init=0,discard /dev/sdb
#creating mount target
sudo mkdir /mnt/new
sudo mount -o discard,defaults /dev/disk/by-id/google-persistent-disk-1 /mnt/new
sudo mkdir /mnt/new/data
sudo gsutil cp gs://darshit-source/enron.json /mnt/new/data/

#start the mongo service
sudo service mongod start

#importing the json file in mongodb
mongoimport --db $DATABASE_NAME --file /mnt/new/data/enron.json