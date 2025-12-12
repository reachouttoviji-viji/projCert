pipeline {
    agent any
    stages {
        stage('Checkout'){
            steps {
                git branch: 'master', url: 'https://github.com/reachouttoviji-viji/projCert.git'
            }
            }
        stage('Pre-checks') {
            steps {                
                sh '''                   
                    set -eu
                    test -d website || {echo "website/ not found"; exit 1;}
                    test -f website/index.php || {echo "website/index.php missing"; exit 1;}                    
                '''
            }
        }
        }
        stage('Build Docker Image') {
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