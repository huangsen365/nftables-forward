# Project link: https://github.com/huangsen365/nftables-forward

# Use a minimal base image
FROM alpine:latest

# Install nftables
RUN apk add --no-cache nftables

# Define environment variables (default to empty for flexibility)
ENV FORWARD_IP=""
ENV FORWARD_PORT=""
ENV CONTAINER_PORT=""
# Protocols to forward (default: both TCP and UDP). Override with e.g. PROTOCOLS="tcp".
ENV PROTOCOLS="tcp udp"

# Install the forwarding setup script (forwards both TCP and UDP by default)
COPY setup-nftables.sh /usr/local/bin/setup-nftables.sh
RUN chmod +x /usr/local/bin/setup-nftables.sh

# Set up the entrypoint to apply nftables rules
CMD ["sh", "-c", "/usr/local/bin/setup-nftables.sh && tail -f /dev/null"]
