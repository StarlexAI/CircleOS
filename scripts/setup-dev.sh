#!/bin/bash
set -e

# CircleOS Development Environment Setup

echo "🔧 CircleOS Development Setup"
echo "=============================="

# Check OS
if [ ! -f /etc/debian_version ]; then
    echo "⚠️  Warning: This script is designed for Debian-based systems"
    read -p "Continue anyway? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Update package list
echo "📦 Updating package list..."
sudo apt update

# Install build dependencies
echo "🔨 Installing build dependencies..."
sudo apt install -y \
    qt6-base-dev \
    qt6-wayland-dev \
    qt6-declarative-dev \
    qt6-tools-dev \
    qt6-tools-dev-tools \
    cmake \
    ninja-build \
    build-essential \
    git \
    clang \
    clang-format \
    clang-tidy \
    libsystemd-dev \
    libdbus-1-dev \
    libwayland-dev \
    wayland-protocols \
    pkg-config

# Install ISO building tools (optional)
read -p "Install ISO building tools? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "💿 Installing ISO building tools..."
    sudo apt install -y \
        debootstrap \
        xorriso \
        squashfs-tools \
        grub-pc-bin \
        grub-efi-amd64-bin
fi

# Install QEMU for testing (optional)
read -p "Install QEMU for testing? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🖥️  Installing QEMU..."
    sudo apt install -y \
        qemu-system-x86 \
        qemu-utils \
        ovmf
fi

# Install Qt Creator (optional)
read -p "Install Qt Creator IDE? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🎨 Installing Qt Creator..."
    sudo apt install -y qtcreator
fi

# Setup Git hooks
echo "🔗 Setting up Git hooks..."
mkdir -p .git/hooks

cat > .git/hooks/pre-commit <<'EOF'
#!/bin/bash
# Format C++ files with clang-format
for file in $(git diff --cached --name-only --diff-filter=ACM | grep -E '\.(cpp|h)$'); do
    clang-format -i "$file"
    git add "$file"
done
EOF

chmod +x .git/hooks/pre-commit

echo ""
echo "✅ Development environment setup complete!"
echo ""
echo "Next steps:"
echo "  1. Build the project: ./build.sh"
echo "  2. Open in Qt Creator: qtcreator CMakeLists.txt"
echo "  3. Read CONTRIBUTING.md for guidelines"
