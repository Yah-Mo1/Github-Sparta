Installing nginx on azure vm and running a node js application on the azure vm

sudo apt update -y && sudo apt-get upgrade -y

# UPDATE

sudo apt update -y

# UPGRADE

sudo apt upgrade -y

# INSTALL NGINX

sudo apt install nginx -y

# RESTART NGINX

sudo systemctl restart nginx

# ENABLE NGINX

sudo systemctl enable nginx -y
Install Node

sudo DEBIAN_FRONTEND=noninteractive bash -c "curl -fsSL https://deb.nodesource.com/setup_20.x | bash -" && \
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs

# Running an application on a vm (node js app on vm)

clone git repository with code
install dependencies using npm
run code using npm start
