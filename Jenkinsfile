pipeline {
    agent any

    tools {
        terraform 'my-terraform-1.5.7'
    }

    environment {
        PROJECT_ID = 'knhfrdevops'
        REGION = 'asia-east2'
        ENV_SYSTEM = 'sit'
        FILE_PATH = '/var/lib/jenkins/creds/gcloud-creds.json'
    }

    stages {
        stage('Git checkout') {
            steps {
                checkout scm
            }
        }

        stage('Get Google Cloud Credentials') {
            steps {
                script {
                    // Retrieve Google Cloud credentials from Jenkins credentials
                    def gcloudCreds = credentials('gcloud-creds')

                    if (gcloudCreds == null) {
                        error "Google Cloud credentials 'gcloud-creds' not found"
                    }

                    // Write the credentials to the specified file
                    writeFile file: FILE_PATH, text: gcloudCreds
                    echo "Google Cloud credentials copied to $FILE_PATH"
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'gcloud --version'

                // Authenticate using the credentials file
                sh "gcloud auth application-default login --client-id-file=$FILE_PATH --quiet"

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
