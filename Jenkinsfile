pipeline {
  agent any

  environment {
    ARM_CLIENT_ID       = credentials('jenkins-client-id')
    ARM_CLIENT_SECRET   = credentials('jenkins-client-secret')
    ARM_TENANT_ID       = credentials('jenkins-tenant-id')
    ARM_SUBSCRIPTION_ID = credentials('jenkins-subscription-id')
  }

  stages {
    stage('Init') {
      steps {
        dir('terraform') {
          sh 'terraform init'
        }
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

    stage('Apply') {
      when {
        expression { return params.AUTO_APPLY == true }
      }
      steps {
        dir('terraform') {
          sh 'terraform apply -auto-approve -var-file="terraform.tfvars"'
        }
      }
    }
  }

  parameters {
    booleanParam(name: 'AUTO_APPLY', defaultValue: false, description: 'Apply changes automatically')
  }
}
