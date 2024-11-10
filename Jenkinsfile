pipeline {
    agent any

    environment {        
        MYSQL_IMAGE_NAME = "santiagopereyramarchetti/mysql:1.2"
        MYSQL_DOCKERFILE_PATH = "./docker/mysql/Dockerfile.mysql"

        API_IMAGE_NAME = "santiagopereyramarchetti/api:1.2"
        API_DOCKERFILE_PATH = "./docker/laravel/Dockerfile.laravel"

        NGINX_IMAGE_NAME = "santiagopereyramarchetti/nginx:1.2"
        NGINX_DOCKERFILE_PATH = "./docker/nginx/Dockerfile.nginx"

        FRONTEND_IMAGE_NAME = "santiagopereyramarchetti/frontend:1.2"
        FRONTEND_DOCKERFILE_PATH = "./docker/vue/Dockerfile.vue"
        FRONTEND_TARGET_STAGE = "prod"

        PROXY_IMAGE_NAME = "santiagopereyramarchetti/proxy:1.2"
        PROXY_DOCKERFILE_PATH = "./docker/proxy/Dockerfile.proxy"
        PROXY_TARGET_STAGE = "prod"

        DB_CONNECTION = "mysql"
        DB_HOST = "mysql"
        DB_PORT = "3306"
        DB_NAME = "backend"
        DB_USER = "backend"
        DB_PASSWORD = "password"
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
        stage('Configurando archivo .env'){
            steps{
                script{
                   sh '''
                        cd ./backend
                        cp .env.example .env
                        sed -i "/DB_CONNECTION=sqlite/c\\DB_CONNECTION=${DB_CONNECTION}" "./.env"
                        sed -i "/# DB_HOST=127.0.0.1/c\\DB_HOST=${DB_HOST}" "./.env"
                        sed -i "/# DB_PORT=3306/c\\DB_PORT=${DB_PORT}" "./.env"
                        sed -i "/# DB_DATABASE=laravel/c\\DB_DATABASE=${DB_NAME}" "./.env"
                        sed -i "/# DB_USERNAME=root/c\\DB_USERNAME=${DB_USER}" "./.env"
                        sed -i "/# DB_PASSWORD=/c\\DB_PASSWORD=${DB_PASSWORD}" "./.env"
                        cd ..
                    '''
                }
            }
        }
    }
}