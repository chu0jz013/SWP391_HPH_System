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
        GCLOUD_CREDS = credentials('gcloud-creds')
    }

    stages {
        stage('Git checkout') {
            steps {
                checkout scm
            }
        }

        stage('Get Google Cloud Credentials') {
            steps {
                sh 'gcloud --version'

                def file_path = '.credentials/gcloud-creds.json'
                def text_to_copy = env.GCLOUD_CREDS

                script {
                    if (!fileExists(file_path)) {
                        writeFile(file_path, text_to_copy)
                        echo "Text copied to $file_path"
                    }
                }

                sh "gcloud auth application-default login --client-id-file=$file_path --quiet"
                sh 'gcloud auth application-default print-access-token'
            }

        }

        stage('Terraform Plan') {
            steps {
                sh 'gcloud --version'
                sh 'gcloud auth application-default login  --key-file=$GCLOUD_CREDS.json --quiet'
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
