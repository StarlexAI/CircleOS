# CircleOS Development Guide

## Getting Started

### Prerequisites

- Debian 12 (Bookworm) or Ubuntu 22.04+
- Qt 6.2 or later
- CMake 3.20+
- GCC 11+ or Clang 14+
- Git

### Setup Development Environment

```bash
# Clone repository
git clone https://github.com/circleos/circleos.git
cd circleos

# Run setup script
./scripts/setup-dev.sh

# Build project
./build.sh
```

## Project Structure

```
CircleOS/
├── core/           # Core system libraries (C++)
├── desktop/        # Desktop environment (QML/C++)
├── apps/           # System applications
├── docs/           # Documentation
├── tests/          # Unit and integration tests
└── scripts/        # Build and utility scripts
```

## Development Workflow

### 1. Create a Feature Branch

```bash
git checkout -b feature/my-feature
```

### 2. Make Changes

Edit code in your preferred editor or Qt Creator:

```bash
qtcreator CMakeLists.txt
```

### 3. Build and Test

```bash
# Quick build
./build.sh

# Clean build
./build.sh --clean

# Run tests
cd build
ctest
```

### 4. Test in QEMU

```bash
./scripts/run-qemu.sh
```

### 5. Commit Changes

```bash
git add .
git commit -m "feat: add new feature"
```

## Coding Standards

### C++ Style

- Follow Qt coding conventions
- Use C++20 features
- Use smart pointers (`std::unique_ptr`, `std::shared_ptr`)
- Use `const` and `constexpr` where appropriate
- Prefer `auto` for complex types

Example:

```cpp
#include <memory>
#include <QString>

class MyClass {
public:
    explicit MyClass(QObject *parent = nullptr);
    ~MyClass() override;

    QString value() const { return d->value; }
    void setValue(const QString &value);

private:
    class Private;
    std::unique_ptr<Private> d;
};
```

### QML Style

- Use 4-space indentation
- Group properties logically
- Use property bindings over imperative code
- Prefer declarative over imperative

Example:

```qml
import QtQuick
import QtQuick.Controls

Rectangle {
    id: root
    
    // Properties
    property string title: ""
    property bool active: false
    
    // Geometry
    width: 200
    height: 100
    radius: 8
    
    // Appearance
    color: active ? "#2196f3" : "#f5f5f5"
    
    // Behavior
    Behavior on color {
        ColorAnimation { duration: 200 }
    }
    
    // Children
    Label {
        anchors.centerIn: parent
        text: root.title
        font.family: "Roboto"
    }
}
```

### Naming Conventions

- Classes: `PascalCase`
- Functions/methods: `camelCase`
- Variables: `camelCase`
- Constants: `UPPER_SNAKE_CASE`
- Private members: prefix with `d->` (d-pointer pattern)

### Comments

```cpp
/**
 * @brief Brief description of the class
 * 
 * Detailed description of what the class does,
 * how to use it, and any important notes.
 */
class MyClass {
public:
    /**
     * @brief Brief description of the method
     * @param param Description of parameter
     * @return Description of return value
     */
    QString myMethod(const QString &param);
};
```

## Component Development

### Creating a New Core Service

1. Create header in `core/include/`:

```cpp
#pragma once

#include <QObject>
#include <memory>

namespace CircleOS {
namespace Core {

class MyService : public QObject {
    Q_OBJECT

public:
    explicit MyService(QObject *parent = nullptr);
    ~MyService() override;

signals:
    void serviceReady();

private:
    class Private;
    std::unique_ptr<Private> d;
};

} // namespace Core
} // namespace CircleOS
```

2. Create implementation in `core/src/`:

```cpp
#include "MyService.h"

namespace CircleOS {
namespace Core {

class MyService::Private {
public:
    // Private data members
};

MyService::MyService(QObject *parent)
    : QObject(parent)
    , d(std::make_unique<Private>())
{
    // Initialization
}

MyService::~MyService() = default;

} // namespace Core
} // namespace CircleOS
```

