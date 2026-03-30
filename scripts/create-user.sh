#!/bin/bash
# CircleOS User Creation Script

set -e

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

echo "🔵 CircleOS User Setup"
echo "====================="

read -p "Enter username: " USERNAME
read -s -p "Enter password: " PASSWORD
echo

# Create user
useradd -m -s /bin/bash -G sudo,audio,video,input "$USERNAME"
echo "$USERNAME:$PASSWORD" | chpasswd

# Create user directories
sudo -u "$USERNAME" mkdir -p "/home/$USERNAME"/{Documents,Downloads,Pictures,Music,Videos,Desktop}

# Set up user configuration
sudo -u "$USERNAME" mkdir -p "/home/$USERNAME/.config/circleos"
sudo -u "$USERNAME" mkdir -p "/home/$USERNAME/.local/share/circleos"

# Copy default configuration
if [ -d "/etc/skel/.config/circleos" ]; then
    cp -r /etc/skel/.config/circleos "/home/$USERNAME/.config/"
    chown -R "$USERNAME:$USERNAME" "/home/$USERNAME/.config/circleos"
fi

echo "✅ User $USERNAME created successfully"
echo "   Home: /home/$USERNAME"
echo "   Groups: sudo, audio, video, input"
