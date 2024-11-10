pipeline {
    agent any

    environment {        
        MYSQL_IMAGE_NAME = "santiagopereyramarchetti/mysql:1.2"
        MYSQL_DOCKERFILE_PATH = "./docker/laravel/Dockerfile.mysql"

        API_IMAGE_NAME = "santiagopereyramarchetti/api:1.2"
        API_DOCKERFILE_PATH = "./docker/laravel/Dockerfile.laravel"

        NGINX_IMAGE_NAME = "santiagopereyramarchetti/nginx:1.2"
        NGINX_DOCKERFILE_PATH = "./docker/laravel/Dockerfile.nginx"

        FRONTEND_IMAGE_NAME = "santiagopereyramarchetti/frontend:1.2"
        FRONTEND_DOCKERFILE_PATH = "./docker/laravel/Dockerfile.vue"
        FRONTEND_TARGET_STAGE = "prod"

        PROXY_IMAGE_NAME = "santiagopereyramarchetti/proxy:1.2"
        PROXY_DOCKERFILE_PATH = "./docker/laravel/Dockerfile.proxy"
        PROXY_TARGET_STAGE = "prod"
    }

    stages{
        stage('Buildeando images'){
            steps{
                    script{
                        docker.build(MYSQL_IMAGE_NAME, "-f ${MYSQL_DOCKERFILE_PATH} .")
                        docker.build(API_IMAGE_NAME, "-f ${API_DOCKERFILE_PATH} .")
                        docker.build(NGINX_IMAGE_NAME, "-f ${NGINX_DOCKERFILE_PATH} .")
                        docker.build(FRONTEND_IMAGE_NAME, "-f ${FRONTEND_DOCKERFILE_PATH} --target ${FRONTEND_TARGET_STAGE} .")
                        docker.build(PROXY_IMAGE_NAME, "-f ${PROXY_DOCKERFILE_PATH} --target ${PROXY_TARGET_STAGE} .")
                    }
            }
        }
    }
}