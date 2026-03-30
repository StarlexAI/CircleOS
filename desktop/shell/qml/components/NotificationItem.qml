import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    
    property string title: ""
    property string message: ""
    property string icon: ""
    property string time: ""
    
    width: parent ? parent.width : 360
    height: 80
    radius: 8
    color: mouseArea.containsMouse ? "#f5f5f5" : "transparent"
    
    Behavior on color {
        ColorAnimation { duration: 150 }
    }
    
    RowLayout {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 12
        
        // Icon
        Rectangle {
            Layout.preferredWidth: 40
            Layout.preferredHeight: 40
            radius: 20
            color: "#e3f2fd"
            
            Image {
                anchors.centerIn: parent
                width: 24
                height: 24
                source: root.icon
                sourceSize: Qt.size(width, height)
                smooth: true
            }
        }
        
        // Content
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 4
            
            Label {
                text: root.title
                font.family: "Roboto"
                font.pixelSize: 14
                font.weight: Font.Medium
                color: "#212121"
                Layout.fillWidth: true
                elide: Text.ElideRight
            }
            
            Label {
                text: root.message
                font.family: "Roboto"
                font.pixelSize: 12
                color: "#757575"
                Layout.fillWidth: true
                elide: Text.ElideRight
                wrapMode: Text.WordWrap
                maximumLineCount: 2
            }
            
            Label {
                text: root.time
                font.family: "Roboto"
                font.pixelSize: 11
                color: "#9e9e9e"
            }
        }
        
        // Close button
        Button {
            text: "×"
            flat: true
            font.pixelSize: 20
            Layout.preferredWidth: 32
            Layout.preferredHeight: 32
            
            background: Rectangle {
                radius: 16
                color: parent.hovered ? "#e0e0e0" : "transparent"
            }
        }
    }
    
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        z: -1
        
        onClicked: {
            // Handle notification click
        }
    }
}
