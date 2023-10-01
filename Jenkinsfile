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
            sh' git clone https://github.com/tfutils/tfenv.git ~/.tfenv'
            sh ' echo "export PATH=\"$HOME/.tfenv/bin:$PATH\"" >>~/.bashrc'
            sh 'export PATH="$HOME/.tfenv/bin:$PATH"'
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
            sh 'bash infrastructure/script/plan.sh ${ENV_SYSTEM}'
          }
        }

        stage('Terraform Apply') {
          steps {
            input message: 'Deploy infrastructure?', ok: 'Deploy'
            sh 'bash infrastructure/script/run.sh ${ENV_SYSTEM}'
          }
        }

        // stage('Checkov Scan') {
        //   steps {
        //     sh 'pip install checkov'

        //     sh 'checkov -d .'
        //   }
        // }

        stage('Terraform Destroy') {
          steps {
            input message: 'Destroy infrastructure?', ok: 'Destroy'
            sh 'bash infrastructure/script/destroy.sh ${ENV_SYSTEM}'
          }
        }
                }

    // post {
    //     success {
    //       echo  'success'
    //     }

    //     failure {
    //   echo  'failure'
    //     }
    // }
    }
