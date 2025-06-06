pipeline {
  agent any

    environment {
      JAVA_TOOL_OPTIONS = "-Djava.security.egd=file:/dev/./urandom"
      IMAGE_NAME = "blakode/guestbook"
      TAG = "v1.0"
    }


  stages {
    stage('Build') {
      steps {
        sh 'chmod +x mvnw'
        sh 'export JAVA_TOOL_OPTIONS="-Djava.security.egd=file:/dev/./urandom"'
        sh './mvnw clean package -DskipTests'
      }
    }

    stage('Test') {
      steps {
        sh './mvnw test'
      }
    }

    stage('Docker Build & Push') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          sh '''
            echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
            docker build -t $IMAGE_NAME:$TAG .
            docker push $IMAGE_NAME:$TAG
          '''
        }
      }
    }
  }
}
