pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
        AWS_ACCOUNT_ID = '697114252645'
        IMAGE_TAG = "${BUILD_NUMBER}"
    }

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

        stage('Login To ECR') {
            steps {
                sh '''
                export AWS_PAGER=""

                aws ecr get-login-password --region $AWS_REGION | \
                docker login \
                --username AWS \
                --password-stdin \
                $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com
                '''
            }
        }

        stage('Tag Images') {
            steps {
                sh '''
                docker tag frontend $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/frontend:$IMAGE_TAG

                docker tag adservice $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/adservice:$IMAGE_TAG

                docker tag cartservice $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/cartservice:$IMAGE_TAG

                docker tag checkoutservice $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/checkoutservice:$IMAGE_TAG

                docker tag currencyservice $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/currencyservice:$IMAGE_TAG

                docker tag emailservice $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/emailservice:$IMAGE_TAG

                docker tag paymentservice $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/paymentservice:$IMAGE_TAG

                docker tag productcatalogservice $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/productcatalogservice:$IMAGE_TAG

                docker tag recommendationservice $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/recommendationservice:$IMAGE_TAG

                docker tag shippingservice $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/shippingservice:$IMAGE_TAG
                '''
            }
        }

        stage('Push Images To ECR') {
            steps {
                sh '''
                docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/frontend:$IMAGE_TAG

                docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/adservice:$IMAGE_TAG

                docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/cartservice:$IMAGE_TAG

                docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/checkoutservice:$IMAGE_TAG

                docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/currencyservice:$IMAGE_TAG

                docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/emailservice:$IMAGE_TAG

                docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/paymentservice:$IMAGE_TAG

                docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/productcatalogservice:$IMAGE_TAG

                docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/recommendationservice:$IMAGE_TAG

                docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/shippingservice:$IMAGE_TAG
                '''
            }
        }
    }

    post {
        success {
            echo 'Build and Push completed successfully!'
        }

        failure {
            echo 'Pipeline failed!'
        }
    }
}