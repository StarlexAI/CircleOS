#!/bin/bash
set -e

# CircleOS QEMU Runner
# Runs the ISO in QEMU for testing

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
ISO_DIR="${PROJECT_ROOT}/iso-output"

echo "🖥️  CircleOS QEMU Runner"
echo "======================="

# Check for QEMU
command -v qemu-system-x86_64 >/dev/null 2>&1 || {
    echo "Error: qemu-system-x86_64 not found"
    echo "Install with: sudo apt install qemu-system-x86"
    exit 1
}

# Find ISO
ISO_FILE=$(find "${ISO_DIR}" -name "circleos-*.iso" -type f | head -n 1)

if [ -z "$ISO_FILE" ]; then
    echo "Error: No ISO file found in ${ISO_DIR}"
    echo "Run './build.sh --full' first to build the ISO"
    exit 1
fi

echo "📀 Using ISO: $(basename "$ISO_FILE")"

# QEMU parameters
MEMORY="4G"
CPUS="4"
DISK_SIZE="20G"
DISK_FILE="${PROJECT_ROOT}/iso-output/circleos-disk.qcow2"

# Create virtual disk if it doesn't exist
if [ ! -f "$DISK_FILE" ]; then
    echo "💾 Creating virtual disk (${DISK_SIZE})..."
    qemu-img create -f qcow2 "$DISK_FILE" "$DISK_SIZE"
fi

# Check for KVM support
KVM_OPTS=""
if [ -e /dev/kvm ] && [ -r /dev/kvm ] && [ -w /dev/kvm ]; then
    echo "✅ KVM acceleration enabled"
    KVM_OPTS="-enable-kvm -cpu host"
else
    echo "⚠️  KVM not available, using software emulation (slower)"
    KVM_OPTS="-cpu qemu64"
fi

echo "🚀 Starting QEMU..."
echo "   Memory: ${MEMORY}"
echo "   CPUs: ${CPUS}"
echo ""
echo "Press Ctrl+Alt+G to release mouse/keyboard"
echo "Press Ctrl+Alt+F to toggle fullscreen"
echo ""

# Run QEMU
qemu-system-x86_64 \
    ${KVM_OPTS} \
    -m "${MEMORY}" \
    -smp "${CPUS}" \
    -cdrom "${ISO_FILE}" \
    -drive file="${DISK_FILE}",format=qcow2,if=virtio \
    -boot d \
    -vga virtio \
    -display gtk,gl=on \
    -device virtio-net-pci,netdev=net0 \
    -netdev user,id=net0 \
    -device intel-hda \
    -device hda-duplex \
    -usb \
    -device usb-tablet \
    -rtc base=localtime,clock=host \
    -name "CircleOS" \
    "$@"

echo ""
echo "✅ QEMU session ended"
