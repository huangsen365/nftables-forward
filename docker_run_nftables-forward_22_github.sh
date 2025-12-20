#!/bin/sh

# GitHub 

docker run -d \
  --name=nftables-forward-22 \
  --cap-add=NET_ADMIN \
  --cap-add=SYS_MODULE \
  --restart=always \
  -p 22:22 \
  -e FORWARD_IP="20.27.177.113" \
  -e FORWARD_PORT="22" \
  -e CONTAINER_PORT="22" \
  huangsen365/nftables-forward

