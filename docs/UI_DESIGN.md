# CircleOS UI Design Guidelines

## Design Philosophy

CircleOS features a modern, circular UI design inspired by Material Design principles with a unique circular aesthetic. The design emphasizes:

- **Clarity**: Clean, uncluttered interfaces
- **Consistency**: Unified design language across all components
- **Fluidity**: Smooth animations and transitions
- **Accessibility**: High contrast, readable fonts, keyboard navigation

## Circular Design Language

### Core Principles

1. **Circular Elements**: Buttons, icons, and interactive elements use circular shapes
2. **Rounded Corners**: Containers and panels use generous border radius
3. **Smooth Transitions**: All state changes are animated
4. **Depth**: Subtle shadows create visual hierarchy

### Component Patterns

#### Buttons

```qml
// Primary circular button
CircularButton {
    width: 48
    height: 48
    radius: 24
    backgroundColor: "#2196f3"
    iconSource: "icon.svg"
}
```

- Default size: 48x48px (circular)
- Icon size: 24x24px
- Hover: Slight scale increase (1.05x)
- Press: Scale decrease (0.95x)
- Ripple effect on click

#### Panels

```qml
Rectangle {
    radius: 16
    color: "#ffffff"
    opacity: 0.95
    
    layer.enabled: true
    layer.effect: MultiEffect {
        shadowEnabled: true
        shadowBlur: 0.8
    }
}
```

- Border radius: 16px for large panels, 8px for small
- Background: White with 95% opacity
- Shadow: Soft, subtle elevation
- Blur effect for modern glass-morphism look

#### Dock

- Circular icons (48x48px)
- Hover: Scale to 1.2x with smooth animation
- Active indicator: Small dot below icon
- Background: Rounded rectangle (32px radius)
- Glass-morphism effect with blur

#### Top Panel

- Height: 48px
- Circular buttons for system tray
- Roboto font for text
- Transparent background with blur
- Subtle bottom border

## Color Palette

### Primary Colors
- Primary: `#2196f3` (Blue)
- Primary Light: `#e3f2fd`
- Primary Dark: `#1976d2`

### Accent Colors
- Accent: `#ff4081` (Pink)

### Neutral Colors
- Background: `#f5f5f5`
- Surface: `#ffffff`
- On Surface: `#424242`
- On Background: `#212121`

### Semantic Colors
- Success: `#4caf50`
- Warning: `#ff9800`
- Error: `#f44336`
- Info: `#2196f3`

## Typography

### Font Family
- Primary: Roboto
- Monospace: Roboto Mono

### Font Sizes
- Display: 96px (Light)
- Headline: 24px (Medium)
- Title: 18px (Medium)
- Body: 14px (Regular)
- Caption: 12px (Regular)
- Button: 14px (Medium)

### Font Weights
- Light: 300
- Regular: 400
- Medium: 500
- Bold: 700

## Spacing System

Based on 8px grid:
- XS: 4px
- S: 8px
- M: 16px
- L: 24px
- XL: 32px
- XXL: 48px

## Icons

### Style
- Material Design Icons
- Outlined style preferred
- 24x24px default size
- Circular backgrounds for app icons

### Usage
```qml
Image {
    source: "qrc:/icons/icon-name.svg"
    width: 24
    height: 24
    sourceSize: Qt.size(width, height)
    smooth: true
}
```

## Animations

### Timing
- Fast: 150ms (micro-interactions)
- Normal: 200ms (standard transitions)
- Slow: 300ms (complex animations)

### Easing
- Enter: `Easing.OutQuad`
- Exit: `Easing.InQuad`
- Emphasis: `Easing.OutBack`

### Common Animations

#### Fade In/Out
```qml
Behavior on opacity {
    NumberAnimation { duration: 200 }
}
```

#### Scale
```qml
Behavior on scale {
    NumberAnimation {
        duration: 200
        easing.type: Easing.OutBack
    }
}
```

#### Slide
```qml
Behavior on y {
    NumberAnimation {
        duration: 200
        easing.type: Easing.OutQuad
    }
}
```

## Accessibility

### Contrast Ratios
- Normal text: 4.5:1 minimum
- Large text: 3:1 minimum
- UI components: 3:1 minimum

### Keyboard Navigation
- All interactive elements must be keyboard accessible
- Visible focus indicators
- Logical tab order

### Screen Readers
- Proper ARIA labels
- Semantic HTML/QML structure
- Descriptive button text

## Responsive Design

### Breakpoints
- Small: < 768px
- Medium: 768px - 1024px
- Large: 1024px - 1440px
- Extra Large: > 1440px

### Scaling
- UI scales based on screen DPI
- Minimum touch target: 44x44px
- Adaptive layouts for different screen sizes

## Best Practices

1. **Consistency**: Use provided components
2. **Performance**: Optimize animations, use caching
3. **Accessibility**: Test with keyboard and screen readers
4. **Responsiveness**: Test on different screen sizes
5. **Theming**: Use theme colors, not hardcoded values
