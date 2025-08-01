pipeline {
    agent any

    environment {
        CLIENT_ID        = credentials('jenkins-client-id')
        CLIENT_SECRET    = credentials('jenkins-client-secret')
        TENANT_ID        = credentials('jenkins-tenant-id')
        SUBSCRIPTION_ID  = credentials('jenkins-subscription-id')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Shell Test') {
            steps {
                sh 'echo "Shell is alive and working!"'
            }
        }

        stage('Init') {
            steps {
                sh 'echo "shell is working"'
                sh 'terraform init'
            }
        }

        stage('Plan') {
            steps {
                sh 'terraform plan -out=tfplan'
            }
        }

        stage('Approval') {
            steps {
                input message: 'Apply Terraform changes?', ok: 'Yes'
            }
        }

        stage('Apply') {
            steps {
                sh 'terraform apply tfplan'
            }
        }
    }

    post {
        always {
            echo "Build completed: ${currentBuild.currentResult}"
        }
    }
}
