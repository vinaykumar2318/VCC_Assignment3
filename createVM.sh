#!/bin/bash

# Set variables
PROJECT_ID="tactile-flash-452805-h4"  # Replace with your project ID
ZONE="us-central1-a"  # Replace with the desired zone
VM_NAME="assignment3neo"  # Replace with the desired VM name
MACHINE_TYPE="n1-standard-1"  # Replace with the desired machine type
IMAGE_FAMILY="debian-12"  # Updated to use Debian 12
IMAGE_PROJECT="debian-cloud"  # Replace with the desired image project
SERVICE_ACCOUNT_KEY_PATH="./key.json"  # Path to your service account key JSON
SERVICE_ACCOUNT="assignment3neo@tactile-flash-452805-h4.iam.gserviceaccount.com"  # Service account email

# Authenticate using the service account key
gcloud auth activate-service-account --key-file="$SERVICE_ACCOUNT_KEY_PATH" --quiet

# Set the project
gcloud config set project "$PROJECT_ID" --quiet

# Create the VM instance
gcloud compute instances create "$VM_NAME" \
    --zone="$ZONE" \
    --machine-type="$MACHINE_TYPE" \
    --image-family="$IMAGE_FAMILY" \
    --image-project="$IMAGE_PROJECT" \
    --service-account="$SERVICE_ACCOUNT" \
    --scopes="https://www.googleapis.com/auth/cloud-platform" \
    --quiet

# Optionally, check the VM instance status
gcloud compute instances describe "$VM_NAME" --zone="$ZONE" --quiet
