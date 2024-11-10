pipeline {
    agent {
        docker {
            image 'docker:latest'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    environment {
        COMPOSE_PROJECT_NAME = 'jenkins-tests'
    }

    stages{
        stage('Actualizando repositorio'){
            steps{
                
                echo 'Repositorio actualizado'
            }
        }
    }
}