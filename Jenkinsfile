pipeline {
  agent {
    docker {
      image 'node:6'
    }

  }
  stages {
    stage('npm install') {
      steps {
        sh '''cd server-side/site
npm install'''
      }
    }
    stage('Test') {
      steps {
        echo 'Hello Test'
      }
    }
  }
}