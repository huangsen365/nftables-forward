#!/bin/sh

# GitHub 

docker run -d \
  --name=nftables-forward-443 \
  --cap-add=NET_ADMIN \
  --cap-add=SYS_MODULE \
  --restart=always \
  -p 443:443 \
  -e FORWARD_IP="20.27.177.113" \
  -e FORWARD_PORT="443" \
  -e CONTAINER_PORT="443" \
  huangsen365/nftables-forward

