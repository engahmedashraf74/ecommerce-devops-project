#v1 

pipeline {
    agent any

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

        stage('Validate Kubernetes Manifests') {
            steps {
                sh '''
                kubectl kustomize microservices/kubernetes-manifests > /dev/null
                '''
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