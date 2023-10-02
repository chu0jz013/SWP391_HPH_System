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
        FILE_PATH = '/var/lib/jenkins/workspace/SWP391_HPH_System_main@tmp/secretFiles/f3855b0d-4c7e-4043-a660-6906ae913096/knhfrdevops-88350ee9f3bb.json'
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

                sh 'echo $GCLOUD_CREDS'

                // script {
                //     if (!fileExists(FILE_PATH)) {
                //         writeFile(FILE_PATH, GCLOUD_CREDS)
                //         echo "Text copied to $FILE_PATH"
                //     }
                // }

                sh "gcloud auth application-default login --client-id-file=$FILE_PATH --quiet"
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
