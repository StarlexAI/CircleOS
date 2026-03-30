import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects

Rectangle {
    id: root
    color: "#ffffff"
    
    signal launcherClicked()
    signal notificationsClicked()
    
    // Blur effect for modern look
    layer.enabled: true
    layer.effect: MultiEffect {
        blurEnabled: true
        blur: 0.4
        saturation: 0.1
    }
    
    opacity: 0.95
    
    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 12
        anchors.rightMargin: 12
        spacing: 12
        
        // App Launcher Button (Circular)
        CircularButton {
            id: launcherBtn
            Layout.preferredWidth: 36
            Layout.preferredHeight: 36
            iconSource: "qrc:/icons/apps.svg"
            tooltip: "Applications"
            onClicked: root.launcherClicked()
        }
        
        // Active Window Title
        Label {
            id: windowTitle
            Layout.fillWidth: true
            text: "CircleOS Desktop"
            font.family: "Roboto"
            font.pixelSize: 14
            font.weight: Font.Medium
            color: "#212121"
            elide: Text.ElideRight
        }
        
        // System Tray
        Row {
            spacing: 8
            
            // Network indicator
            CircularButton {
                width: 32
                height: 32
                iconSource: "qrc:/icons/network-wifi.svg"
                tooltip: "Network"
            }
            
            // Volume indicator
            CircularButton {
                width: 32
                height: 32
                iconSource: "qrc:/icons/volume-high.svg"
                tooltip: "Volume"
            }
            
            // Battery indicator
            CircularButton {
                width: 32
                height: 32
                iconSource: "qrc:/icons/battery-full.svg"
                tooltip: "Battery: 85%"
            }
        }
        
        // Clock
        Label {
            id: clock
            text: Qt.formatDateTime(new Date(), "hh:mm")
            font.family: "Roboto"
            font.pixelSize: 14
            font.weight: Font.Medium
            color: "#212121"
            
            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: clock.text = Qt.formatDateTime(new Date(), "hh:mm")
            }
        }
        
        // Notifications button
        CircularButton {
            Layout.preferredWidth: 36
            Layout.preferredHeight: 36
            iconSource: "qrc:/icons/notifications.svg"
            tooltip: "Notifications"
            onClicked: root.notificationsClicked()
        }
        
        // User menu
        CircularButton {
            Layout.preferredWidth: 36
            Layout.preferredHeight: 36
            iconSource: "qrc:/icons/account-circle.svg"
            tooltip: "User Menu"
        }
    }
    
    // Bottom border
    Rectangle {
        anchors.bottom: parent.bottom
        width: parent.width
        height: 1
        color: "#e0e0e0"
    }
}
