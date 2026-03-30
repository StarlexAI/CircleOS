#!/bin/bash
set -e

# CircleOS Build Script
# This script builds the entire operating system

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUILD_DIR="${SCRIPT_DIR}/build"
ISO_DIR="${SCRIPT_DIR}/iso"

echo "🔵 CircleOS Build System"
echo "========================"

# Parse arguments
FULL_BUILD=false
CLEAN_BUILD=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --full)
            FULL_BUILD=true
            shift
            ;;
        --clean)
            CLEAN_BUILD=true
            shift
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

# Clean if requested
if [ "$CLEAN_BUILD" = true ]; then
    echo "🧹 Cleaning build directory..."
    rm -rf "${BUILD_DIR}"
fi

# Create build directory
mkdir -p "${BUILD_DIR}"
cd "${BUILD_DIR}"

# Check if Qt6 is available
if ! command -v qmake6 &> /dev/null && ! pkg-config --exists Qt6Core 2>/dev/null; then
    echo "⚠️  Qt6 not found. Using minimal build configuration."
    echo "   For full build, run: ./scripts/setup-dev.sh"
    echo ""
    
    # Use minimal CMakeLists
    if [ -f "../CMakeLists.txt.minimal" ]; then
        cp ../CMakeLists.txt.minimal ../CMakeLists.txt.backup
        cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=g++ -DCMAKE_C_COMPILER=gcc
    else
        echo "❌ Minimal build configuration not found"
        exit 1
    fi
else
    # Configure with CMake (full build)
    echo "⚙️  Configuring build..."
    cmake .. \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_CXX_COMPILER=g++ \
        -DCMAKE_C_COMPILER=gcc
fi

# Build
echo "🔨 Building CircleOS..."
make -j$(nproc)

# Install to staging directory
echo "📦 Installing to staging..."
DESTDIR="${BUILD_DIR}/staging" make install

if [ "$FULL_BUILD" = true ]; then
    echo "💿 Building ISO image..."
    "${SCRIPT_DIR}/scripts/build-iso.sh"
fi

echo "✅ Build complete!"
echo "Run './scripts/run-qemu.sh' to test in QEMU"
