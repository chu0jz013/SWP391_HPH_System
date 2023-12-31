#!/bin/bash

set -a # Enable automatic exporting of variables

FILE_NAME=$1

cd ./infrastructure/gcp/main

# Excetute terraform script
terraform destroy -var="file_name=$FILE_NAME" -auto-approve
