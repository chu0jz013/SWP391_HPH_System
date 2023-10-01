pipeline {
    agent any

    tools{
        terraform 'my-terraform'
    }

    environment {
        TERRAFORM_VERSION = '1.5.7'
        ENV_SYSTEM = 'SIT'
    }

    stages {
        stage('Git checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'bash infrastructure/script/plan.sh ${ENV_SYSTEM}'
            }
        }

        stage('Terraform Apply') {
            steps {
                input message: 'Deploy infrastructure?', ok: 'Deploy'
                sh 'bash infrastructure/script/run.sh ${ENV_SYSTEM}'
            }
        }

        stage('Terraform Destroy') {
            steps {
                input message: 'Destroy infrastructure?', ok: 'Destroy'
                sh 'bash infrastructure/script/destroy.sh ${ENV_SYSTEM}'
            }
        }
    }
}
