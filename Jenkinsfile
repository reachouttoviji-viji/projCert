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
                withCredentials([string(credentialsId: 'sudo_pass', variable: 'SUDO_PASS')]){
                sh '''
                set -e
                export DEBIAN_FRONTEND=noninteractive
                echo "$SUDO_PASS" | sudo -S apt-get update -y
                echo "$SUDO_PASS" | sudo -S apt-get install -y docker.io git curl
                echo "$SUDO_PASS" | sudo -S systemtct enable docker
                echo "$SUDO_PASS" | sudo -S systemtct start docker
                '''
            }
        }
        }
        stage('Docker Image') {
            steps {
                sh 'sudo docker build -t php-webapp:latest -f /home/labuser/demo/projCert/Dockerfile /home/labuser/demo/projCert'
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