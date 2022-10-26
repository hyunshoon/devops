#!/bin/bash

while [ 1 ]
do
	ping www.google.com -c 5
	if [ $? -eq "0" ]
	then
		break
	fi
	sleep 3
done

sudo yum -y update
sudo yum -y install httpd
sudo echo "HELLO TERRAFORM" > /var/www/html/index.html
sudo systemctl restart httpd
sudo systemctl enable httpd
