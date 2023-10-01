pipeline {
    agent any

    tools {
        terraform 'my-terraform'
    }

    environment {
        TERRAFORM_VERSION = '1.5.7'
        ENV_SYSTEM = 'sit'
    }

    stages {
        stage('Git checkout') {
            steps {
                checkout scm
            }
        }

        // stage('Get gclod credentials') {
        //     steps {
        //         sh 'gcloud --version'
        //         sh 'gcloud auth activate-service-account --key-file=$GCLOUD_CREDS'
        //         sh 'gcloud compute zones list'
        //     }
        // }

        stage('Terraform Plan') {
            steps {
                withCredentials([file(credentialsId: 'gcloud-creds', variable: 'GCLOUD_CREDS')]) {
                    sh 'gcloud --version'
                    sh 'gcloud auth activate-service-account --key-file=$GCLOUD_CREDS'
                    sh 'pwd'
                    sh 'ls -l'
                    sh 'bash infrastructure/script/plan.sh ${ENV_SYSTEM}'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'gcloud --version'
                sh 'gcloud auth activate-service-account --key-file=$GCLOUD_CREDS'
                input message: 'Deploy infrastructure?', ok: 'Deploy'
                sh 'bash infrastructure/script/run.sh ${ENV_SYSTEM}'
            }
        }

        stage('Terraform Destroy') {
            steps {
                sh 'gcloud --version'
                sh 'gcloud auth activate-service-account --key-file=$GCLOUD_CREDS'
                input message: 'Destroy infrastructure?', ok: 'Destroy'
                sh 'bash infrastructure/script/destroy.sh ${ENV_SYSTEM}'
            }
        }
    }
}
