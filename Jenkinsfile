pipeline {
  // agent any
    
  agent {
      docker {
          image 'node:18.17.1-alpine3.18' 
          args '-p 3000:3000' 
      }
  }    
  stages {
        
    stage('Git') {
      steps {
        git 'https://github.com/ksatriow/cicd-healthcheck.git'
      }
    }
     
    stage('Build') {
      when {
          expression { currentBuild.changeSets.any { it.branch == 'origin/develop' || it.branch == 'origin/main' } }
      }
      steps {
        sh 'npm install'
        sh 'npm run build'
      }
    }  
               
    stage('Test') {
      when {
          expression { currentBuild.changeSets.any { it.branch == 'origin/develop' || it.branch == 'origin/main' } }
      }
      steps {
        sh 'npm run test'
      }
    }

    stage('Deploy') {
      when {
          expression { currentBuild.changeSets.any { it.branch == 'origin/main' } }
      }
      steps {
        sh 'npm run dev'
      }
    }
  }

  // post {
  //     success {
  //         // Tindakan yang akan diambil jika langkah-langkah di atas berhasil
  //     }
      
  //     failure {
  //         // Tindakan yang akan diambil jika ada kegagalan dalam langkah-langkah di atas
  //     }
  // }
}

