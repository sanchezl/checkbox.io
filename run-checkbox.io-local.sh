
MONGO_PASSWORD="MonGoPaSsWoRd"

# create a docker network
NETWORK_NAME="cb_network"
[ ! "$(docker network ls --format {{.Name}} | grep $NETWORK_NAME)" ] &&  docker network create $NETWORK_NAME

# start mongo db server
docker run \
  --publish 27017:27017 \
  --name cb_mongo \
  --network $NETWORK_NAME \
  --network-alias mongo \
  --env MONGO_INITDB_ROOT_USERNAME=admin \
  --env MONGO_INITDB_ROOT_PASSWORD=MonGoPaSsWoRd \
  --detach \
  mongo

printf "Waiting a few seconds..."
sleep 3
printf "\n"

# start checkbox.io
docker run \
  --name cb \
  --network $NETWORK_NAME \
  --network-alias checkbox \
  --publish 3002:3002 \
  --publish-all \
  --env MONGO_PORT=3002 \
  --env MONGO_IP=mongo \
  --env MONGO_USER=admin \
  --env MONGO_PASSWORD=$MONGO_PASSWORD \
  --env MAIL_USER=itrustv2test@gmail.com \
  --env MAIL_PASSWORD=itrustnoone99 \
  --env MAIL_SMTP=smtp.gmail.com \
  --env COVERAGE=true \
  --volume $PWD/server-side/site:/usr/src/app \
  --workdir /usr/src/app \
  --detach \
  node:9 \
  npm start

# start nginx
docker run \
  --name cb_nginx \
  --network $NETWORK_NAME \
  --network-alias nginx \
  --publish 80:80 \
  --volume $PWD/public_html:/usr/share/nginx/html \
  --volume $PWD/local-conf/nginx.conf:/etc/nginx/nginx.conf \
  --volume $PWD/local-conf/default:/etc/nginx/sites-available/default \
  --detach \
  nginx
