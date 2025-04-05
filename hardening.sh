#!/bin/bash

VERSION="1.0.0-Beta"

if [[ "$1" == "--version" || "$1" == "-v" ]]; then
  echo "Linux Hardening Script - Version $VERSION"
  echo "       ______________"
  echo "  ___ / =======  [] \\___________"
  echo " |___ | Linux Hardening TANK 💥  \\"
  echo "     \\___________________________>"
  echo "     /   (_)   (_)   (_)   (_)   \\"
  echo "  __/_____________________________\\__"
  echo " |___________________________________|"
  echo "     Cenzer00 DEFENSE SYSTEMS "
  echo "    🐧 Securing Linux Like a Battle Tank!"

  exit 0
fi

# ===================================================================
# 🐧 Linux Server Hardening Script 🐧
# Target: Ubuntu (but works on most Debian-based distros)(maybe:xixiixi)
# Author: Cenzer0.
# "Time to fortify this server into a war-ready tank!"
# ===================================================================

echo "=============================================="
echo "   🐧 Linux Server Hardening - Ubuntu Style   "
echo "     Securing your system like a pro!        "
echo "=============================================="


# Check if run as root
if [ "$EUID" -ne 0 ]; then
  echo "❌ Please run as root"
  exit 1
fi

# Update and Upgrade
echo "📦 Updating system..."
apt update && apt upgrade -y

# Disable unused services
echo "👾 Disabling unused services..."
systemctl disable avahi-daemon
systemctl stop avahi-daemon

# Enable UFW (Uncomplicated Firewall)
echo "🔥 Configuring UFW firewall..."
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw enable

# Allow SSH (change port if necessary)
SSH_PORT=22
echo "->....Allowing SSH on port $SSH_PORT..."
ufw allow $SSH_PORT

# Install Fail2Ban
echo "🚨 Installing Fail2Ban..."
apt install -y fail2ban
systemctl enable fail2ban
systemctl start fail2ban

# SSH Config Hardening
echo "🔐 Hardening SSH configuration..."
sed -i 's/^#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
systemctl restart sshd

# Secure shared memory
echo "🧠 Securing shared memory..."
echo "tmpfs /run/shm tmpfs defaults,noexec,nosuid 0 0" >> /etc/fstab
mount -o remount /run/shm

# Create a new user with sudo access
echo "👤 Creating secure sudo user..."
read -p "Enter new username: " newuser
adduser "$newuser"
usermod -aG sudo "$newuser"

# Install & configure automatic updates
echo "🔄 Enabling automatic updates..."
apt install -y unattended-upgrades
dpkg-reconfigure -plow unattended-upgrades

# ClamAV for antivirus (optional)
echo "🛡️ Installing ClamAV antivirus..."
apt install -y clamav clamav-daemon
freshclam
systemctl enable clamav-freshclam
systemctl start clamav-freshclam

# Allow other necessary ports (e.g., HTTP, HTTPS)
echo "❄️ Allowing Port Firewall"
ufw allow 80/tcp
ufw allow 443/tcp

# Log all sudo commands
echo "⚡️ Logging all sudo commands..."
echo "Defaults logfile=/var/log/sudo.log" >> /etc/sudoers

# Final Message
echo "✅ Hardening complete. Please:"
echo "1. Use 'ssh -p 22 user@your_server' to connect next time."
echo "2. Double-check your UFW and SSH settings."
echo "3. Reboot your server for all changes to apply."

echo "🚀 Let's Go Battle, $USER!"

# EOF
