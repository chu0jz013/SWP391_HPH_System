#!/bin/bash

set -a # Enable automatic exporting of variables

FILE_NAME=$1

cd ./jenkins/gcp/main
# Excetute terraform script
terraform init -upgrade
terraform apply -var="file_name=$FILE_NAME" -auto-approve
