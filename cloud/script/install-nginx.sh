#!/bin/bash

#UPDATE

sudo apt update -y 

#UPGRADE

sudo apt upgrade -y 

# INSTALL NGINX

sudo apt install nginx -y 


# RESTART NGINX

sudo systemctl restart nginx



# ENABLE NGINX

sudo systemctl enable nginx -y 