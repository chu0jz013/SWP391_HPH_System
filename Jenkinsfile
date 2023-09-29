pipeline {
    agent any

    environment {
        // GCP Creds
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout your Terraform code repository (e.g., Git, SVN, etc.)
                checkout scm
            }
        }

        stage('Install Terraform') {
            steps {
                // Install Terraform (e.g., using tfenv or any other method)
                sh 'tfenv install ${TERRAFORM_VERSION}'
                sh 'tfenv use ${TERRAFORM_VERSION}'
            }
        }

        stage('Terraform Init') {
            steps {
                // Initialize Terraform workspace
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                // Create a Terraform plan
                sh 'terraform plan -out=tfplan'
            }
        }

        stage('Terraform Apply') {
            steps {
                // Apply Terraform changes
                input message: 'Deploy infrastructure?', ok: 'Deploy'
                sh 'terraform apply -auto-approve tfplan'
            }
        }

        stage('Checkov Scan') {
            steps {
                // Install Checkov
                sh 'pip install checkov'

                // Run Checkov scan on the Terraform code
                sh 'checkov -d .'
            }
        }

        stage('Terraform Destroy') {
            steps {
                // Destroy the infrastructure (optional)
                input message: 'Destroy infrastructure?', ok: 'Destroy'
                sh 'terraform destroy -auto-approve'
            }
        }
    }

    post {
        success {
            // Add any post-success actions or notifications here
        }

        failure {
            // Add any post-failure actions or notifications here
        }
    }
}
