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
        TF_PATH = '/var/lib/jenkins/workspace/SWP391_HPH_System_main/infrastructure/gcp/main'
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
            // agent {
            //     docker {
            //         image 'bridgecrew/checkov'
            //         args '--volume $TF_PATH:/tf --workdir /tf'
            //     }
            // }
            steps {
                script {
                    // sh 'checkov -f /tf/checkov_results.json'
                    sh 'checkov --version'
                    sh 'checkov -f infrastructure/gcp/main/checkov_results.json'
                }
            }
        }

        // stage('Terraform Scan with Checkov') {
        //     steps {
        //         // sh 'docker run --tty --rm --volume -v "$(pwd):/src" aquasec/tfsec /src'
        //         sh 'docker run --tty --rm --volume ${pwd}:/tf --workdir /tf bridgecrew/checkov --directory /tf'
        //     // sh 'go get install github.com/aquasecurity/tfsec/cmd/tfsec@latest'
        //     // sh 'checkov -f checkov_results.json'
        //     }
        // }

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

