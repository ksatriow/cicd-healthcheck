pipeline {
  agent any

  tools { nodejs "nodejs" }

  stages {
        
    // stage('Git') {
    //   steps {
    //     git 'https://github.com/ksatriow/cicd-healthcheck.git'
    //   }
    // }
     
    stage('Build') {
      // when {
      //     branch 'development'
      // }
      steps {
        sh 'npm install'
        sh 'npm run build'
      }
    }  
               
    stage('Test') {
      // when {
      //     branch 'development'
      // }
      steps {
        sh 'npm run test'
      }
    }

    stage('Deploy') {
      when {
          branch 'main'
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

