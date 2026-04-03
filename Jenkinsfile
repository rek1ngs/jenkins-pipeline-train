pipeline {
  agent any

  stages {
    stage('checkout') {
      steps {
        echo 'Checking out code...'
        checkout scm
      }
    }

    stage('validation') {
      steps {
        echo 'Validating application...'
        sh './jenkins/validate-agent.sh'
      }
    }
    stage('install-pip-deps') {
      steps {
        echo 'Installing dependencies...'
        sh './jenkins/install-python-deps.sh'
      }
    }

    stage('deploy-to-dev') {
      steps {
        echo 'Deploying to dev...'
        sh './jenkins/deploy-service.sh dev 7001'
      }
    }

    stage('tests-on-dev') {
      steps {
        echo 'Testing dev...'
        sh './jenkins/run-api-tests.sh dev'
      }
    }

    stage('deploy-to-stg') {
      steps {
        echo 'Deploying to stg...'
        sh './jenkins/deploy-service.sh stg 7002'
      }
    }

    stage('tests-on-stg') {
      steps {
        echo 'Testing stg...'
        sh './jenkins/run-api-tests.sh stg'
      }
    }

    stage('deploy-to-preprod') {
      steps {
        echo 'Deploying to preprod...'
        sh './jenkins/deploy-service.sh preprod 7003'
      }
    }

    stage('tests-on-preprod') {
      steps {
        echo 'Testing preprod...'
        sh './jenkins/run-api-tests.sh preprod'
      }
    }

    stage('deploy-to-prod') {
      steps {
        echo 'Deploying to prod...'
        sh './jenkins/deploy-service.sh prod 7004'
      }
    }

    stage('tests-on-prod') {
      steps {
        echo 'Testing prod...'
        sh './jenkins/run-api-tests.sh prod'
      }
    }
  }
}