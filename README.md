# nftables-forward

## **Overview**

The **nftables-forward** Docker container forwards traffic (e.g., RDP on port 3389 or SSH on port 22) to a target server, leveraging **nftables** for secure, controlled forwarding.

---

## **Quick Start**

1. **Edit the script with `vim`:**

   ```bash
   vim docker_run.sh
   ```

2. **Insert the following command into `docker_run.sh`:**

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

3. **Edit the target server IP:**  
   Replace `123.123.123.123` with your backend server's IP.

4. **Run the script:**

   ```bash
   sh docker_run.sh
   ```

---

## **How It Works**

- **Customize IP**: Change `FORWARD_IP` to your backend server's IP.
- **Run the Script**: Use `docker_run.sh` to start forwarding traffic.
- **Test**: Connect to the forwarded service (e.g., RDP on `localhost:3389`).

---

## **Examples**

### 1. **Forward RDP Traffic (Port 3389)**

For forwarding RDP traffic to a server with IP `192.168.1.100`:

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

### 2. **Forward SSH Traffic (Port 2222 → 22)**

For forwarding SSH traffic from port `2222` to port `22`:

```bash
#!/bin/sh

docker run -d \
  --name=nftables-forward-ssh-2222 \
  --cap-add=NET_ADMIN \
  --cap-add=SYS_MODULE \
  --restart=always \
  -p 2222:22 \
  -e FORWARD_IP="123.111.222.123" \
  -e FORWARD_PORT="22" \
  -e CONTAINER_PORT="22" \
  huangsen365/nftables-forward
```

---

## **Additional Notes**

- **Ports (`-p` flag)**: The `-p` flag maps a port on the host to a port inside the container.  
  For example, `-p 2222:22` forwards SSH traffic from **host port 2222** to **container port 22**.  
  This allows SSH access on `localhost:2222` to be forwarded to the backend server on port 22.
  
- **Customization**: Adjust environment variables as needed (e.g., `FORWARD_PORT`, `CONTAINER_PORT`) for your use case.
