# nftables-forward

## **Overview**
- **Github**: https://github.com/huangsen365/nftables-forward
- **Docker Hub**: https://hub.docker.com/r/huangsen365/nftables-forward
  ```
  docker pull huangsen365/nftables-forward
  ```

The **nftables-forward** Docker container forwards traffic (e.g., SSH on port 22 or RDP on port 3389 or more other custom ports) to a target server using **nftables** for secure, controlled forwarding.

By default it forwards **both TCP and UDP**. To restrict to one protocol, set the `PROTOCOLS`
environment variable (e.g. `-e PROTOCOLS="tcp"`). Important: the container only *receives* a protocol
that you also publish with Docker's `-p` flag — `-p PORT:PORT` publishes **TCP only**, so for UDP you
must additionally pass `-p PORT:PORT/udp` (see [UDP forwarding](#udp-forwarding) below).

---

## **Quick Start**

1. **Edit the script with `vim`:**

   ```bash
   vim docker_run_nftables-forward.sh
   ```

2. **Insert the following command into `docker_run_nftables-forward.sh`:**

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
   sh docker_run_nftables-forward.sh
   ```

This will forward SSH traffic from **port 2222 on the host** to **port 22 inside the container**.

---

## **Build the Docker Image**

If you prefer to build the image yourself instead of pulling from Docker Hub, run:

```bash
docker build -t my-nftables-forward .
```

You can replace `my-nftables-forward` with any tag you like. Use this tag in the examples below if you built the image locally.

---

## **How It Works**

- **Customize IP**: Modify the `FORWARD_IP` environment variable to point to your backend server's IP.
- **Run the Script**: Use `docker_run_nftables-forward.sh` to start the forwarding.
- **Test**: Connect to the service (e.g., SSH) by pointing your SSH client to `localhost:2222`.

---

## **More Examples**

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
  --name=nftables-forward-3389 \
  --cap-add=NET_ADMIN \
  --cap-add=SYS_MODULE \
  --restart=always \
  -p 3389:3389 \
  -e FORWARD_IP="192.168.1.100" \
  -e FORWARD_PORT="3389" \
  -e CONTAINER_PORT="3389" \
  huangsen365/nftables-forward
```

### 3. **Forward MySQL Traffic (Port 3306 → 3306)**

After building your own image (e.g., `docker build -t my-nftables-forward .`), you can forward MySQL traffic using that tag:

```bash
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
```

---

## **UDP forwarding**

The image forwards **both TCP and UDP** by default. UDP only reaches the container if you publish the
UDP port too, so add a second `-p PORT:PORT/udp` mapping alongside the TCP one. This is required for
UDP-based services such as DNS, WireGuard, QUIC, or game servers.

DNS is a good example since it uses both TCP and UDP on port 53:

```bash
#!/bin/sh

docker run -d \
  --name=nftables-forward-dns-53 \
  --cap-add=NET_ADMIN \
  --cap-add=SYS_MODULE \
  --restart=always \
  -p 53:53/tcp \
  -p 53:53/udp \
  -e FORWARD_IP="123.111.222.123" \
  -e FORWARD_PORT="53" \
  -e CONTAINER_PORT="53" \
  huangsen365/nftables-forward
```

To forward **TCP only** (e.g. for SSH/HTTP), keep a single `-p PORT:PORT` mapping and optionally set
`-e PROTOCOLS="tcp"` so the container skips the UDP rules entirely:

```bash
  -p 2222:22 \
  -e PROTOCOLS="tcp" \
```

---

## **Additional Notes**

- **Ports (`-p` flag)**: The `-p` flag maps a port on the host to a port inside the container.  
  For example, `-p 2222:22` forwards SSH traffic from **host port 2222** to **container port 22**, allowing SSH access on `localhost:2222` to be forwarded to the backend server on port 22.  
  `-p PORT:PORT` publishes **TCP only**; add `-p PORT:PORT/udp` to also receive UDP.

- **Protocols (`PROTOCOLS` env)**: Controls which protocols the container's nftables rules forward.
  Defaults to `tcp udp` (both). Set `-e PROTOCOLS="tcp"` or `-e PROTOCOLS="udp"` to limit it.

- **Customization**: Feel free to adjust environment variables like `FORWARD_PORT` and `CONTAINER_PORT` as needed to match your specific use case.
