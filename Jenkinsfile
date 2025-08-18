pipeline {
    agent any
    environment {
        IMAGE_NAME= "satven/test-app:latest"
    }
    stages {
        stage('Git clone') {
            steps {
                git 'https://github.com/SatGitZ/Project.git'
            }
        }
        stage('Docker Build') {
            steps {
                sh '  docker build  -t $IMAGE_NAME .'
            }
        }
        stage('Docker Push') {
            steps {
                 withCredentials([usernamePassword(
                 credentialsId: 'dockerhub-credentials',
                 usernameVariable: 'DOCKER_USER',
                 passwordVariable: 'DOCKER_PASS'
        )]) {
            sh '''
                echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                docker push $IMAGE_NAME
            '''
        }
    }
}
        stage('Test') {
            steps {
                sh ' chmod +x test_api.sh && ./test_api.sh'
            }
        }
        stage ('Deploy to minikube'){
            steps {
                sh 'kubectl apply -f Deployment.yaml --validate=false'
                 sh  'kubectl apply -f service.yaml'
        }
    }
}
}