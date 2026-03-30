import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Rectangle {
    id: root
    
    width: dockLayout.width + 24
    height: 64
    radius: 32
    color: "#ffffff"
    opacity: 0.95
    
    // Blur and shadow effects
    layer.enabled: true
    layer.effect: MultiEffect {
        blurEnabled: true
        blur: 0.4
        shadowEnabled: true
        shadowColor: "#60000000"
        shadowBlur: 0.5
        shadowVerticalOffset: 4
    }
    
    Row {
        id: dockLayout
        anchors.centerIn: parent
        spacing: 8
        
        Repeater {
            model: dockModel
            
            DockIcon {
                iconSource: model.icon
                appName: model.name
                isActive: model.active
                onClicked: launchApp(model.exec)
            }
        }
    }
    
    ListModel {
        id: dockModel
        
        ListElement {
            name: "Files"
            icon: "qrc:/icons/folder.svg"
            exec: "circleos-files"
            active: false
        }
        ListElement {
            name: "Terminal"
            icon: "qrc:/icons/terminal.svg"
            exec: "circleos-terminal"
            active: false
        }
        ListElement {
            name: "Browser"
            icon: "qrc:/icons/web.svg"
            exec: "firefox"
            active: false
        }
        ListElement {
            name: "Settings"
            icon: "qrc:/icons/settings.svg"
            exec: "circleos-settings"
            active: false
        }
        ListElement {
            name: "Store"
            icon: "qrc:/icons/shopping.svg"
            exec: "circleos-store"
            active: false
        }
    }
    
    function launchApp(exec) {
        console.log("Launching:", exec)
        // TODO: Implement app launching via D-Bus
    }
}
