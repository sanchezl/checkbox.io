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
  }
}