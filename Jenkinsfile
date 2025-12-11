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
        stage('Deploy Container'){
            steps {
                sh '''
                docker ps -q --filter "name=php-webapp" | xargs -r docker stop docker ps -aq --filter "name=php-webapp" | xargs -r docker rm docker run -d --name php-webapp -p 8085:80 php-webapp:latest
                '''
            }
        }
        }
    post {
        failure {
            echo 'Build failed! Cleaning up containers...'
            sh '''
            docker ps -q --filter "name=php-webapp" | xargs -r docker stop docker ps -aq --filter "name=php-webapp" | xargs -r docker rm
            '''
        }
    }
}