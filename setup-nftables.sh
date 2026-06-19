#!/bin/sh
# nftables-forward — DNAT + masquerade a port to a backend server.
# Forwards BOTH TCP and UDP by default. Override with PROTOCOLS (e.g. PROTOCOLS="tcp").
# Project: https://github.com/huangsen365/nftables-forward

if [ -z "$FORWARD_IP" ] || [ -z "$FORWARD_PORT" ] || [ -z "$CONTAINER_PORT" ]; then
  echo 'Error: FORWARD_IP, FORWARD_PORT, and CONTAINER_PORT must be set.' >&2
  exit 1
fi

# Protocols to forward (space-separated). Default: tcp + udp.
PROTOCOLS="${PROTOCOLS:-tcp udp}"

nft add table ip nat
nft add chain ip nat prerouting { type nat hook prerouting priority 0 \; }
nft add chain ip nat postrouting { type nat hook postrouting priority 100 \; }

for proto in $PROTOCOLS; do
  nft add rule ip nat prerouting $proto dport $CONTAINER_PORT dnat to $FORWARD_IP:$FORWARD_PORT
  nft add rule ip nat postrouting ip daddr $FORWARD_IP $proto dport $FORWARD_PORT masquerade
done

echo "nftables-forward: [$PROTOCOLS] dport $CONTAINER_PORT -> $FORWARD_IP:$FORWARD_PORT"
