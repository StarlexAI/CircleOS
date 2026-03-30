import QtQuick
import QtWayland.Compositor
import QtQuick.Window

WaylandCompositor {
    id: compositor
    
    WaylandOutput {
        compositor: compositor
        sizeFollowsWindow: true
        
        window: Window {
            id: window
            width: 1920
            height: 1080
            visible: true
            title: "CircleOS Compositor"
            
            WaylandMouseTracker {
                id: mouseTracker
                anchors.fill: parent
                windowSystemCursorEnabled: true
                
                // Desktop background
                Rectangle {
                    anchors.fill: parent
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#e3f2fd" }
                        GradientStop { position: 1.0; color: "#bbdefb" }
                    }
                }
                
                // Window rendering area
                Repeater {
                    model: shellSurfaces
                    
                    ShellSurfaceItem {
                        shellSurface: modelData
                        onSurfaceDestroyed: shellSurfaces.remove(index)
                        
                        // Window decorations
                        Rectangle {
                            anchors.fill: parent
                            anchors.margins: -4
                            color: "transparent"
                            border.color: parent.activeFocus ? "#2196f3" : "#e0e0e0"
                            border.width: 2
                            radius: 12
                            z: -1
                        }
                    }
                }
            }
        }
    }
    
    ListModel {
        id: shellSurfaces
    }
    
    WlShell {
        onWlShellSurfaceCreated: shellSurfaces.append({shellSurface: shellSurface})
    }
    
    XdgShell {
        onToplevelCreated: shellSurfaces.append({shellSurface: xdgSurface})
    }
}
