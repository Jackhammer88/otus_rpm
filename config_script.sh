#!/bin/bash

dnf install nginx createrepo dotnet-runtime-6.0 -y
mkdir -p /var/www/html/rpm-repo
cp /home/vagrant/hello-world-app.1.0.0.rpm /var/www/html/rpm-repo/
createrepo /var/www/html/rpm-repo/
echo "server { listen 127.0.0.1:80; server_name localhost; location /rpm-repo { autoindex on; alias /var/www/html/rpm-repo; } location / { } }" > /etc/nginx/conf.d/rpm-repo.conf
nginx -t
chmod -R 755 /var/www/html/rpm-repo

echo '[local-rpm]
name=Local RPM Repository
baseurl=http://127.0.0.1/rpm-repo
enabled=1
gpgcheck=0' > /etc/yum.repos.d/local-rpm.repo

chcon -R -t httpd_sys_content_t /var/www/html/rpm-repo
chcon -R -t httpd_sys_script_rw_t /var/www/html/rpm-repo
systemctl restart nginx

dnf install hello-world-app -y
dotnet /usr/share/hello-world-app/hello-world-app.dll