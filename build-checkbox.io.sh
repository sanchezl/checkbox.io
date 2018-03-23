docker run \
  --rm \
  --volume $PWD/server-side/site:/usr/src/app \
  --workdir /usr/src/app \
  node:9 \
  npm install

# sed -i .bak 's|\(\s*root\s*\).*|\1 /usr/share/nginx/html/;|' local-conf/default