3. Add to `core/CMakeLists.txt`

### Creating a New QML Component

1. Create QML file in `desktop/shell/qml/components/`:

```qml
import QtQuick
import QtQuick.Controls

Item {
    id: root
    
    // Public properties
    property string title: ""
    
    // Signals
    signal clicked()
    
    // Implementation
    Rectangle {
        anchors.fill: parent
        color: "#ffffff"
        radius: 8
        
        MouseArea {
            anchors.fill: parent
            onClicked: root.clicked()
        }
    }
}
```

2. Add to `desktop/shell/CMakeLists.txt`

3. Use in other QML files:

```qml
import "components"

MyComponent {
    title: "Hello"
    onClicked: console.log("Clicked!")
}
```

## Testing

### Unit Tests

Create test file in `tests/`:

```cpp
#include <QtTest/QtTest>
#include "../core/include/MyService.h"

class TestMyService : public QObject {
    Q_OBJECT

private slots:
    void testInitialization() {
        CircleOS::Core::MyService service;
        // Test assertions
        QVERIFY(true);
    }
};

QTEST_MAIN(TestMyService)
#include "test_myservice.moc"
```

Run tests:

```bash
cd build
ctest --verbose
```

### Integration Tests

Test complete workflows:

```bash
# Start test environment
./scripts/run-qemu.sh

# Run integration tests
./tests/integration/test_desktop.sh
```

## Debugging

### Qt Creator

1. Open project: `qtcreator CMakeLists.txt`
2. Set breakpoints in code
3. Press F5 to debug

### Command Line

```bash
# Debug with GDB
gdb ./build/desktop/shell/circleos-shell

# Debug with Valgrind
valgrind --leak-check=full ./build/desktop/shell/circleos-shell

# QML debugging
QML_IMPORT_TRACE=1 ./build/desktop/shell/circleos-shell
```

### Logging

Use Qt logging categories:

```cpp
#include <QLoggingCategory>

Q_LOGGING_CATEGORY(myCategory, "circleos.mycomponent")

qCDebug(myCategory) << "Debug message";
qCInfo(myCategory) << "Info message";
qCWarning(myCategory) << "Warning message";
qCCritical(myCategory) << "Critical message";
```

Enable logging:

```bash
QT_LOGGING_RULES="circleos.*=true" ./circleos-shell
```

## Performance Optimization

### Profiling

```bash
# CPU profiling with perf
perf record ./circleos-shell
perf report

# Memory profiling with Valgrind
valgrind --tool=massif ./circleos-shell
ms_print massif.out.*
```

### QML Performance

- Use `Loader` for lazy loading
- Avoid complex bindings
- Use `ListView` caching
- Profile with QML Profiler in Qt Creator

## Documentation

### Code Documentation

Use Doxygen-style comments:

```cpp
/**
 * @class MyClass
 * @brief Brief description
 * 
 * Detailed description of the class.
 * 
 * @example
 * MyClass obj;
 * obj.doSomething();
 */
```

Generate documentation:

```bash
doxygen Doxyfile
```

### User Documentation

Add to `docs/` directory in Markdown format.

## Continuous Integration

### GitHub Actions

`.github/workflows/build.yml`:

```yaml
name: Build

on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Install dependencies
        run: ./scripts/setup-dev.sh
      - name: Build
        run: ./build.sh
      - name: Test
        run: cd build && ctest
```

## Release Process

1. Update version in `CMakeLists.txt`
2. Update `CHANGELOG.md`
3. Create git tag: `git tag v1.0.0`
4. Build release: `./build.sh --full`
5. Create packages: `./scripts/package-deb.sh`
6. Push tag: `git push origin v1.0.0`
7. Create GitHub release

## Resources

- Qt Documentation: https://doc.qt.io/
- CMake Documentation: https://cmake.org/documentation/
- C++ Core Guidelines: https://isocpp.github.io/CppCoreGuidelines/
- QML Best Practices: https://doc.qt.io/qt-6/qtquick-bestpractices.html
