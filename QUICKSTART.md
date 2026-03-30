# CircleOS Quick Start Guide

Welcome to CircleOS - a modern, circular UI Linux distribution!

## 🚀 Getting Started in 5 Minutes

### Prerequisites Check

```bash
# Check if you're on Debian/Ubuntu
cat /etc/os-release

# You need: Debian 12+ or Ubuntu 22.04+
```

### Step 1: Clone the Repository

```bash
git clone https://github.com/circleos/circleos.git
cd circleos
```

### Step 2: Setup Development Environment

```bash
# This installs all required dependencies
./scripts/setup-dev.sh
```

The script will ask you:
- Install ISO building tools? (Say **Y** if you want to build full ISO)
- Install QEMU? (Say **Y** to test in virtual machine)
- Install Qt Creator? (Say **Y** for IDE support)

### Step 3: Build CircleOS

```bash
# Quick build (desktop environment only)
./build.sh

# Full build with ISO (requires root, takes longer)
sudo ./build.sh --full
```

### Step 4: Test in QEMU

```bash
# Run the ISO in QEMU virtual machine
./scripts/run-qemu.sh
```

**QEMU Controls:**
- `Ctrl+Alt+G` - Release mouse/keyboard
- `Ctrl+Alt+F` - Toggle fullscreen
- `Ctrl+Alt+Q` - Quit QEMU

## 🎨 What You'll See

### Desktop Shell
- **Top Panel**: System tray, clock, notifications
- **Desktop**: Clean workspace with icons
- **Dock**: Circular app launcher at bottom
- **Circular UI**: All buttons and elements use circular design

### Key Features
- Click the apps button (top-left) to open launcher
- Click notification bell to see notifications
- Hover over dock icons - they scale up smoothly
- Everything uses circular, modern design

## 🛠️ Development Workflow

### Using Qt Creator

```bash
# Open project in Qt Creator
qtcreator CMakeLists.txt
```

1. Configure project with Qt 6 kit
2. Build target: `circleos-shell`
3. Run to test desktop shell

### Manual Build

```bash
# Clean build
./build.sh --clean

# Build specific component
cd build
make circleos-shell
make circleos-lockscreen
make circleos-settings
```

### Testing Components

```bash
# Test desktop shell
./build/desktop/shell/circleos-shell

# Test lock screen
./build/desktop/lockscreen/circleos-lockscreen

# Test settings app
./build/apps/settings/circleos-settings
```

## 📁 Project Structure Overview

```
CircleOS/
├── desktop/shell/          ← Main desktop interface
│   └── qml/components/     ← UI components (buttons, panels, etc.)
├── core/                   ← System libraries
├── apps/                   ← Applications (files, settings, terminal)
├── bootloader/             ← GRUB theme
├── installer/              ← System installer config
└── scripts/                ← Build and utility scripts
```

## 🎯 Common Tasks

### Add a New UI Component

1. Create QML file in `desktop/shell/qml/components/`
2. Add to `desktop/shell/CMakeLists.txt`
3. Import in `main.qml`
4. Rebuild: `./build.sh`

### Modify Colors/Theme

Edit: `themes/CircleOS/theme.conf`

```ini
[Colors]
Primary=#2196f3        ← Change primary color
Accent=#ff4081         ← Change accent color
Background=#f5f5f5     ← Change background
```

### Add New Application

```bash
# Create app directory
mkdir -p apps/myapp

# Create main.cpp and CMakeLists.txt
# Add to apps/CMakeLists.txt:
add_subdirectory(myapp)

# Rebuild
./build.sh
```

## 🐛 Troubleshooting

### Build Fails - Missing Qt6

```bash
sudo apt install qt6-base-dev qt6-declarative-dev qt6-wayland-dev
```

### QEMU Won't Start

```bash
# Install QEMU
sudo apt install qemu-system-x86

# Check ISO exists
ls iso/output/
```

### Permission Denied on Scripts

```bash
chmod +x build.sh
chmod +x scripts/*.sh
```

### CMake Configuration Error

```bash
# Clean and reconfigure
rm -rf build/
./build.sh
```

## 📚 Learn More

- **Architecture**: Read `docs/ARCHITECTURE.md`
- **API Reference**: Read `docs/API.md`
- **UI Design**: Read `docs/UI_DESIGN.md`
- **Contributing**: Read `CONTRIBUTING.md`
- **Installation**: Read `INSTALL.md`

## 🎓 Next Steps

### For Developers

1. Read `docs/ARCHITECTURE.md` to understand system design
2. Explore `desktop/shell/qml/` to see UI components
3. Check `core/` for system libraries
4. Read `docs/API.md` for D-Bus interfaces

### For Designers

1. Read `docs/UI_DESIGN.md` for design guidelines
2. Explore `desktop/shell/qml/components/` for UI patterns
3. Check `themes/CircleOS/` for theming
4. Modify colors and test in QEMU

### For Users

1. Build full ISO: `sudo ./build.sh --full`
2. Test in QEMU: `./scripts/run-qemu.sh`
3. Install on real hardware (see `INSTALL.md`)
4. Report issues on GitHub

## 💡 Tips

- **Fast Iteration**: Edit QML files, they reload without rebuild
- **Debug Mode**: Run with `QML_IMPORT_TRACE=1` for debugging
- **Performance**: Use `QSG_RENDER_LOOP=basic` if graphics lag
- **Logging**: Check `~/.local/share/circleos/logs/`

## 🤝 Getting Help

- **Documentation**: Check `docs/` directory
- **Issues**: GitHub issue tracker
- **Forum**: Community forum (coming soon)
- **Chat**: Discord/Matrix (coming soon)

## ⚡ Quick Commands Reference

```bash
# Build
./build.sh                    # Quick build
./build.sh --full            # Full build with ISO
./build.sh --clean           # Clean build

# Test
./scripts/run-qemu.sh        # Run in QEMU
./build/desktop/shell/circleos-shell  # Run shell directly

# Development
./scripts/setup-dev.sh       # Setup environment
qtcreator CMakeLists.txt     # Open in Qt Creator

# ISO
sudo ./build.sh --full       # Build ISO
ls iso/output/               # Find ISO file
```

## 🎉 You're Ready!

You now have a complete, modern Linux distribution with circular UI design.

Start exploring, building, and contributing to CircleOS!

---

**Need help?** Check `PROJECT_STATUS.md` for project status and roadmap.
