# 🔵 CircleOS

**A modern, elegant Linux desktop environment with a unique circular UI design**

CircleOS is a complete desktop environment built with Qt6 and QML, featuring a distinctive circular design language inspired by modern mobile interfaces. It provides a full suite of applications and system services for a complete desktop experience.

![CircleOS](https://img.shields.io/badge/version-1.0.0-blue)
![License](https://img.shields.io/badge/license-GPL--3.0-green)
![Qt](https://img.shields.io/badge/Qt-6.4+-brightgreen)
![Platform](https://img.shields.io/badge/platform-Linux-lightgrey)

## ✨ Features

### 🎨 Unique Circular UI Design
- Modern, clean interface with circular elements
- Smooth animations and transitions
- Material Design inspired color palette
- Glass-morphism effects
- Roboto font family throughout

### 🖥️ Complete Desktop Environment
- **Desktop Shell** - Full-featured desktop with app launcher, dock, and panels
- **Lock Screen** - Secure lock screen with time and date
- **Window Management** - Efficient window switching and workspace management
- **Notification Center** - System notifications with action support
- **Quick Settings** - Fast access to system controls

### 📱 Built-in Applications (17 Apps)
1. **Files** - Modern file manager with folder navigation
2. **Settings** - System configuration and preferences
3. **Terminal** - Feature-rich terminal emulator
4. **Calculator** - Scientific calculator with circular buttons
5. **Text Editor** - Code and text editing with syntax highlighting
6. **Music** - Music player with playlist support
7. **Calendar** - Calendar with event management
8. **Weather** - Weather forecasts and conditions
9. **Photos** - Photo viewer and organizer
10. **Mail** - Email client
11. **Browser** - Web browser
12. **Videos** - Video player
13. **Store** - Application store
14. **Contacts** - Contact management
15. **Clock** - Clock, timer, and alarms
16. **Maps** - Maps and navigation
17. **Notes** - Note-taking application

### 🔧 System Services (12 Services)
- Session Manager
- Power Manager
- Audio Manager
- Network Manager
- Bluetooth Manager
- Display Manager
- Notification Manager
- Input Manager
- Settings Backend
- Theme Manager
- Wallpaper Manager
- Clipboard Manager

## 🚀 Quick Start

### Prerequisites

```bash
# Debian/Ubuntu
sudo apt-get install -y \
    build-essential \
    cmake \
    qt6-base-dev \
    qt6-declarative-dev \
    qt6-wayland-dev \
    qt6-svg-dev \
    qml6-module-qtquick \
    qml6-module-qtquick-controls \
    qml6-module-qtquick-layouts \
    qml6-module-qtquick-window \
    qml6-module-qtquick-templates \
    qml6-module-qtqml-workerscript \
    qml6-module-qt-labs-folderlistmodel \
    libsystemd-dev \
    libdbus-1-dev
```

### Build

```bash
# Clone the repository
git clone https://github.com/StarlexAI/CircleOS.git
cd CircleOS

# Build
./build.sh

# Install (optional)
sudo cmake --install build
```

### Run Applications

```bash
# Run individual applications
./build/apps/calculator/circleos-calculator
./build/apps/files/circleos-files
./build/apps/settings/circleos-settings

# Run desktop shell
./build/desktop/shell/circleos-shell
```

## 📦 Building ISO

CircleOS can be packaged as a bootable ISO using Debian's live-build system (same approach as Lingmo OS).

See [BUILD_ISO_INSTRUCTIONS.md](BUILD_ISO_INSTRUCTIONS.md) for detailed instructions.

**Note:** ISO building requires a native Linux system (not in a container) due to debootstrap requirements.

## 🏗️ Architecture

CircleOS follows a modular architecture:

```
CircleOS/
├── apps/              # User applications
│   ├── calculator/
│   ├── files/
│   ├── settings/
│   └── ...
├── core/              # Core system libraries
│   ├── audio/
│   ├── network/
│   ├── power/
│   └── ...
├── desktop/           # Desktop environment
│   ├── shell/         # Main desktop shell
│   ├── lockscreen/    # Lock screen
│   └── compositor/    # Wayland compositor
└── iso-build/         # ISO build configuration
```

## 🎨 Design Philosophy

CircleOS embraces a **circular design language** that:
- Uses circular buttons, icons, and UI elements
- Provides smooth, natural animations
- Maintains consistency across all applications
- Focuses on simplicity and elegance
- Prioritizes user experience

## 🛠️ Development

### Project Structure

- **C++20** for core system services
- **QML** for user interfaces
- **CMake** for build system
- **Qt6** framework
- **systemd** integration
- **D-Bus** for IPC

### Code Statistics

- **6,898+** lines of code
- **197** total files
- **50+** C++ source files
- **30+** QML UI files
- **20** CMakeLists.txt files

### Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## 📖 Documentation

- [Quick Start Guide](QUICKSTART.md)
- [Installation Guide](INSTALL.md)
- [Development Guide](DEVELOPMENT.md)
- [Architecture Overview](ARCHITECTURE.md)
- [API Documentation](API.md)
- [UI Design Guidelines](UI_DESIGN.md)
- [Theming Guide](THEMING.md)
- [Keyboard Shortcuts](KEYBOARD_SHORTCUTS.md)
- [ISO Build Instructions](BUILD_ISO_INSTRUCTIONS.md)

## 🔑 Keyboard Shortcuts

- `Super + D` - Show desktop
- `Super + L` - Lock screen
- `Super + T` - Open terminal
- `Super + E` - Open files
- `Super + Space` - App launcher
- `Alt + Tab` - Switch windows
- `Ctrl + Alt + Arrow` - Switch workspaces

## 🌐 System Requirements

### Minimum
- **CPU:** 64-bit x86 processor
- **RAM:** 2GB
- **Storage:** 10GB
- **Display:** 1024x768

### Recommended
- **CPU:** Dual-core 2GHz+
- **RAM:** 4GB+
- **Storage:** 20GB+
- **Display:** 1920x1080+
- **GPU:** OpenGL 3.0+ support

## 📜 License

CircleOS is licensed under the GNU General Public License v3.0. See [LICENSE](LICENSE) for details.

## 🙏 Acknowledgments

- Inspired by modern mobile interfaces and Material Design
- Built with the Qt framework
- Uses Debian as the base system
- Follows the Lingmo OS approach for ISO building

## 🔗 Links

- **GitHub:** https://github.com/StarlexAI/CircleOS
- **Issues:** https://github.com/StarlexAI/CircleOS/issues
- **Discussions:** https://github.com/StarlexAI/CircleOS/discussions

## 📧 Contact

For questions or support, please open an issue on GitHub.

---

**Made with ❤️ by the CircleOS Team**

*CircleOS - A circular approach to desktop computing*
