# CircleOS Installation Guide

## System Requirements

### Minimum Requirements
- 64-bit x86 processor (amd64)
- 2 GB RAM
- 20 GB disk space
- Graphics card with OpenGL 3.3 support

### Recommended Requirements
- 64-bit x86 processor with 4+ cores
- 4 GB RAM or more
- 40 GB disk space
- Graphics card with Vulkan support
- UEFI firmware

## Installation Methods

### Method 1: Install from ISO (Recommended)

1. Download the latest CircleOS ISO from the releases page
2. Create a bootable USB drive:
   ```bash
   sudo dd if=circleos-1.0.0-amd64.iso of=/dev/sdX bs=4M status=progress
   sync
   ```
3. Boot from the USB drive
4. Follow the graphical installer (Calamares)

### Method 2: Build from Source

#### Prerequisites
```bash
sudo apt update
sudo apt install -y \
    qt6-base-dev \
    qt6-wayland-dev \
    qt6-declarative-dev \
    cmake \
    build-essential \
    git \
    libsystemd-dev \
    libdbus-1-dev \
    libwayland-dev \
    wayland-protocols \
    debootstrap \
    xorriso \
    squashfs-tools
```

#### Build Steps
```bash
# Clone repository
git clone https://github.com/circleos/circleos.git
cd circleos

# Build the system
./build.sh

# Build ISO (requires root)
sudo ./build.sh --full
```

#### Install to System
```bash
cd build
sudo make install
```

### Method 3: Test in QEMU

```bash
# After building the ISO
./scripts/run-qemu.sh
```

## Post-Installation

### Update System
```bash
sudo apt update
sudo apt upgrade
```

### Install Additional Software
Use the CircleOS Store or apt:
```bash
sudo apt install firefox libreoffice gimp
```

### Configure Display
Settings → Display → Configure resolution and scaling

### Set Up User Account
Settings → Users → Add or modify user accounts

## Troubleshooting

### Boot Issues
- Ensure Secure Boot is disabled in UEFI
- Try booting in legacy BIOS mode if UEFI fails

### Graphics Issues
- Boot with `nomodeset` kernel parameter
- Install proprietary drivers if needed

### Network Issues
- Check NetworkManager status: `systemctl status NetworkManager`
- Restart network: `sudo systemctl restart NetworkManager`

## Getting Help

- Documentation: https://circleos.org/docs
- Forum: https://forum.circleos.org
- Issue Tracker: https://github.com/circleos/circleos/issues
