pipeline {
    agent any

    environment {
        // GCP Creds
         TERRAFORM_VERSION = '1.5.7'
    }

    stages {
        stage('Git checkout') {
            steps {
                checkout scm
            }
        }


        stage('Install Terraform') {
            steps {
                sh 'tfenv --version'
                sh 'tfenv install ${TERRAFORM_VERSION}'
                sh 'tfenv use ${TERRAFORM_VERSION}'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'bash '
            }
        }

        stage('Terraform Apply') {
            steps {
                input message: 'Deploy infrastructure?', ok: 'Deploy'
                sh 'terraform apply -auto-approve tfplan'
            }
        }

        stage('Checkov Scan') {
            steps {
                sh 'pip install checkov'

                sh 'checkov -d .'
            }
        }

        stage('Terraform Destroy') {
            steps {
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
