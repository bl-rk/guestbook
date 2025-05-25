pipeline {
  agent any

  environment {
    IMAGE_NAME = "blakode/guestbook"
    TAG = "latest" // Optional: replace with git commit for better versioning
  }

  stages {
    stage('Checkout') {
      steps {
        git 'https://github.com/bl-rk/guestbook.git'
      }
    }

    stage('Build') {
      steps {
        sh 'chmod +x mvnw'
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