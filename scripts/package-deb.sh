#!/bin/bash
set -e

# CircleOS Debian Package Builder

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
BUILD_DIR="${PROJECT_ROOT}/build"
PACKAGE_DIR="${BUILD_DIR}/package"

VERSION="1.0.0"
ARCH="amd64"
PACKAGE_NAME="circleos_${VERSION}_${ARCH}"

echo "📦 CircleOS Debian Package Builder"
echo "==================================="

# Check if build exists
if [ ! -d "$BUILD_DIR" ]; then
    echo "Error: Build directory not found. Run ./build.sh first"
    exit 1
fi

# Create package structure
echo "📁 Creating package structure..."
rm -rf "$PACKAGE_DIR"
mkdir -p "$PACKAGE_DIR"/{DEBIAN,usr,etc}

# Copy built files
echo "📋 Copying files..."
cp -r "$BUILD_DIR/staging/"* "$PACKAGE_DIR/"

# Create DEBIAN/control
cat > "$PACKAGE_DIR/DEBIAN/control" <<EOF
Package: circleos
Version: $VERSION
Section: x11
Priority: optional
Architecture: $ARCH
Depends: qt6-base (>= 6.2), qt6-wayland, systemd, dbus, network-manager
Maintainer: CircleOS Team <team@circleos.org>
Description: Modern circular UI Linux distribution
 CircleOS is a complete desktop environment featuring a modern
 circular UI design, built on Debian GNU/Linux with Qt/QML.
 .
 Features:
  - Modern circular UI design
  - Wayland compositor
  - Full desktop environment
  - System applications
Homepage: https://circleos.org
EOF

# Create postinst script
cat > "$PACKAGE_DIR/DEBIAN/postinst" <<'EOF'
#!/bin/bash
set -e

# Enable systemd services
systemctl daemon-reload
systemctl enable circleos-shell.service || true

# Update icon cache
if command -v gtk-update-icon-cache >/dev/null 2>&1; then
    gtk-update-icon-cache -f /usr/share/icons/hicolor || true
fi

# Update desktop database
if command -v update-desktop-database >/dev/null 2>&1; then
    update-desktop-database /usr/share/applications || true
fi

echo "CircleOS installed successfully!"
echo "Log out and select 'CircleOS' from your display manager"

exit 0
EOF

chmod 755 "$PACKAGE_DIR/DEBIAN/postinst"

# Create prerm script
cat > "$PACKAGE_DIR/DEBIAN/prerm" <<'EOF'
#!/bin/bash
set -e

# Disable systemd services
systemctl disable circleos-shell.service || true

exit 0
EOF

chmod 755 "$PACKAGE_DIR/DEBIAN/prerm"

# Build package
echo "🔨 Building package..."
dpkg-deb --build "$PACKAGE_DIR" "${BUILD_DIR}/${PACKAGE_NAME}.deb"

# Calculate checksums
echo "🔐 Calculating checksums..."
cd "$BUILD_DIR"
sha256sum "${PACKAGE_NAME}.deb" > "${PACKAGE_NAME}.deb.sha256"
md5sum "${PACKAGE_NAME}.deb" > "${PACKAGE_NAME}.deb.md5"

echo "✅ Package built successfully!"
echo "📍 Location: ${BUILD_DIR}/${PACKAGE_NAME}.deb"
echo "📊 Size: $(du -h "${BUILD_DIR}/${PACKAGE_NAME}.deb" | cut -f1)"
echo ""
echo "Install with:"
echo "  sudo dpkg -i ${PACKAGE_NAME}.deb"
echo "  sudo apt-get install -f  # Fix dependencies"
