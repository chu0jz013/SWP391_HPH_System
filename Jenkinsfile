pipeline {
    agent any

    tools {
        terraform 'my-terraform-1.5.7'
    }

    environment {
        GOOGLE_PROJECT_ID = 'knhfrdevops'
        REGION = 'asia-east2'
        ENV_SYSTEM = 'sit'
        GOOGLE_APPLICATION_CREDENTIALS = credentials('gcloud-creds')
        GOOGLE_CLOUD_KEYFILE_JSON = credentials('gcloud-creds')
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
            // sh 'gcloud auth application-default login --client-id-file=$GCLOUD_CREDS --quiet'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'gcloud --version'
                // sh 'gcloud auth application-default login --client-id-file=$GCLOUD_CREDS --quiet'
                sh 'pwd'
                sh 'ls -l'
                sh 'bash infrastructure/script/plan.sh ${ENV_SYSTEM}'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'gcloud --version'
                // sh 'gcloud auth activate-service-account --key-file=$GCLOUD_CREDS'
                input message: 'Deploy infrastructure?', ok: 'Deploy'
                sh 'bash infrastructure/script/run.sh ${ENV_SYSTEM}'
            }
        }

        stage('Terraform Destroy') {
            steps {
                sh 'gcloud --version'
                // sh 'gcloud auth activate-service-account --key-file=$GCLOUD_CREDS'
                input message: 'Destroy infrastructure?', ok: 'Destroy'
                sh 'bash infrastructure/script/destroy.sh ${ENV_SYSTEM}'
            }
        }
    }
}
