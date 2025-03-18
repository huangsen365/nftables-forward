# nftables-forward

# **Docker Command for nftables-forward Container: 3389 RDP Example**

## **Overview**

This command forwards RDP traffic (port 3389) from the **nftables-forward server** to a target RDP server.

## **Command**

```bash
#!/bin/sh

docker run -d \
  --name=nftables-forward \
  --cap-add=NET_ADMIN \
  --cap-add=SYS_MODULE \
  --restart=always \
  -p 3389:3389 \
  -e FORWARD_IP="123.123.123.123" \
  -e FORWARD_PORT="3389" \
  -e CONTAINER_PORT="3389" \
  huangsen365/nftables-forward
```

## **How to Use**

1. **Customize IP**: Replace `123.123.123.123` with the backend server's IP.
2. **Run Command**: Execute on **nftables-forward server** to start forwarding.
3. **Test**: Connect to `nftables-forward_server:3389` (e.g., `localhost:3389`) for RDP.

---

## **Example**

For target server `192.168.1.100`:

```bash
#!/bin/sh

docker run -d \
  --name=nftables-forward \
  --cap-add=NET_ADMIN \
  --cap-add=SYS_MODULE \
  --restart=always \
  -p 3389:3389 \
  -e FORWARD_IP="192.168.1.100" \
  -e FORWARD_PORT="3389" \
  -e CONTAINER_PORT="3389" \
  huangsen365/nftables-forward
```
