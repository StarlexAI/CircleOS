import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects

Rectangle {
    id: root
    
    height: 600
    radius: 16
    color: "#ffffff"
    
    layer.enabled: true
    layer.effect: MultiEffect {
        shadowEnabled: true
        shadowColor: "#60000000"
        shadowBlur: 0.8
        shadowVerticalOffset: 4
    }
    
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 12
        
        // Header
        RowLayout {
            Layout.fillWidth: true
            
            Label {
                text: "Notifications"
                font.family: "Roboto"
                font.pixelSize: 18
                font.weight: Font.Medium
                color: "#212121"
                Layout.fillWidth: true
            }
            
            Button {
                text: "Clear All"
                flat: true
                font.family: "Roboto"
                font.pixelSize: 12
                onClicked: notificationsModel.clear()
            }
        }
        
        Rectangle {
            Layout.fillWidth: true
            height: 1
            color: "#e0e0e0"
        }
        
        // Notifications list
        ListView {
            id: notificationsList
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 8
            clip: true
            
            model: notificationsModel
            delegate: notificationItemDelegate
            
            ScrollBar.vertical: ScrollBar {}
        }
        
        // Empty state
        Label {
            visible: notificationsModel.count === 0
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: "No notifications"
            font.family: "Roboto"
            font.pixelSize: 14
            color: "#9e9e9e"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
    
    ListModel {
        id: notificationsModel
        
        ListElement {
            title: "System Update Available"
            message: "CircleOS 1.0.1 is ready to install"
            icon: "qrc:/icons/system-update.svg"
            time: "5 min ago"
        }
        ListElement {
            title: "Battery Low"
            message: "15% remaining. Please connect charger."
            icon: "qrc:/icons/battery-alert.svg"
            time: "10 min ago"
        }
        ListElement {
            title: "New Email"
            message: "You have 3 unread messages"
            icon: "qrc:/icons/mail.svg"
            time: "1 hour ago"
        }
    }
    
    Component {
        id: notificationItemDelegate
    
    Rectangle {
        width: ListView.view.width
        height: 80
        radius: 8
        color: mouseArea.containsMouse ? "#f5f5f5" : "transparent"
        
        RowLayout {
            anchors.fill: parent
            anchors.margins: 12
            spacing: 12
            
            Rectangle {
                Layout.preferredWidth: 40
                Layout.preferredHeight: 40
                radius: 20
                color: "#e3f2fd"
                
                Image {
                    anchors.centerIn: parent
                    width: 24
                    height: 24
                    source: model.icon
                }
            }
            
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 4
                
                Label {
                    text: model.title
                    font.family: "Roboto"
                    font.pixelSize: 14
                    font.weight: Font.Medium
                    color: "#212121"
                    Layout.fillWidth: true
                    elide: Text.ElideRight
                }
                
                Label {
                    text: model.message
                    font.family: "Roboto"
                    font.pixelSize: 12
                    color: "#757575"
                    Layout.fillWidth: true
                    elide: Text.ElideRight
                    wrapMode: Text.WordWrap
                    maximumLineCount: 2
                }
                
                Label {
                    text: model.time
                    font.family: "Roboto"
                    font.pixelSize: 11
                    color: "#9e9e9e"
                }
            }
            
            Button {
                text: "×"
                flat: true
                font.pixelSize: 20
                Layout.preferredWidth: 32
                Layout.preferredHeight: 32
                onClicked: notificationsModel.remove(index)
            }
        }
        
        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            z: -1
        }
    }
    }
}
