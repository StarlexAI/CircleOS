# CircleOS ISO Build Instructions

## Overview

CircleOS uses Debian's `live-build` system (same as Lingmo OS) to create bootable ISO images. Due to container limitations in ChromeOS/Crostini, the ISO must be built on a native Linux system or VM.

## Requirements

- Native Debian/Ubuntu Linux system (not in a container)
- Root access (sudo)
- At least 10GB free disk space
- Internet connection

## Quick Build (Recommended)

### 1. Install Dependencies

```bash
sudo apt-get update
sudo apt-get install -y live-build debootstrap
```

### 2. Build CircleOS Binaries

```bash
./build.sh
```

### 3. Prepare Live-Build Environment

```bash
cd iso-build/circleos-live

# Copy CircleOS binaries
mkdir -p config/includes.chroot/tmp/circleos/{bin,lib}
find ../../build/apps -name "circleos-*" -type f -executable -exec cp {} config/includes.chroot/tmp/circleos/bin/ \;
find ../../build/desktop -name "circleos-*" -type f -executable -exec cp {} config/includes.chroot/tmp/circleos/bin/ \;
cp ../../build/core/*.so* config/includes.chroot/tmp/circleos/lib/
```

### 4. Configure and Build

```bash
# Configure
sudo ./auto/config

# Build ISO (this takes 15-30 minutes)
sudo ./auto/build
```

### 5. Find Your ISO

The ISO will be created in `iso-build/circleos-live/` with the name `circleos-1.0.0-amd64.iso`

## Test in QEMU

```bash
# Copy ISO to output directory
cp iso-build/circleos-live/circleos-1.0.0-amd64.iso iso-output/

# Run in QEMU
./scripts/run-qemu.sh
```

## Build System Structure

CircleOS follows the Lingmo OS approach:

```
iso-build/circleos-live/
├── auto/
│   ├── config          # Live-build configuration
│   ├── build           # Build script
│   └── clean           # Clean script
├── config/
│   ├── package-lists/
│   │   └── circleos.list.chroot    # Packages to install
│   ├── hooks/
│   │   └── normal/
│   │       └── 9000-install-circleos.hook.chroot  # Install CircleOS
│   └── includes.chroot/
│       └── tmp/circleos/           # CircleOS binaries
│           ├── bin/                # Applications
│           └── lib/                # Libraries
```

## Configuration Files

### auto/config

Defines the ISO configuration:
- Distribution: Debian Bookworm
- Architecture: amd64
- Bootloader: GRUB EFI
- Compression: xz
- Live system with no installer

### config/package-lists/circleos.list.chroot

Lists all Debian packages to install:
- System: systemd, dbus, udev
- Display: xorg, Qt6
- Network: network-manager
- Audio: pulseaudio
- Fonts: Roboto, Noto

### config/hooks/normal/9000-install-circleos.hook.chroot

Bash script that runs in the chroot to:
1. Copy CircleOS binaries to /usr/bin
2. Copy libraries to /usr/lib
3. Set permissions
4. Create desktop entries
5. Configure autostart

## Customization

### Add More Packages

Edit `config/package-lists/circleos.list.chroot`:

```bash
# Add your packages
firefox-esr
libreoffice
gimp
```

### Modify Boot Parameters

Edit `auto/config`:

```bash
--bootappend-live "boot=live components quiet splash your_param=value"
```

### Add Custom Files

Place files in `config/includes.chroot/` with the same directory structure:

```bash
# Example: Add custom wallpaper
mkdir -p config/includes.chroot/usr/share/backgrounds/
cp my-wallpaper.jpg config/includes.chroot/usr/share/backgrounds/
```

### Run Custom Scripts

Create hook scripts in `config/hooks/normal/`:

```bash
#!/bin/bash
# config/hooks/normal/9100-my-custom-setup.hook.chroot

echo "Running custom setup..."
# Your commands here
```

Make it executable:
```bash
chmod +x config/hooks/normal/9100-my-custom-setup.hook.chroot
```

## Troubleshooting

### "Operation not permitted" or "noexec/nodev" errors

This means you're in a container (like ChromeOS Crostini). You need:
- A native Linux installation
- A Linux VM (VirtualBox, VMware, KVM)
- A cloud Linux instance (AWS, DigitalOcean, etc.)

### "No space left on device"

Live-build needs at least 10GB free space. Clean up or use a larger disk.

### Build fails during package installation

Check your internet connection and try again. Sometimes mirrors are slow or temporarily unavailable.

### ISO boots but CircleOS doesn't start

Check the hook script ran successfully:
```bash
# In the chroot during build
ls -la /usr/bin/circleos-*
ls -la /usr/lib/libcircleos-*
```

## Advanced: Building on Cloud

### Using DigitalOcean

```bash
# Create a Debian 12 droplet
# SSH into it
ssh root@your-droplet-ip

# Clone repository
git clone https://github.com/yourusername/circleos.git
cd circleos

# Install dependencies
apt-get update
apt-get install -y build-essential cmake qt6-declarative-dev qt6-wayland-dev live-build

# Build
./build.sh
cd iso-build/circleos-live
sudo ./auto/config
sudo ./auto/build

# Download ISO
# On your local machine:
scp root@your-droplet-ip:~/circleos/iso-build/circleos-live/*.iso .
```

## References

- [Debian Live Manual](https://live-team.pages.debian.net/live-manual/)
- [Lingmo OS Build System](https://github.com/LingmoOS/lingmo-system-build)
- [Live-Build Documentation](https://manpages.debian.org/bookworm/live-build/lb.1.en.html)

## Support

For issues or questions:
- Check build.log in the circleos-live directory
- Review hook script output
- Verify all CircleOS binaries are in includes.chroot/tmp/circleos/

---

**Note**: The simple ISO builder (`build-simple-iso.sh`) creates a minimal ISO for testing but doesn't create a full bootable live system. Use the live-build method above for production ISOs.
