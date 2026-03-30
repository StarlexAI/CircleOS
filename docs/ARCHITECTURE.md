# CircleOS Architecture

## Overview

CircleOS is a modern Linux distribution built on Debian with a custom desktop environment featuring a circular UI design. The system is designed with modularity, performance, and user experience in mind.

## System Layers

```
┌─────────────────────────────────────────┐
│         Applications Layer              │
│  (Files, Settings, Terminal, etc.)      │
├─────────────────────────────────────────┤
│       Desktop Environment Layer         │
│  (Shell, Compositor, Panel, Dock)       │
├─────────────────────────────────────────┤
│          Core Services Layer            │
│  (Session, Power, Audio, Network)       │
├─────────────────────────────────────────┤
│         System Services Layer           │
│  (systemd, D-Bus, NetworkManager)       │
├─────────────────────────────────────────┤
│            Kernel Layer                 │
│         (Linux Kernel)                  │
└─────────────────────────────────────────┘
```

## Component Architecture

### Desktop Environment

#### Shell (circleos-shell)
- Main desktop interface
- Manages desktop icons, wallpaper
- Integrates panel and dock
- Built with Qt/QML
- Communicates via D-Bus

#### Compositor (circleos-compositor)
- Wayland compositor based on Qt Wayland Compositor
- Handles window management
- Provides window animations and effects
- Manages multiple displays

#### Lock Screen (circleos-lockscreen)
- Secure authentication interface
- Displays time and date
- Integrates with PAM for authentication

### Core Services

#### Session Manager
- Manages user sessions
- Handles login/logout
- Integrates with systemd user sessions
- Provides D-Bus interface

#### Power Manager
- Battery monitoring
- Power profiles (performance, balanced, power-save)
- Suspend/hibernate functionality
- Integrates with systemd-logind

#### Audio Manager
- Volume control
- Audio device management
- Integrates with PulseAudio/PipeWire

#### Network Manager
- Network connection management
- Wi-Fi and Ethernet support
- VPN integration
- Uses NetworkManager backend

### Applications

All applications follow the circular UI design language and integrate with the desktop environment through D-Bus.

## Communication Architecture

```
┌──────────┐     D-Bus      ┌──────────┐
│  Shell   │◄──────────────►│  Core    │
└──────────┘                 │ Services │
     ▲                       └──────────┘
     │                            ▲
     │ D-Bus                      │ D-Bus
     ▼                            ▼
┌──────────┐                ┌──────────┐
│   Apps   │                │ systemd  │
└──────────┘                └──────────┘
```

## Technology Stack

- **UI Framework**: Qt 6 with QML
- **Display Server**: Wayland (X.Org fallback)
- **IPC**: D-Bus
- **Init System**: systemd
- **Build System**: CMake
- **Languages**: C++20, QML, C, Bash, Python

## Design Principles

1. **Modularity**: Components are loosely coupled and communicate via D-Bus
2. **Performance**: Native C++/Qt for optimal performance
3. **Modern UI**: Circular design elements, smooth animations
4. **Accessibility**: Following WCAG guidelines
5. **Extensibility**: Plugin architecture for extensions

## File System Layout

```
/usr/bin/                   # Executables
/usr/lib/circleos/          # Libraries
/usr/share/circleos/        # Resources
/etc/circleos/              # System configuration
~/.config/circleos/         # User configuration
~/.local/share/circleos/    # User data
```

## Boot Process

1. GRUB bootloader with custom theme
2. Linux kernel initialization
3. systemd starts system services
4. Display manager starts
5. User authentication
6. Session manager starts user session
7. Desktop shell launches
8. Applications auto-start

## Security

- PAM integration for authentication
- Polkit for privilege escalation
- Sandboxed applications (future: Flatpak)
- Secure boot support
- Encrypted home directories support
