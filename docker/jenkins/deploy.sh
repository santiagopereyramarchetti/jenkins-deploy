#!/bin/bash
MYSQL_ROOT_PASSWORD=$1
DB_USER=$2
DB_PASSWORD=$3
MAX_WAIT=$4
WAIT_INTERVAL=$5

MYSQL_IMAGE_NAME=$6
MYSQL_CONTAINER_NAME=$7

API_IMAGE_NAME=$8
API_CONTAINER_NAME=${9}

NGINX_IMAGE_NAME=${10}
NGINX_CONTAINER_NAME=${11}

FRONTEND_IMAGE_NAME=${12}
FRONTEND_CONTAINER_NAME=${13}

PROXY_IMAGE_NAME=${14}
PROXY_CONTAINER_NAME=${15}

REDIS_IMAGE_NAME=${16}
REDIS_CONTAINER_NAME=${17}

echo $MYSQL_ROOT_PASSWORD
echo $DB_USER
echo $DB_PASSWORD
echo $MAX_WAIT
echo $WAIT_INTERVAL

echo $MYSQL_IMAGE_NAME
echo $MYSQL_CONTAINER_NAME

echo $API_IMAGE_NAME
echo $API_CONTAINER_NAME

echo $NGINX_IMAGE_NAME
echo $NGINX_CONTAINER_NAME

echo $FRONTEND_IMAGE_NAME
echo $FRONTEND_CONTAINER_NAME

echo $PROXY_IMAGE_NAME
echo $PROXY_CONTAINER_NAME

echo $REDIS_IMAGE_NAME
echo $REDIS_CONTAINER_NAME

# if ! docker network ls --format '{{.Name}}' | grep -q 'my_app' ; then
#     echo 'Red my_app no existe. Creando...'
#     docker network create my_app
# else
#     echo 'La red my_app ya existe'
# fi

# volumes=("mysql" "redis")
# for volume in "${volumes[@]}"; do
#     if ! docker volume ls -q | grep -q "$volume"; then
#         echo "El volumen $volume no existe. Creando..."
#         docker volume create $volume 
#     else
#         echo "El volumen $volume ya existe."
#     fi
# done

# containers=($REDIS_CONTAINER_NAME $MYSQL_CONTAINER_NAME $API_CONTAINER_NAME $NGINX_CONTAINER_NAME $FRONTEND_CONTAINER_NAME $PROXY_CONTAINER_NAME)

# for container in "${containers[@]}"; do
#     if docker ps -a --format '{{.Names}}' | grep -q "$container"; then
#         image_name=$(docker inspect --format '{{.Config.Image}}' $container)
#         echo Eliminando container $container
#         docker rm -f $container
#         echo Eliminando image $image_name
#         docker rmi -f $image_name
#     else
#         echo El container $container no existe
#     fi
# done

# docker run -d --name $REDIS_CONTAINER_NAME -v redis:/data --network my_app $REDIS_IMAGE_NAME
# docker run -d --name $MYSQL_CONTAINER_NAME -v mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD --network my_app $MYSQL_IMAGE_NAME
# docker run -d --name $API_CONTAINER_NAME --env-file /tmp/.env --network my_app $API_IMAGE_NAME
# docker run -d --name $NGINX_CONTAINER_NAME --env-file /tmp/.env --network my_app $NGINX_IMAGE_NAME
# docker run -d --name $FRONTEND_CONTAINER_NAME --network my_app $FRONTEND_IMAGE_NAME
# docker run -d --name $PROXY_CONTAINER_NAME -p 80:80 -p 443:443 --network my_app $PROXY_IMAGE_NAME

# start_time=$(date +%s)
# while true; do

#     if docker exec mysql mysql -u"$DB_USER" -p"$DB_PASSWORD" -e "SELECT 1;" >/dev/null 2>&1; then
#         echo "MySQL está listo para aceptar conexiones."
#         break
#     else
#         echo "MySQL no está listo aún, esperando..."
#     fi

#     ## Verificar si se ha excedido el tiempo de espera máximo
#     current_time=$(date +%s)
#     elapsed_time=$((current_time - start_time))

#     if [ "$elapsed_time" -ge "$MAX_WAIT" ]; then
#         echo "Se agotó el tiempo de espera. MySQL no está listo."
#         exit 1
#     fi

#     # Esperar antes de volver a intentar
#     sleep "$WAIT_INTERVAL"
# done

# docker exec $API_CONTAINER_NAME php artisan key:generate
# docker exec $API_CONTAINER_NAME php artisan storage:link
# docker exec $API_CONTAINER_NAME php artisan optimize:clear
# docker exec $API_CONTAINER_NAME php artisan down
# docker exec $API_CONTAINER_NAME php artisan migrate --force
# docker exec $API_CONTAINER_NAME php artisan config:cache
# docker exec $API_CONTAINER_NAME php artisan route:cache
# docker exec $API_CONTAINER_NAME php artisan view:cache
# docker exec $API_CONTAINER_NAME php artisan up