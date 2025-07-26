pipeline {
  agent any

  environment {
    ARM_CLIENT_ID       = credentials('jenkins-client-id')
    ARM_CLIENT_SECRET   = credentials('jenkins-client-secret')
    ARM_TENANT_ID       = credentials('jenkins-tenant-id')
    ARM_SUBSCRIPTION_ID = credentials('jenkins-subscription-id')
  }

  parameters {
    booleanParam(name: 'APPROVE_CHANGES', defaultValue: false, description: 'Require manual approval before Apply')
    booleanParam(name: 'AUTO_APPLY', defaultValue: false, description: 'Auto-apply infrastructure changes')
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Init') {
  steps {
    sh 'terraform init'
  }
}


    stage('Plan') {
      steps {
        dir('terraform') {
          sh '''
            echo "client_id = \\"$ARM_CLIENT_ID\\"" > terraform.tfvars
            echo "client_secret = \\"$ARM_CLIENT_SECRET\\"" >> terraform.tfvars
            echo "tenant_id = \\"$ARM_TENANT_ID\\"" >> terraform.tfvars
            echo "subscription_id = \\"$ARM_SUBSCRIPTION_ID\\"" >> terraform.tfvars
            terraform plan -var-file="terraform.tfvars"
          '''
        }
      }
    }

    stage('Approval') {
      when {
        beforeAgent true
        expression { return params.APPROVE_CHANGES }
      }
      steps {
        input message: "Apply the planned infrastructure changes?", ok: "Deploy"
      }
    }

    stage('Apply') {
      when {
        expression { return params.AUTO_APPLY || params.APPROVE_CHANGES }
      }
      steps {
        dir('terraform') {
          sh 'terraform apply -auto-approve -var-file="terraform.tfvars"'
        }
      }
    }

    stage('Cleanup') {
      steps {
        dir('terraform') {
          sh 'rm -f terraform.tfvars'
        }
      }
    }
  }

  post {
    always {
      echo "Build completed: ${currentBuild.currentResult}"
    }
  }
}
