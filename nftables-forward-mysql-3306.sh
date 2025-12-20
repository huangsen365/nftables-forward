#!/bin/sh

docker run -d \
  --name=nftables-forward-mysql-3306 \
  --cap-add=NET_ADMIN \
  --cap-add=SYS_MODULE \
  --restart=always \
  -p 3306:3306 \
  -e FORWARD_IP="10.0.0.10" \
  -e FORWARD_PORT="3306" \
  -e CONTAINER_PORT="3306" \
  my-nftables-forward
