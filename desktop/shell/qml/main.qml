import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Layouts
import "components"

Window {
    id: root
    visible: true
    visibility: Window.FullScreen
    title: "CircleOS Desktop"
    
    color: "#f5f5f5"
    
    // Desktop background with gradient
    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#e3f2fd" }
            GradientStop { position: 1.0; color: "#bbdefb" }
        }
    }
    
    // Wallpaper
    Image {
        anchors.fill: parent
        source: "qrc:/images/wallpaper.jpg"
        fillMode: Image.PreserveAspectCrop
        opacity: 0.8
    }
    
    // Desktop icons area
    GridView {
        id: desktopIcons
        anchors {
            fill: parent
            topMargin: 60
            bottomMargin: 80
            leftMargin: 20
            rightMargin: 20
        }
        
        cellWidth: 120
        cellHeight: 120
        
        model: desktopModel
        delegate: DesktopIcon {}
    }
    
    // Top Panel
    TopPanel {
        id: topPanel
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        height: 48
    }
    
    // Dock
    Dock {
        id: dock
        anchors {
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
            bottomMargin: 12
        }
    }
    
    // App Launcher
    AppLauncher {
        id: appLauncher
        anchors.centerIn: parent
        visible: false
    }
    
    // Notification Center
    NotificationCenter {
        id: notificationCenter
        anchors {
            top: topPanel.bottom
            right: parent.right
            topMargin: 8
            rightMargin: 8
        }
        width: 380
        visible: false
    }
    
    // Desktop model
    ListModel {
        id: desktopModel
        ListElement { name: "Home"; icon: "folder-home"; path: "/home" }
        ListElement { name: "Documents"; icon: "folder-documents"; path: "/home/documents" }
        ListElement { name: "Downloads"; icon: "folder-download"; path: "/home/downloads" }
    }
    
    // Connections
    Connections {
        target: topPanel
        function onLauncherClicked() {
            appLauncher.visible = !appLauncher.visible
        }
        function onNotificationsClicked() {
            notificationCenter.visible = !notificationCenter.visible
        }
    }
}
