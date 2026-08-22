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

        stage('Build All Microservices') {
            steps {
                sh '''
                set -e

                docker build -t adservice ./microservices/src/adservice

                docker build -t checkoutservice ./microservices/src/checkoutservice

                docker build -t currencyservice ./microservices/src/currencyservice

                docker build -t emailservice ./microservices/src/emailservice

                docker build -t frontend ./microservices/src/frontend

                docker build -t paymentservice ./microservices/src/paymentservice

                docker build -t productcatalogservice ./microservices/src/productcatalogservice

                docker build -t recommendationservice ./microservices/src/recommendationservice

                docker build -t shippingservice ./microservices/src/shippingservice

                docker build -t cartservice ./microservices/src/cartservice/src
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