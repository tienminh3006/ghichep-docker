# Deploy a private registry - digitaloceans.com

yum install -y httpd-tools

rm -rf ~/docker-registry
rm -rf /docker-registry
# docker rm -f registry
# docker rm -f nginx
mkdir ~/docker-registry && cd ~/docker-registry
mkdir data 


cd ~/docker-registry
mkdir ~/docker-registry/nginx


cd ~/docker-registry/nginx
htpasswd -b -c registry.password USERNAME PASSWORD

cat <<EOF>> ~/docker-registry/docker-compose.yml
nginx:
  image: "nginx"
  ports:
    - 443:443
  links:
    - registry:registry
  volumes:
    - ./nginx/:/etc/nginx/conf.d
registry:
  image: registry:2
  ports:
    - 127.0.0.1:5000:5000
  environment:
    REGISTRY_STORAGE_FILESYSTEM_ROOTDIRECTORY: /data
  volumes:
    - ./data:/data
EOF

cat <<EOF>> ~/docker-registry/nginx/registry.conf
upstream docker-registry {
  server registry:5000;
}

server {
  listen 443;
  server_name myhub.docker.io;

  # SSL
  ssl on;
  ssl_certificate /etc/nginx/conf.d/myhub.docker.io.crt;
  ssl_certificate_key /etc/nginx/conf.d/myhub.docker.io.key;

  # disable any limits to avoid HTTP 413 for large image uploads
  client_max_body_size 0;

  # required to avoid HTTP 411: see Issue #1486 (https://github.com/docker/docker/issues/1486)
  chunked_transfer_encoding on;

  location /v2/ {
    # Do not allow connections from docker 1.5 and earlier
    # docker pre-1.6.0 did not properly set the user agent on ping, catch "Go *" user agents
    if (\$http_user_agent ~ "^(docker\/1\.(3|4|5(?!\.[0-9]-dev))|Go ).*$" ) {
      return 404;
    }

    # To add basic authentication to v2 use auth_basic setting plus add_header
    auth_basic "registry.localhost";
    auth_basic_user_file /etc/nginx/conf.d/registry.password;
    add_header 'Docker-Distribution-Api-Version' 'registry/2.0' always;

    proxy_pass                          http://docker-registry;
    proxy_set_header  Host              \$http_host;   # required for docker client's sake
    proxy_set_header  X-Real-IP         \$remote_addr; # pass on real client's IP
    proxy_set_header  X-Forwarded-For   \$proxy_add_x_forwarded_for;
    proxy_set_header  X-Forwarded-Proto \$scheme;
    proxy_read_timeout                  900;
  }
}
EOF

cd /
mv ~/docker-registry /docker-registry

sh ~/gen-cer myhub.docker.io myhub.docker.io

mv myhub.docker.io.* /docker-registry/nginx
mv devdockerCA.* /docker-registry/nginx

docker run -d \
--restart=always \
--name registry \
--publish 127.0.0.1:5000:5000 \
--mount type=bind,source=/docker-registry/data,target=/data \
--restart=always \
--env REGISTRY_STORAGE_FILESYSTEM_ROOTDIRECTORY=/data \
--privileged \
registry:2

docker run -d \
--restart=always \
--name nginx \
--publish 443:443 \
--link registry \
--mount type=bind,source=/docker-registry/nginx,target=/etc/nginx/conf.d,readonly \
nginx

echo "127.0.0.1   myhub.docker.io" >> /etc/hosts

# cd /docker-registry
# docker compose up