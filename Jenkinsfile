pipeline {
    agent any

    tools {
        terraform 'my-terraform-1.5.7'
    }

    environment {
        PROJECT_ID = 'knhfrdevops'
        REGION = 'asia-east2'
        ENV_SYSTEM = 'sit'
    }

    stages {
        stage('Git checkout') {
            steps {
                checkout scm
            }
        }

        stage('Get Google Cloud Credentials') {
            steps {
                withCredentials([file(credentialsId: 'gcloud-creds', variable: 'GCLOUD_CREDS_FILE')]) {
                    sh "cp ${GCLOUD_CREDS_FILE} /tmp/gcloud-creds.json"
                    echo 'Google Cloud credentials copied to /tmp/gcloud-creds.json'
                    sh 'gcloud auth application-default login --client-id-file=/tmp/gcloud-creds.json --quiet'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'gcloud --version'

                // Authenticate using the credentials file
                sh 'gcloud auth application-default login --client-id-file=/tmp/gcloud-creds.json --quiet'

                sh 'pwd'
                sh 'ls -l'
                sh "bash infrastructure/script/plan.sh ${ENV_SYSTEM}"
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'gcloud --version'
                input message: 'Deploy infrastructure?', ok: 'Deploy'
                sh "bash infrastructure/script/run.sh ${ENV_SYSTEM}"
            }
        }

        stage('Terraform Destroy') {
            steps {
                sh 'gcloud --version'
                input message: 'Destroy infrastructure?', ok: 'Destroy'
                sh "bash infrastructure/script/destroy.sh ${ENV_SYSTEM}"
            }
        }
    }
}
