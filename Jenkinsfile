pipeline {
    agent any

    environment {
        API_IMAGE_NAME = "santiagopereyramarchetti/api:1.2"
        API_DOCKERFILE_PATH = "./docker/laravel/Dockerfile.laravel"
    }

    stages{
        stage('Buildeando images'){
            steps{
                    script{
                        docker.build(API_IMAGE_NAME, "-f ${API_DOCKERFILE_PATH} .")
                    }
            }
        }
    }
}