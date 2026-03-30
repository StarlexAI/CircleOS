#!/bin/bash
set -e

# CircleOS ISO Builder
# Builds a bootable ISO image with the complete OS

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
ISO_DIR="${PROJECT_ROOT}/iso"
BUILD_DIR="${PROJECT_ROOT}/build"
WORK_DIR="${ISO_DIR}/work"
OUTPUT_DIR="${ISO_DIR}/output"

echo "💿 CircleOS ISO Builder"
echo "======================="

# Check dependencies
command -v debootstrap >/dev/null 2>&1 || { echo "Error: debootstrap not found"; exit 1; }
command -v xorriso >/dev/null 2>&1 || { echo "Error: xorriso not found"; exit 1; }
command -v mksquashfs >/dev/null 2>&1 || { echo "Error: squashfs-tools not found"; exit 1; }

# Clean and create directories
echo "📁 Preparing directories..."
rm -rf "${WORK_DIR}"
mkdir -p "${WORK_DIR}"/{chroot,iso,scratch}
mkdir -p "${OUTPUT_DIR}"

# Bootstrap Debian base system
echo "📦 Bootstrapping Debian base system..."
sudo debootstrap \
    --arch=amd64 \
    --variant=minbase \
    bookworm \
    "${WORK_DIR}/chroot" \
    http://deb.debian.org/debian/

# Configure base system
echo "⚙️  Configuring base system..."
sudo chroot "${WORK_DIR}/chroot" /bin/bash <<'CHROOT_EOF'
# Set hostname
echo "circleos" > /etc/hostname

# Configure apt sources
cat > /etc/apt/sources.list <<EOF
deb http://deb.debian.org/debian bookworm main contrib non-free non-free-firmware
deb http://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware
deb http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware
EOF

# Update and install essential packages
apt-get update
apt-get install -y \
    linux-image-amd64 \
    linux-headers-amd64 \
    systemd \
    systemd-sysv \
    dbus \
    network-manager \
    firmware-linux-free \
    firmware-linux-nonfree \
    grub-pc \
    grub-efi-amd64 \
    os-prober \
    sudo \
    bash-completion

# Install Qt6 and dependencies
apt-get install -y \
    qt6-base-dev \
    qt6-wayland \
    qml6-module-qtquick \
    qml6-module-qtquick-controls \
    qml6-module-qtquick-layouts \
    libqt6svg6 \
    cmake \
    build-essential \
    git

# Install Wayland and graphics
apt-get install -y \
    wayland-protocols \
    libwayland-dev \
    mesa-utils \
    xwayland

# Clean apt cache
apt-get clean
CHROOT_EOF

# Copy CircleOS files
echo "📋 Installing CircleOS components..."
sudo cp -r "${BUILD_DIR}/staging/"* "${WORK_DIR}/chroot/"

# Configure systemd services
echo "🔧 Configuring systemd services..."
sudo tee "${WORK_DIR}/chroot/etc/systemd/system/circleos-shell.service" > /dev/null <<'EOF'
[Unit]
Description=CircleOS Desktop Shell
After=graphical.target

[Service]
Type=simple
ExecStart=/usr/bin/circleos-shell
Restart=always
User=circleos
Environment=QT_QPA_PLATFORM=wayland
Environment=XDG_SESSION_TYPE=wayland

[Install]
WantedBy=graphical.target
EOF

# Enable services
sudo chroot "${WORK_DIR}/chroot" systemctl enable circleos-shell.service
sudo chroot "${WORK_DIR}/chroot" systemctl enable NetworkManager.service

# Create live user
echo "👤 Creating live user..."
sudo chroot "${WORK_DIR}/chroot" /bin/bash <<'EOF'
useradd -m -s /bin/bash -G sudo circleos
echo "circleos:circleos" | chpasswd
echo "circleos ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/circleos
EOF

# Create squashfs filesystem
echo "🗜️  Creating squashfs filesystem..."
sudo mksquashfs \
    "${WORK_DIR}/chroot" \
    "${WORK_DIR}/iso/live/filesystem.squashfs" \
    -comp xz \
    -b 1M \
    -Xdict-size 100%

# Copy kernel and initrd
echo "🔧 Copying kernel and initrd..."
sudo cp "${WORK_DIR}/chroot/boot/vmlinuz-"* "${WORK_DIR}/iso/live/vmlinuz"
sudo cp "${WORK_DIR}/chroot/boot/initrd.img-"* "${WORK_DIR}/iso/live/initrd"

# Create GRUB configuration
echo "📝 Creating GRUB configuration..."
mkdir -p "${WORK_DIR}/iso/boot/grub"
cat > "${WORK_DIR}/iso/boot/grub/grub.cfg" <<'EOF'
set timeout=10
set default=0

menuentry "CircleOS Live" {
    linux /live/vmlinuz boot=live quiet splash
    initrd /live/initrd
}

menuentry "CircleOS Live (Safe Mode)" {
    linux /live/vmlinuz boot=live nomodeset
    initrd /live/initrd
}

menuentry "Install CircleOS" {
    linux /live/vmlinuz boot=live quiet splash calamares
    initrd /live/initrd
}
EOF

# Copy GRUB theme
cp -r "${PROJECT_ROOT}/bootloader/grub/"* "${WORK_DIR}/iso/boot/grub/"

# Create ISO
echo "💿 Creating ISO image..."
ISO_NAME="circleos-1.0.0-amd64.iso"
xorriso -as mkisofs \
    -iso-level 3 \
    -full-iso9660-filenames \
    -volid "CircleOS" \
    -appid "CircleOS 1.0.0" \
    -publisher "CircleOS Team" \
    -preparer "CircleOS Build System" \
    -eltorito-boot boot/grub/i386-pc/eltorito.img \
    -no-emul-boot \
    -boot-load-size 4 \
    -boot-info-table \
    --eltorito-catalog boot/grub/boot.cat \
    --grub2-boot-info \
    --grub2-mbr "${WORK_DIR}/chroot/usr/lib/grub/i386-pc/boot_hybrid.img" \
    -eltorito-alt-boot \
    -e EFI/efiboot.img \
    -no-emul-boot \
    -append_partition 2 0xef "${WORK_DIR}/iso/EFI/efiboot.img" \
    -output "${OUTPUT_DIR}/${ISO_NAME}" \
    -graft-points \
        "${WORK_DIR}/iso" \
        /boot/grub/bios.img="${WORK_DIR}/chroot/usr/lib/grub/i386-pc/bios.img"

# Calculate checksums
echo "🔐 Calculating checksums..."
cd "${OUTPUT_DIR}"
sha256sum "${ISO_NAME}" > "${ISO_NAME}.sha256"
md5sum "${ISO_NAME}" > "${ISO_NAME}.md5"

echo "✅ ISO build complete!"
echo "📍 Location: ${OUTPUT_DIR}/${ISO_NAME}"
echo "📊 Size: $(du -h "${OUTPUT_DIR}/${ISO_NAME}" | cut -f1)"
