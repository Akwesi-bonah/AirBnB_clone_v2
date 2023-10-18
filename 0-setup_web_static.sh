#!/usr/bin/env bash
# Setting up web server for deployment of web_static


# update and install nginx if not installed
apt-get update
apt-get install nginx -y

# create required directories
mkdir -p /data/web_static/releases/test/
mkdir -p /data/web_static/shared/

# create a fake html file

cat > /data/web_static/releases/test/index.html <<EOL
<html>
  <head>
  </head>
  <body>
    Holberton School
  </body>
</html>
EOL
# create symbolic 
ln -sf /data/web_static/releases/test/ /data/web_static/current

# change ownership and group
chown -R ubuntu /data/
chgrp -R ubuntu /data/

# configue Nginx default site
cat > /etc/nginx/sites-available/default <<EOL
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    add_header X-Served-By \$HOSTNAME;
    root   /var/www/html;
    index  index.html index.htm;

    location /hbnb_static {
        alias /data/web_static/current;
        index index.html index.htm;
    }

    location /redirect_me {
        return 301 https://github.com/Akwesi-bonah;
    }

    error_page 404 /404.html;
    location /404 {
      root /var/www/html;
      internal;
    }
}
EOL


# restart nginx
service nginx restart
