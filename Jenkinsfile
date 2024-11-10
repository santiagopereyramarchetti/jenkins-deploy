pipeline {
    agent any

    environment {        
        MYSQL_IMAGE_NAME = "santiagopereyramarchetti/mysql:1.2"
        MYSQL_DOCKERFILE_PATH = "./docker/mysql/Dockerfile.mysql"
        MYSQL_CONTAINER_NAME = "mysql"

        API_IMAGE_NAME = "santiagopereyramarchetti/api:1.2"
        API_DOCKERFILE_PATH = "./docker/laravel/Dockerfile.laravel"
        API_CONTAINER_NAME = "api"
        API_TARGET_STAGE = "dev"

        NGINX_IMAGE_NAME = "santiagopereyramarchetti/nginx:1.2"
        NGINX_DOCKERFILE_PATH = "./docker/nginx/Dockerfile.nginx"

        FRONTEND_IMAGE_NAME = "santiagopereyramarchetti/frontend:1.2"
        FRONTEND_DOCKERFILE_PATH = "./docker/vue/Dockerfile.vue"
        FRONTEND_TARGET_STAGE = "prod"

        PROXY_IMAGE_NAME = "santiagopereyramarchetti/proxy:1.2"
        PROXY_DOCKERFILE_PATH = "./docker/proxy/Dockerfile.proxy"
        PROXY_TARGET_STAGE = "prod"

        REDIS_IMAGE_NAME = "redis:7-alpine"
        REDIS_CONTAINER_NAME = "redis"

        DB_CONNECTION = "mysql"
        DB_HOST = "mysql"
        DB_PORT = "3306"
        DB_NAME = "backend"
        DB_USER = "backend"
        DB_PASSWORD = "password"

        MAX_WAIT=120
        WAIT_INTERVAL=10
    }

    stages{
        stage('Buildeando images'){
            steps{
                script{
                    docker.build(MYSQL_IMAGE_NAME, "-f ${MYSQL_DOCKERFILE_PATH} --no-cache .")
                    docker.build(API_IMAGE_NAME, "-f ${API_DOCKERFILE_PATH} --no-cache --target ${API_TARGET_STAGE} .")
                    docker.build(NGINX_IMAGE_NAME, "-f ${NGINX_DOCKERFILE_PATH} .")
                    docker.build(FRONTEND_IMAGE_NAME, "-f ${FRONTEND_DOCKERFILE_PATH} --target ${FRONTEND_TARGET_STAGE} .")
                    docker.build(PROXY_IMAGE_NAME, "-f ${PROXY_DOCKERFILE_PATH} --target ${PROXY_TARGET_STAGE} .")
                }
            }
        }
        stage('Preparando environment para la pipeline'){
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
                    sh 'docker network create my_app'

                    sh 'docker run -d -e MYSQL_ROOT_PASSWORD=password --name ${MYSQL_CONTAINER_NAME} --network my_app ${MYSQL_IMAGE_NAME}'

                    sh 'docker run -d --name ${REDIS_CONTAINER_NAME} --network my_app ${REDIS_IMAGE_NAME}'
                    
                    sh 'docker run -d --name ${API_CONTAINER_NAME --network my_app ${API_IMAGE_NAME}'

                    sh '''
                        start_time=$(date +%s)

                        while true; do
                            # Intentar conectarse al MySQL en el contenedor
                            if docker exec ${MYSQL_CONTAINER_NAME} mysql -u"${DB_USER}" -p"${DB_PASSWORD}" -e "SELECT 1;" >/dev/null 2>&1; then
                                echo "MySQL está listo para aceptar conexiones."
                                break
                            else
                                echo "MySQL no está listo aún, esperando..."
                            fi

                            ## Verificar si se ha excedido el tiempo de espera máximo
                            current_time=$(date +%s)
                            elapsed_time=$((current_time - start_time))

                            if [ "$elapsed_time" -ge "${MAX_WAIT}" ]; then
                                echo "Se agotó el tiempo de espera. MySQL no está listo."
                                exit 1
                            fi

                            # Esperar antes de volver a intentar
                            sleep "${WAIT_INTERVAL}"
                        done
                    '''
                    // Ejecutar los comandos de key:generate y migrate
                    sh '''
                        docker exec ${API_CONTAINER_NAME} php artisan key:generate
                        docker exec ${API_CONTAINER_NAME} php artisan storage:link
                        docker exec ${API_CONTAINER_NAME} php artisan migrate --force
                    '''
                }
            }
        }
        stage('Analisis de código estático'){
            steps{
                script{
                   sh 'docker exec ${API_CONTAINER_NAME} ./vendor/bin/phpstan analyse'
                }
            }
        }
        stage('Analisis de la calidad del código'){
            steps{
                script{
                   sh 'docker exec ${API_CONTAINER_NAME} php artisan insights --no-interaction --min-quality=90 --min-complexity=90 --min-architecture=90 --min-style=90'
                }
            }
        }
        stage('Tests unitarios'){
            steps{
                script{
                   sh ''
                }
            }
        }
    }

    post{
        always{
            script{
                sh 'docker stop ${API_CONTAINER_NAME} || true'
                sh 'docker rm -f ${API_CONTAINER_NAME} || true'
                sh 'docker rmi -f ${API_IMAGE_NAME} || true'
                sh 'docker network rm my_app || true'
            }
        }
    }
}