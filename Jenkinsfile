 pipeline {
   agent any
   stages {
     stage('Build') {
       steps {
         sh 'mvnw clean install'
       }
     }
     stage('Test') {
       steps {
         sh 'mvnw test'
       }
     }
     stage('Deploy') {
       steps {
       withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                  sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                 sh 'docker build -t guestbook .'
                 sh 'docker push blakode/guestbook'
                 }
       }
     }
   }
 }