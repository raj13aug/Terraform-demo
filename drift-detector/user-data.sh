#!/bin/bash

cat > index.html <<EOF
<h1>Hello, World to ${server_port} </h1>
EOF
sudo apt update
sudo apt install busybox
nohup busybox httpd -f -p ${server_port} &