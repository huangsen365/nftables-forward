# nftables-forward

## **Overview**

The **nftables-forward** Docker container forwards traffic (e.g., SSH on port 22 or RDP on port 3389) to a target server using **nftables** for secure, controlled forwarding.

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

3. **Edit the target server IP:**  
   Replace `123.111.222.123` with the IP of your backend server.

4. **Run the script:**

   ```bash
   sh docker_run.sh
   ```

   This will forward SSH traffic from **port 2222 on the host** to **port 22 inside the container**.

---

## **How It Works**

- **Customize IP**: Modify the `FORWARD_IP` environment variable to point to your backend server's IP.
- **Run the Script**: Use `docker_run.sh` to start the forwarding.
- **Test**: Connect to the service (e.g., SSH) by pointing your SSH client to `localhost:2222`.

---

## **Examples**

### 1. **Forward SSH Traffic (Port 2222 → 22)**

For forwarding SSH traffic from port `2222` to port `22`, you can use this configuration:

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

### 2. **Forward RDP Traffic (Port 3389 → 3389)**

For forwarding RDP traffic to a server with IP `192.168.1.100`, use this configuration:

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

---

## **Additional Notes**

- **Ports (`-p` flag)**: The `-p` flag maps a port on the host to a port inside the container.  
  For example, `-p 2222:22` forwards SSH traffic from **host port 2222** to **container port 22**, allowing SSH access on `localhost:2222` to be forwarded to the backend server on port 22.

- **Customization**: Feel free to adjust environment variables like `FORWARD_PORT` and `CONTAINER_PORT` as needed to match your specific use case.
