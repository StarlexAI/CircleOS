# CircleOS API Documentation

## D-Bus API

CircleOS components communicate via D-Bus. This document describes the public D-Bus interfaces.

### Shell Interface

**Service**: `org.circleos.Shell`  
**Object Path**: `/org/circleos/Shell`  
**Interface**: `org.circleos.Shell`

#### Methods

##### ShowDesktop()
Shows the desktop by minimizing all windows.

```
void ShowDesktop()
```

##### ShowLauncher()
Opens the application launcher.

```
void ShowLauncher()
```

##### ShowNotifications()
Opens the notification center.

```
void ShowNotifications()
```

##### LaunchApplication(string desktopFile)
Launches an application by its desktop file name.

```
void LaunchApplication(string desktopFile)
```

**Parameters**:
- `desktopFile`: Name of the .desktop file (e.g., "firefox.desktop")

#### Signals

##### ApplicationLaunched(string appId)
Emitted when an application is launched.

```
signal ApplicationLaunched(string appId)
```

##### WindowOpened(uint windowId, string title)
Emitted when a new window is opened.

```
signal WindowOpened(uint windowId, string title)
```

### Session Manager Interface

**Service**: `org.circleos.Session`  
**Object Path**: `/org/circleos/Session`  
**Interface**: `org.circleos.Session`

#### Methods

##### Logout()
Logs out the current user.

```
void Logout()
```

##### Shutdown()
Shuts down the system.

```
void Shutdown()
```

##### Reboot()
Reboots the system.

```
void Reboot()
```

##### Lock()
Locks the screen.

```
void Lock()
```

#### Properties

##### IsLocked (readable)
Whether the screen is currently locked.

```
bool IsLocked
```

### Power Manager Interface

**Service**: `org.circleos.Power`  
**Object Path**: `/org/circleos/Power`  
**Interface**: `org.circleos.Power`

#### Methods

##### Suspend()
Suspends the system.

```
void Suspend()
```

##### Hibernate()
Hibernates the system.

```
void Hibernate()
```

##### SetPowerProfile(string profile)
Sets the power profile.

```
void SetPowerProfile(string profile)
```

**Parameters**:
- `profile`: One of "performance", "balanced", "power-save"

#### Properties

##### BatteryLevel (readable)
Current battery level (0-100).

```
int BatteryLevel
```

##### IsCharging (readable)
Whether the battery is charging.

```
bool IsCharging
```

##### PowerProfile (readable)
Current power profile.

```
string PowerProfile
```

#### Signals

##### BatteryLevelChanged(int level)
Emitted when battery level changes.

```
signal BatteryLevelChanged(int level)
```

### Audio Manager Interface

**Service**: `org.circleos.Audio`  
**Object Path**: `/org/circleos/Audio`  
**Interface**: `org.circleos.Audio`

#### Methods

##### SetVolume(int volume)
Sets the system volume.

```
void SetVolume(int volume)
```

**Parameters**:
- `volume`: Volume level (0-100)

##### SetMuted(bool muted)
Mutes or unmutes audio.

```
void SetMuted(bool muted)
```

#### Properties

##### Volume (readable)
Current volume level.

```
int Volume
```

##### IsMuted (readable)
Whether audio is muted.

```
bool IsMuted
```

#### Signals

##### VolumeChanged(int volume)
Emitted when volume changes.

```
signal VolumeChanged(int volume)
```

### Network Manager Interface

**Service**: `org.circleos.Network`  
**Object Path**: `/org/circleos/Network`  
**Interface**: `org.circleos.Network`

#### Methods

##### ConnectToWifi(string ssid, string password)
Connects to a Wi-Fi network.

```
void ConnectToWifi(string ssid, string password)
```

##### Disconnect()
Disconnects from current network.

```
void Disconnect()
```

#### Properties

##### IsConnected (readable)
Whether connected to a network.

```
bool IsConnected
```

##### ConnectionType (readable)
Type of connection ("wifi", "ethernet", "none").

```
string ConnectionType
```

##### SignalStrength (readable)
Wi-Fi signal strength (0-100).

```
int SignalStrength
```

## QML API

### Core Application

```qml
import CircleOS.Core 1.0

Application {
    id: app
    
    // Properties
    property string version
    property bool isRunning
    
    // Methods
    function initialize()
    function shutdown()
    
    // Signals
    signal initialized()
    signal shutdownRequested()
}
```

### Config Manager

```qml
import CircleOS.Core 1.0

ConfigManager {
    id: config
    
    // Methods
    function value(key, defaultValue)
    function setValue(key, value)
    function remove(key)
    function contains(key)
    function sync()
    
    // Signals
    signal valueChanged(string key, var value)
}
```

### System Info

```qml
import CircleOS.Core 1.0

SystemInfo {
    id: sysInfo
    
    // Properties
    property string hostname
    property string kernel
    property string osVersion
    property int totalMemory
    property int cpuCores
    
    // Methods
    function refresh()
    
    // Signals
    signal updated()
}
```

## C++ API

### Application Class

```cpp
#include <CircleOS/Core/Application.h>

CircleOS::Core::Application app;
app.initialize();

QString version = app.version();
bool running = app.isRunning();

app.shutdown();
```

### Config Manager Class

```cpp
#include <CircleOS/Core/ConfigManager.h>

CircleOS::Core::ConfigManager config;

QVariant value = config.value("key", defaultValue);
config.setValue("key", value);
config.sync();
```

## Plugin API

CircleOS supports plugins for extending functionality.

### Plugin Interface

```cpp
#include <CircleOS/Plugin/PluginInterface.h>

class MyPlugin : public CircleOS::Plugin::PluginInterface {
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.circleos.Plugin")
    Q_INTERFACES(CircleOS::Plugin::PluginInterface)
    
public:
    QString name() const override { return "MyPlugin"; }
    QString version() const override { return "1.0.0"; }
    
    bool initialize() override {
        // Plugin initialization
        return true;
    }
    
    void shutdown() override {
        // Plugin cleanup
    }
};
```

## Examples

### Launch Application via D-Bus

```bash
dbus-send --session \
    --dest=org.circleos.Shell \
    --type=method_call \
    /org/circleos/Shell \
    org.circleos.Shell.LaunchApplication \
    string:"firefox.desktop"
```

### Monitor Battery Level

```python
import dbus
from dbus.mainloop.glib import DBusGMainLoop
from gi.repository import GLib

DBusGMainLoop(set_as_default=True)

bus = dbus.SessionBus()
power = bus.get_object('org.circleos.Power', '/org/circleos/Power')

def battery_changed(level):
    print(f"Battery level: {level}%")

power.connect_to_signal('BatteryLevelChanged', battery_changed)

loop = GLib.MainLoop()
loop.run()
```
