#!/bin/bash

# Script to harden a Linux server

# Update the system
echo "Updating the system..."
apt update && apt upgrade -y

# Install necessary packages
echo "Installing necessary packages..."
apt install -y ufw fail2ban

# Set up UFW (Uncomplicated Firewall)
echo "Setting up the firewall..."
ufw default deny incoming
ufw default allow outgoing

# Allow SSH (change port if necessary)
SSH_PORT=22
echo "Allowing SSH on port $SSH_PORT..."
ufw allow $SSH_PORT

# Allow other necessary ports (e.g., HTTP, HTTPS)
ufw allow 80/tcp
ufw allow 443/tcp

# Enable the firewall
echo "Enabling the firewall..."
ufw enable

# Disable root login via SSH
echo "Disabling root login via SSH..."
sed -i 's/^PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
systemctl restart sshd

# Set up Fail2Ban
echo "Setting up Fail2Ban..."
systemctl enable fail2ban
systemctl start fail2ban

# Disable unused services
echo "Disabling unused services..."
systemctl disable avahi-daemon
systemctl stop avahi-daemon

# Set up automatic security updates
echo "Setting up automatic security updates..."
apt install -y unattended-upgrades
dpkg-reconfigure --priority=low unattended-upgrades

# Set password policies
echo "Setting password policies..."
cat <<EOL >> /etc/login.defs
PASS_MAX_DAYS   90
PASS_MIN_DAYS   10
PASS_MIN_LEN    12
EOL

# Set up user privilege management
echo "Setting up user privilege management..."
# Add a new user (replace 'newuser' with your desired username)
NEW_USER="newuser"
adduser $NEW_USER
usermod -aG sudo $NEW_USER

# Disable unused network protocols
echo "Disabling unused network protocols..."
echo "net.ipv4.conf.all.rp_filter = 1" >> /etc/sysctl.conf
echo "net.ipv4.conf.default.rp_filter = 1" >> /etc/sysctl.conf
sysctl -p

# Set file permissions
echo "Setting file permissions..."
chmod 700 /root
chmod 600 /etc/shadow

# Log all sudo commands
echo "Logging all sudo commands..."
echo "Defaults logfile=/var/log/sudo.log" >> /etc/sudoers

# Final message
echo "Linux hardening script completed. Please review the changes made."
