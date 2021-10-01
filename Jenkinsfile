pipeline{
  agent any
  tools{
      
      maven 'mvn-3.8.2'
  }
  stages{
   stage('Build'){
      steps{
       git 'https://github.com/pawanitzone/GameOfLife.git'
       sh 'mvn clean install'
      }
   }
   
   stage('Deploy'){
       steps{
           deploy adapters: [tomcat9(credentialsId: 'tomcat-server', path: '', url: 'http://35.154.47.119:8080')], contextPath: null, war: 'gameoflife-web/target/*.war'
       }
   }

  }
}
