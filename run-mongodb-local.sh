
MONGO_PASSWORD="MonGoPaSsWoRd"

# start mongo db server
docker run \
  --rm \
  --publish 27017:27017 \
  --name mongo \
  --env MONGODB_PASS="$MONGO_PASSWORD" \
  --detach \
  tutum/mongodb
