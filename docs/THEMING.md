# CircleOS Theming Guide

## Theme Structure

CircleOS themes are located in `/usr/share/circleos/themes/` or `~/.local/share/circleos/themes/`

### Theme Directory Structure

```
MyTheme/
├── theme.conf          # Theme configuration
├── colors.conf         # Color definitions
├── icons/              # Custom icons (optional)
├── wallpapers/         # Theme wallpapers (optional)
└── qml/                # Custom QML components (optional)
```

## Creating a Theme

### 1. Basic Theme Configuration

Create `theme.conf`:

```ini
[Theme]
Name=My Custom Theme
Description=A beautiful custom theme
Version=1.0.0
Author=Your Name

[Inherits]
Base=CircleOS

[Colors]
Primary=#673ab7
PrimaryLight=#d1c4e9
PrimaryDark=#512da8
Accent=#ff5722
Background=#fafafa
Surface=#ffffff
Error=#f44336
OnPrimary=#ffffff
OnBackground=#212121
OnSurface=#424242

[Typography]
FontFamily=Roboto
FontSize=14
FontWeight=400
HeadingFontWeight=500

[Spacing]
Unit=8
Small=4
Medium=8
Large=16
ExtraLarge=24

[BorderRadius]
Small=4
Medium=8
Large=16
Circle=50%

[Shadows]
Level1=0 1px 3px rgba(0,0,0,0.12)
Level2=0 2px 6px rgba(0,0,0,0.16)
Level3=0 4px 12px rgba(0,0,0,0.20)
Level4=0 8px 24px rgba(0,0,0,0.24)

[Animation]
Duration=200
Easing=ease-out
```

### 2. Color Schemes

CircleOS supports multiple color schemes per theme.

Create `colors.conf`:

```ini
[Light]
Primary=#2196f3
Background=#ffffff
Surface=#f5f5f5
OnBackground=#212121

[Dark]
Primary=#2196f3
Background=#121212
Surface=#1e1e1e
OnBackground=#ffffff

[HighContrast]
Primary=#000000
Background=#ffffff
Surface=#ffffff
OnBackground=#000000
```

### 3. Custom Components

Override default components by creating QML files in `qml/`:

```qml
// qml/CircularButton.qml
import QtQuick
import QtQuick.Controls

Button {
    id: root
    
    background: Rectangle {
        radius: width / 2
        color: root.pressed ? "#512da8" : "#673ab7"
        
        Behavior on color {
            ColorAnimation { duration: 150 }
        }
    }
    
    contentItem: Text {
        text: root.text
        color: "#ffffff"
        font.family: "Roboto"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
```

## Installing a Theme

### System-wide Installation

```bash
sudo cp -r MyTheme /usr/share/circleos/themes/
```

### User Installation

```bash
mkdir -p ~/.local/share/circleos/themes
cp -r MyTheme ~/.local/share/circleos/themes/
```

## Applying a Theme

### Via Settings

1. Open **Settings**
2. Go to **Appearance**
3. Select your theme from the list
4. Click **Apply**

### Via Command Line

```bash
circleos-settings set appearance theme "My Custom Theme"
```

### Via Configuration File

Edit `~/.config/circleos/settings.conf`:

```ini
[Appearance]
Theme=My Custom Theme
ColorScheme=Dark
```

## Theme Components

### Colors

All colors support:
- Hex: `#2196f3`
- RGB: `rgb(33, 150, 243)`
- RGBA: `rgba(33, 150, 243, 0.5)`
- Named: `blue`, `red`, etc.

### Typography

Supported font properties:
- `FontFamily`: Font family name
- `FontSize`: Base font size in pixels
- `FontWeight`: 100-900 or named (Light, Regular, Medium, Bold)
- `LineHeight`: Line height multiplier

### Spacing

All spacing values are in pixels and based on an 8px grid system.

### Border Radius

- `Small`: Small elements (4px)
- `Medium`: Standard elements (8px)
- `Large`: Large panels (16px)
- `Circle`: Circular elements (50%)

### Shadows

CSS-style box shadows with blur and offset values.

### Animations

- `Duration`: Animation duration in milliseconds
- `Easing`: CSS easing function

## Advanced Theming

### Custom Wallpapers

Place wallpapers in `wallpapers/`:

```
wallpapers/
├── default.jpg
├── dark.jpg
└── light.jpg
```

Reference in `theme.conf`:

```ini
[Wallpapers]
Default=wallpapers/default.jpg
Dark=wallpapers/dark.jpg
Light=wallpapers/light.jpg
```

### Custom Icons

Override system icons by placing them in `icons/`:

```
icons/
├── folder.svg
├── file.svg
└── settings.svg
```

### QML Styling

Create custom styles for Qt Quick Controls:

```qml
// qml/Button.qml
import QtQuick
import QtQuick.Templates as T

T.Button {
    id: control
    
    implicitWidth: Math.max(implicitBackgroundWidth, implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight, implicitContentHeight + topPadding + bottomPadding)
    
    padding: 12
    
    background: Rectangle {
        radius: 8
        color: control.down ? Theme.primaryDark : Theme.primary
    }
    
    contentItem: Text {
        text: control.text
        font: control.font
        color: Theme.onPrimary
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
```

## Theme Variables

Access theme variables in QML:

```qml
import CircleOS.Theme 1.0

Rectangle {
    color: Theme.primary
    radius: Theme.borderRadiusMedium
    
    Text {
        color: Theme.onPrimary
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
    }
}
```

## Best Practices

1. **Consistency**: Use theme variables instead of hardcoded values
2. **Accessibility**: Ensure sufficient contrast ratios (4.5:1 for text)
3. **Performance**: Optimize images and avoid complex gradients
4. **Testing**: Test on different screen sizes and DPI settings
5. **Documentation**: Include a README with your theme

## Example Themes

### Dark Theme

```ini
[Colors]
Primary=#bb86fc
PrimaryLight=#e7b9ff
PrimaryDark=#8858c8
Accent=#03dac6
Background=#121212
Surface=#1e1e1e
Error=#cf6679
OnPrimary=#000000
OnBackground=#ffffff
OnSurface=#ffffff
```

### Light Theme

```ini
[Colors]
Primary=#6200ee
PrimaryLight=#9d46ff
PrimaryDark=#0a00b6
Accent=#03dac6
Background=#ffffff
Surface=#f5f5f5
Error=#b00020
OnPrimary=#ffffff
OnBackground=#000000
OnSurface=#000000
```

### High Contrast Theme

```ini
[Colors]
Primary=#000000
PrimaryLight=#424242
PrimaryDark=#000000
Accent=#ffff00
Background=#ffffff
Surface=#ffffff
Error=#ff0000
OnPrimary=#ffffff
OnBackground=#000000
OnSurface=#000000
```

## Sharing Themes

Package your theme as a `.tar.gz`:

```bash
tar -czf mytheme.tar.gz MyTheme/
```

Users can install with:

```bash
circleos-theme-install mytheme.tar.gz
```

## Resources

- Material Design Color Tool: https://material.io/resources/color/
- Color Contrast Checker: https://webaim.org/resources/contrastchecker/
- Google Fonts: https://fonts.google.com/
- Material Design Icons: https://materialdesignicons.com/
