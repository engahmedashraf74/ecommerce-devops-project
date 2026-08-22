pipeline {
    agent any

    triggers {
        pollSCM('* * * * *')
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Format Check') {
            steps {
                sh 'terraform fmt -check -recursive'
            }
        }

        stage('Terraform Validate') {
            steps {
                sh '''
                terraform init -backend=false
                terraform validate
                '''
            }
        }

        stage('Kubernetes Manifest Validation') {
            steps {
                sh '''
                kubectl kustomize microservices/kubernetes-manifests > /dev/null
                '''
            }
        }

        stage('Build Frontend') {
            steps {
                sh '''
                docker build -t frontend ./microservices/src/frontend
                '''
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }

        failure {
            echo 'Pipeline failed!'
        }
    }
}