# automate_mongo

this repo is to automate the backup for mongodb server

there are three important files in this repo
startup.sh, startup2.sh & q.sh

startup.sh
this will create a GCP instance and tell that instance to download "q.sh" from the bucket and run it.
after that it will create a disk and mount it to a new instance.

q.sh
this file will be present at a bucket and it will be downloaded by a startup script present in the newly created instance(here b-instamce).
the file installs mongo-db and downloads the data from a given bucket source to the newly created external disk.
After that it loads the data to mongo server.

startup2.sh
this script detaches the external disk and and then creates a snapshot of the main boot disk of instance(here b-instance).
then it deletes (b-instance).
it then creates a bootable disk from snapshot and then a new instance(here new-instance) is created using newly created bootable disk.
and lastly it restarts the mongo server which is mentioned in the startup script.

