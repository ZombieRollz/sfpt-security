#!/bin/bash

# Ensure the script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "[-] This script must be run as root. Exiting..."
   exit 1
fi

# Enable UFW
echo "[+] Enabling UFW..."
ufw enable

# Allow SFTP (Port 22)
echo "[+] Allowing SSH/SFTP traffic on port 22..."
ufw allow 22/tcp

# Restrict SFTP to Internal Network (Replace 't' with your team number)
TEAM_NUMBER=56  # Change this to match your team number
INTERNAL_NET="192.168.${TEAM_NUMBER}.0/24"
echo "[+] Restricting SFTP access to internal network: $INTERNAL_NET"
ufw allow from $INTERNAL_NET to any port 22

# Set Default Deny Policy
echo "[+] Setting default deny policy..."
ufw default deny incoming
ufw default allow outgoing

# Check UFW Status
echo "[+] Checking UFW status..."
ufw status verbose

# Restart UFW
echo "[+] Restarting UFW..."
ufw reload

echo "[✓] UFW setup completed successfully!"
