#!/bin/bash

sudo yum -y install epel-release
sudo yum -y install ansible

echo "192.168.101.[201:239]" | sudo tee /etc/ansible/hosts
