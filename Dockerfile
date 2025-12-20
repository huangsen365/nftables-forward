# Project link: https://github.com/huangsen365/nftables-forward

# Use a minimal base image
FROM alpine:latest

# Install nftables
RUN apk add --no-cache nftables

# Define environment variables (default to empty for flexibility)
ENV FORWARD_IP=""
ENV FORWARD_PORT=""
ENV CONTAINER_PORT=""

# Create a dynamic nftables configuration script
RUN echo "#!/bin/sh" > /usr/local/bin/setup-nftables.sh && \
    echo "if [ -z \"\$FORWARD_IP\" ] || [ -z \"\$FORWARD_PORT\" ] || [ -z \"\$CONTAINER_PORT\" ]; then" >> /usr/local/bin/setup-nftables.sh && \
    echo "  echo 'Error: FORWARD_IP, FORWARD_PORT, and CONTAINER_PORT must be set.' >&2; exit 1;" >> /usr/local/bin/setup-nftables.sh && \
    echo "fi" >> /usr/local/bin/setup-nftables.sh && \
    echo "nft add table ip nat" >> /usr/local/bin/setup-nftables.sh && \
    echo "nft add chain ip nat prerouting { type nat hook prerouting priority 0 \\; }" >> /usr/local/bin/setup-nftables.sh && \
    echo "nft add chain ip nat postrouting { type nat hook postrouting priority 100 \\; }" >> /usr/local/bin/setup-nftables.sh && \
    echo "nft add rule ip nat prerouting tcp dport \$CONTAINER_PORT dnat to \$FORWARD_IP:\$FORWARD_PORT" >> /usr/local/bin/setup-nftables.sh && \
    echo "nft add rule ip nat postrouting ip daddr \$FORWARD_IP tcp dport \$FORWARD_PORT masquerade" >> /usr/local/bin/setup-nftables.sh && \
    chmod +x /usr/local/bin/setup-nftables.sh

# Set up the entrypoint to apply nftables rules
CMD ["sh", "-c", "/usr/local/bin/setup-nftables.sh && tail -f /dev/null"]
