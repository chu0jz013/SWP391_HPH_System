pipeline {
    agent any

    tools {
        terraform 'my-terraform-1.5.7'
    }

    environment {
        PROJECT_ID = 'knhfrdevops'
        REGION = 'asia-east2'
        // TERRAFORM_VERSION = '1.5.7'
        ENV_SYSTEM = 'sit'
        // GCLOUD_CREDS=credentials('gcloud-creds')
    }

    stages {
        stage('Git checkout') {
            steps {
                checkout scm
            }
        }

        stage('Get gclod credentials') {
            steps {
                sh 'gcloud --version'
                // sh 'gcloud auth application-default login --client-id-file=$GCLOUD_CREDS'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'gcloud --version'
                // sh 'gcloud auth activate-service-account --key-file=$GCLOUD_CREDS'
                sh 'pwd'
                sh 'ls -l'
                sh 'bash infrastructure/script/plan.sh ${ENV_SYSTEM}'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'gcloud --version'
                input message: 'Deploy infrastructure?', ok: 'Deploy'
                sh 'bash infrastructure/script/run.sh ${ENV_SYSTEM}'
            }
        }

        stage('Terraform Destroy') {
            steps {
                sh 'gcloud --version'
                input message: 'Destroy infrastructure?', ok: 'Destroy'
                sh 'bash infrastructure/script/destroy.sh ${ENV_SYSTEM}'
            }
        }
    }
}
