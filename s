#!/bin/sh

# In host's terminal

dinstall()
{
sudo apt install docker docker.io
}

dstart()
{
sudo service docker start
}

# (relogin)

dpull()
{
docker pull registry.docker-cn.com/library/ubuntu:latest
}

drun()
{
docker run -it -p 19132:19132 -p 19132:19132/udp -v /home/ubuntu/mc:/mc ubuntu /bin/bash
}

# To disattach the conatiner
# Press Ctrl+P and then Ctrl+Q

dps()
{
docker ps -a
echo "You can enter \"dattach CONTAINER_ID\" to attach the container."
}

dattach()
{
docker attach $1
}

# In the container's terminal

cprepare()
{
apt update
apt install -y curl
}

crun()
{
cd /mc
LD_LIBRARY_PATH=. ./bedrock_server
}
