gsutil rm gs://darshit-source/yes1.txt
gcloud compute snapshots delete snapshot
gcloud compute disks delete bdisk --zone us-east1-b
gcloud compute disks delete new-instance --zone us-east1-b

