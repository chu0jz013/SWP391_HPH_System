pipeline {
    agent any

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

        stage('Install Terraform') {
            steps {
                sh 'echo "export PATH=\"$HOME/.tfenv/bin:$PATH\"" >>~/.bashrc'
                sh 'export PATH="$HOME/.tfenv/bin:$PATH"'

                sh 'tfenv --version'
                sh "tfenv install ${TERRAFORM_VERSION}"
                sh "tfenv use ${TERRAFORM_VERSION}"
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
