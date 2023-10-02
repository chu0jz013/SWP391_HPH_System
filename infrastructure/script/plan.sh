#!/bin/bash

set -a # Enable automatic exporting of variables

FILE_NAME=$1

cd ./infrastructure/gcp/main
# Excetute terraform script
terraform init -upgrade
terraform plan --out checkov_results.binary -var="file_name=$FILE_NAME"

# add prefix as branch name to specify out file
terraform show -json checkov_results.binary >checkov_results.json
