#!/bin/sh

# GitHub 

docker run -d \
  --name=nftables-forward-80 \
  --cap-add=NET_ADMIN \
  --cap-add=SYS_MODULE \
  --restart=always \
  -p 80:80 \
  -e FORWARD_IP="20.27.177.113" \
  -e FORWARD_PORT="80" \
  -e CONTAINER_PORT="80" \
  huangsen365/nftables-forward

