pipeline {
    agent any

    parameters {
        choice(name: 'ENV_SYSTEM', choices: ['sit', 'prod'], description: 'Select the environment')
        string(name: 'GOOGLE_CLOUD_KEYFILE_JSON', defaultValue: 'gcloud-creds', description: 'Google Cloud Service Account JSON Key')
    }

    environment {
        GOOGLE_PROJECT_ID = 'knhfrdevops'
        REGION = 'asia-east2'
    }

    stages {
        stage('Git Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    try {
                        sh 'gcloud --version'
                        sh 'pwd'
                        sh 'ls -l'
                        sh "bash infrastructure/script/plan.sh ${params.ENV_SYSTEM}"
                    } catch (Exception e) {
                        currentBuild.result = 'FAILURE'
                        error("Terraform Plan failed: ${e.message}")
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    try {
                        sh 'gcloud --version'
                        sh "bash infrastructure/script/plan.sh ${params.ENV_SYSTEM}"
                        input message: 'Deploy infrastructure?', ok: 'Deploy'
                        sh "bash infrastructure/script/run.sh ${params.ENV_SYSTEM}"
                    } catch (Exception e) {
                        currentBuild.result = 'FAILURE'
                        error("Terraform Apply failed: ${e.message}")
                    }
                }
            }
        }

        // stage('Terraform Destroy') {
        //     steps {
        //         script {
        //             try {
        //                 input message: 'Destroy infrastructure?', ok: 'Destroy'
        //                 sh "bash infrastructure/script/destroy.sh ${params.ENV_SYSTEM}"
        //             } catch (Exception e) {
        //                 currentBuild.result = 'FAILURE'
        //                 error("Terraform Destroy failed: ${e.message}")
        //             }
        //         }
        //     }
        // }
    }

    post {
        failure {
            emailext(
                subject: "Pipeline Failed: ${currentBuild.fullDisplayName}",
                body: "The Jenkins pipeline '${currentBuild.fullDisplayName}' has failed.",
                to: 'your-email@example.com',
            )
        }
    }
}
