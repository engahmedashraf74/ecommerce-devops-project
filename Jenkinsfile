#v1 

pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Frontend') {
            steps {
                sh '''
                docker build -t frontend \
                ./microservices/src/frontend
                '''
            }
        }

    }
}