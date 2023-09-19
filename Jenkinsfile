pipeline {
  agent any
    
  tools {nodejs "nodejs"}
    
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

