pipeline {
    agent any

    stages{
        stage('Buildeando images'){
            steps{
                sh 'docker-compose up -d --build'
            }
        }
    }
}