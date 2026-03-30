cmake_minimum_required(VERSION 3.20)
project(CircleOS VERSION 1.0.0 LANGUAGES CXX C)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

# Global definitions
add_definitions(-DCIRCLEOS_VERSION="${PROJECT_VERSION}")

message(STATUS "")
message(STATUS "🔵 CircleOS Build System")
message(STATUS "========================")
message(STATUS "Version: ${PROJECT_VERSION}")
message(STATUS "")

# Try to find Qt6 - make it optional for initial build
set(CMAKE_PREFIX_PATH "/usr/lib/x86_64-linux-gnu/cmake/Qt6")
find_package(Qt6 COMPONENTS Core)

if(Qt6_FOUND)
    find_package(Qt6 COMPONENTS Gui Qml Quick DBus Widgets Concurrent Network Svg)
endif()

if(NOT Qt6_FOUND)
    message(WARNING "Qt6 not found. Building minimal version only.")
    message(STATUS "")
    message(STATUS "To build full CircleOS, install Qt6:")
    message(STATUS "  sudo apt install qt6-base-dev qt6-declarative-dev qt6-wayland-dev")
    message(STATUS "")
    message(STATUS "Or run: ./scripts/setup-dev.sh")
    message(STATUS "")
    
    # Create minimal build
    add_executable(circleos-info scripts/version-check.cpp)
    install(FILES README.md QUICKSTART.md INSTALL.md DESTINATION share/doc/circleos)
    
    message(STATUS "✅ Minimal build configured")
    message(STATUS "Run 'make' to build version check tool")
    message(STATUS "")
    return()
endif()

message(STATUS "✅ Qt6 found - configuring full build")
message(STATUS "")

# Wayland
find_package(Wayland REQUIRED)
find_package(WaylandScanner REQUIRED)

# System libraries
find_package(PkgConfig REQUIRED)
pkg_check_modules(SYSTEMD libsystemd QUIET)
pkg_check_modules(DBUS dbus-1 QUIET)

if(NOT SYSTEMD_FOUND OR NOT DBUS_FOUND)
    message(WARNING "systemd or dbus not found - some features will be disabled")
    set(SYSTEMD_LIBRARIES "")
    set(DBUS_LIBRARIES "")
endif()

# Global definitions
add_definitions(-DQT_QML_DEBUG)
add_definitions(-DCIRCLEOS_VERSION="${PROJECT_VERSION}")

# Include directories
include_directories(
    ${CMAKE_SOURCE_DIR}/core/include
    ${CMAKE_BINARY_DIR}
)

# Subdirectories
add_subdirectory(core)
add_subdirectory(desktop)
add_subdirectory(apps)
add_subdirectory(bootloader)
add_subdirectory(installer)

# Install targets
install(DIRECTORY themes/ DESTINATION share/circleos/themes)
install(DIRECTORY resources/ DESTINATION share/circleos/resources)

# CPack configuration for ISO generation
set(CPACK_GENERATOR "DEB")
set(CPACK_PACKAGE_NAME "circleos")
set(CPACK_PACKAGE_VERSION ${PROJECT_VERSION})
set(CPACK_PACKAGE_CONTACT "CircleOS Team")
set(CPACK_DEBIAN_PACKAGE_DEPENDS "qt6-base, qt6-wayland, systemd, dbus")
include(CPack)
