# Contributing to CircleOS

Thank you for your interest in contributing to CircleOS!

## Development Setup

### Prerequisites

- Debian 12 (Bookworm) or compatible Linux distribution
- Qt 6.2 or later
- CMake 3.20 or later
- GCC 11+ or Clang 14+
- Git

### Install Dependencies

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
    squashfs-tools \
    qemu-system-x86
```

### Building

```bash
# Clone the repository
git clone https://github.com/circleos/circleos.git
cd circleos

# Build the project
./build.sh

# Build full ISO (requires root for debootstrap)
./build.sh --full
```

### Testing

```bash
# Run in QEMU
./scripts/run-qemu.sh
```

## Code Style

- C++: Follow Qt coding conventions
- QML: Use 4-space indentation
- Comments: Use clear, descriptive comments
- Naming: Use camelCase for variables, PascalCase for classes

## Submitting Changes

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## Areas for Contribution

- Desktop environment components
- System applications
- Themes and icons
- Documentation
- Bug fixes
- Performance improvements

## License

By contributing, you agree that your contributions will be licensed under GPL-3.0.
