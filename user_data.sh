#!/bin/bash
apt-get update
apt-get install -y apache2
systemctl start apache2
systemctl enable apache2
echo "<html>
      <head>
      <title>Hello World!</title>
      </head>
      <body>
      <h1>Hello World! WELCOME TO THIS CHALLENGE, BY CARLOS. </h1>
      </body>
      </html>" > /var/www/html/index.html




# sudo yum update -y
# sudo amazon-linux-extras install docker -y
# sudo service docker start
# sudo usermod -a -G docker ec2-user
# sudo chkconfig docker on
# sudo chmod 666 /var/run/docker.sock
# docker pull dhruvin30/dhsoniweb:v1
# docker run -d -p 80:80 dhruvin30/dhsoniweb:latest