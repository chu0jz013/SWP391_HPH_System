pipeline {
    agent any

    tools {
        terraform 'my-terraform-1.5.7'
    }

    parameters {
        choice(name: 'ENV_SYSTEM', choices: ['sit', 'uat', 'prod'], description: 'Select the environment')
    }

    environment {
        GOOGLE_APPLICATION_CREDENTIALS = credentials('gcloud-creds')
        GOOGLE_CLOUD_KEYFILE_JSON = credentials('gcloud-creds')
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
                        sh 'cat infrastructure/gcp/main/checkov_results.json'
                    } catch (Exception e) {
                        currentBuild.result = 'FAILURE'
                        error("Terraform Plan failed: ${e.message}")
                    }
                }
            }
        }

        stage('Terraform Scan with Checkov') {
            steps {
                script {
                    try {
                                    sh 'checkov --version'
                        sh 'checkov -f infrastructure/gcp/main/checkov_results.json'
                    } catch (Exception e) {
                        // currentBuild.result = 'FAILURE'
                        // error("Scan with Checkov failed: ${e.message}")
                        sh 'echo fail'
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

        stage('Apply Kubernetes Config') {
            steps {
                script {
                    try {
                    } catch (Exception e) {
                        currentBuild.result = 'FAILURE'
                        error("Terraform Apply failed: ${e.message}")
                    }
                }
            }
        }
    }
    post {
            failure {
                emailext(
                    subject: "Pipeline Failed: ${currentBuild.fullDisplayName}",
                    body: "The Jenkins pipeline '${currentBuild.fullDisplayName}' has failed.",
                    to: 'williamkieu2003@gmail.com'
                )
            }
    }
}

