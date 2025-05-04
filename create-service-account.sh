#!/bin/bash
GCP_PROJECT="sre-practice-888"

#----------------------------------------#
#     Create terraform publisher SA      #
#----------------------------------------#
gcloud iam service-accounts create terraform-publisher \
  --project=$GCP_PROJECT \
  --display-name="Terraform Publisher" \
  --description="For deploying cloud services and editing TF state files"
# Set service account to variable
SERVICE_ACCOUNT=$(gcloud iam service-accounts list --project=$GCP_PROJECT --filter="email ~ terraform-publisher" --format="value(email)")
# Create service account key
gcloud iam service-accounts keys create terraform.json \
  --project=$GCP_PROJECT \
  --iam-account=$SERVICE_ACCOUNT
# Bind IAM role to service account
gcloud projects add-iam-policy-binding $GCP_PROJECT \
  --member=serviceAccount:$SERVICE_ACCOUNT \
  --role=roles/compute.loadBalancerAdmin
gcloud projects add-iam-policy-binding $GCP_PROJECT \
  --member=serviceAccount:$SERVICE_ACCOUNT \
  --role=roles/compute.networkAdmin
gcloud projects add-iam-policy-binding $GCP_PROJECT \
  --member=serviceAccount:$SERVICE_ACCOUNT \
  --role=roles/compute.securityAdmin
gcloud projects add-iam-policy-binding $GCP_PROJECT \
  --member=serviceAccount:$SERVICE_ACCOUNT \
  --role=roles/container.admin
gcloud projects add-iam-policy-binding $GCP_PROJECT \
  --member=serviceAccount:$SERVICE_ACCOUNT \
  --role=roles/iam.serviceAccountUser
gcloud projects add-iam-policy-binding $GCP_PROJECT \
  --member=serviceAccount:$SERVICE_ACCOUNT \
  --role=roles/storage.admin
gcloud projects add-iam-policy-binding $GCP_PROJECT \
  --member=serviceAccount:$SERVICE_ACCOUNT \
  --role=roles/monitoring.alertPolicyEditor
gcloud projects add-iam-policy-binding $GCP_PROJECT \
  --member=serviceAccount:$SERVICE_ACCOUNT \
  --role=roles/monitoring.notificationChannelViewer

#----------------------------------------#
#      Create helmfile publisher SA      #
#----------------------------------------#
gcloud iam service-accounts create helmfile-publisher \
  --project=$GCP_PROJECT \
  --display-name="Helmfile Publisher" \
  --description="For deploying kubernetes objects to GKE cluster"
# Set service account to variable
SERVICE_ACCOUNT=$(gcloud iam service-accounts list --project=$GCP_PROJECT --filter="email ~ helmfile-publisher" --format="value(email)")
# Create service account key
gcloud iam service-accounts keys create helmfile.json \
  --project=$GCP_PROJECT \
  --iam-account=$SERVICE_ACCOUNT
# Bind IAM role to service account
gcloud projects add-iam-policy-binding $GCP_PROJECT \
  --member=serviceAccount:$SERVICE_ACCOUNT \
  --role=roles/container.admin
gcloud projects add-iam-policy-binding $GCP_PROJECT \
  --member=serviceAccount:$SERVICE_ACCOUNT \
  --role=roles/artifactregistry.reader

#----------------------------------------#
#       Create storage manager SA        #
#----------------------------------------#
gcloud iam service-accounts create storage-manager \
  --project=$GCP_PROJECT \
  --display-name="Strorage Manager" \
  --description="For manipulating Cloud Storage objects."
# Set service account to variable
SERVICE_ACCOUNT=$(gcloud iam service-accounts list --project=$GCP_PROJECT --filter="email ~ storage-manager" --format="value(email)")
# Create service account key
gcloud iam service-accounts keys create storage.json \
  --project=$GCP_PROJECT \
  --iam-account=$SERVICE_ACCOUNT
# Bind IAM role to service account
gcloud projects add-iam-policy-binding $GCP_PROJECT \
  --member=serviceAccount:$SERVICE_ACCOUNT \
  --role=roles/storage.admin

#----------------------------------------#
#        Create content pusher SA        #
#----------------------------------------#
gcloud iam service-accounts create content-pusher \
  --project=$GCP_PROJECT \
  --display-name="Content Pusher"
# Set service account to variable
SERVICE_ACCOUNT=$(gcloud iam service-accounts list --project=$GCP_PROJECT --filter="email ~ content-pusher" --format="value(email)")
# Create service account key
gcloud iam service-accounts keys create content-pusher.json \
  --project=$GCP_PROJECT \
  --iam-account=$SERVICE_ACCOUNT
# Bind IAM role to service account
gcloud projects add-iam-policy-binding $GCP_PROJECT \
  --member=serviceAccount:$SERVICE_ACCOUNT \
  --role=roles/storage.objectAdmin

#----------------------------------------#
#       Create docker registry SA        #
#----------------------------------------#
gcloud iam service-accounts create docker-registry \
  --project=$GCP_PROJECT \
  --display-name="Docker Registry"
# Set service account to variable
SERVICE_ACCOUNT=$(gcloud iam service-accounts list --project=$GCP_PROJECT --filter="email ~ docker-registry" --format="value(email)")
# Create service account key
gcloud iam service-accounts keys create docker-registry.json \
  --project=$GCP_PROJECT \
  --iam-account=$SERVICE_ACCOUNT
# Bind IAM role to service account
gcloud projects add-iam-policy-binding $GCP_PROJECT \
  --member=serviceAccount:$SERVICE_ACCOUNT \
  --role=roles/artifactregistry.repoAdmin
gcloud projects add-iam-policy-binding $GCP_PROJECT \
  --member=serviceAccount:$SERVICE_ACCOUNT \
  --role=roles/artifactregistry.serviceAgent
gcloud projects add-iam-policy-binding $GCP_PROJECT \
  --member=serviceAccount:$SERVICE_ACCOUNT \
  --role=roles/artifactregistry.writer
gcloud projects add-iam-policy-binding $GCP_PROJECT \
  --member=serviceAccount:$SERVICE_ACCOUNT \
  --role=roles/storage.objectViewer
