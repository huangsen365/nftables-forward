# nftables-forward

## **Overview**

The **nftables-forward** Docker container forwards traffic from the specified port (e.g., RDP on port 3389) to a target server. This is useful for setting up secure, controlled forwarding via **nftables** on your host machine.

---

## **Quick Start: Run the Example Command**

To quickly get started, you can edit and execute the following Docker command:

1. **Edit the script using `vim`:**

   ```bash
   vim docker_run.sh
   ```

2. **Insert the example command into the `docker_run.sh` file:**

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
   Replace `123.123.123.123` with the actual IP address of your backend server. You can do this by opening the file in `vim` and using the `:%s/123.123.123.123/your_target_ip/g` command to replace it globally in the file.

4. **Run the script to start forwarding traffic:**

   ```bash
   sh docker_run.sh
   ```

---

## **How It Works**

1. **Customize the IP Address**: Modify the `FORWARD_IP` variable to point to your backend server's IP (e.g., `192.168.1.100` for an internal RDP server).
   
2. **Start the Forwarding**: Run the `docker_run.sh` script on your **nftables-forward server** to initiate the port forwarding. This will make your target RDP server accessible from the **nftables-forward** server.

3. **Test the Setup**: Once the container is running, connect to your RDP server by pointing your RDP client to `nftables-forward_server:3389` (e.g., `localhost:3389`).

---

## **Example Usage**

For forwarding RDP traffic to a server with IP `192.168.1.100`, you can use this configuration:

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

- **Ports**: You can modify the port forwarding by adjusting the `-p` flag (e.g., `-p 8080:3389` to forward port 8080 on the host to port 3389 inside the container).
- **Customization**: Feel free to adjust any environment variable as needed (e.g., `FORWARD_PORT`, `CONTAINER_PORT`) to match your specific use case.
