pipeline {
    agent any
    stages {
        stage('Checkout'){
            steps {
                git branch: 'master', url: 'https://github.com/reachouttoviji-viji/projCert.git'
            }
            }
        stage('Install Docker') {
            steps {
                sh 'sudo apt-get update && sudo apt-get install -y docker.io'
            }
        }
        stage('Docker Image') {
            steps {
                sh 'sudo build -t php-webapp:latest'
            }
        }
        stage('Deploy Container'){
            steps {
                sh '''
                sudo docker ps -q --filter "name=php-webapp" | xargs -r sudo docker stop
                sudo docker ps -aq --filter "name=php-webapp" | xargs -r sudo docker rm
                sudo docker run -d --name php-webapp -p 8082:80 php-webapp:latest
                '''
            }
        }
        }
    post {
        failure {
            echo 'Build failed! Cleaning up containers...'
            sh '''
            sudo docker ps -q --filter "name=php-webapp" | xargs -r sudo docker stop
            sudo docker ps -aq --filter "name=php-webapp" | xargs -r sudo docker rm
            '''
        }
    }
}