import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Item {
    id: root
    
    property alias iconSource: icon.source
    property string appName: ""
    property bool isActive: false
    
    signal clicked()
    
    width: 48
    height: 48
    
    scale: mouseArea.containsMouse ? 1.2 : 1.0
    
    Behavior on scale {
        NumberAnimation {
            duration: 200
            easing.type: Easing.OutBack
        }
    }
    
    Rectangle {
        id: iconBackground
        anchors.fill: parent
        radius: width / 2
        color: isActive ? "#e3f2fd" : "transparent"
        
        Behavior on color {
            ColorAnimation { duration: 150 }
        }
    }
    
    Image {
        id: icon
        anchors.centerIn: parent
        width: 32
        height: 32
        sourceSize: Qt.size(width, height)
        smooth: true
    }
    
    // Active indicator
    Rectangle {
        visible: isActive
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: -8
        width: 4
        height: 4
        radius: 2
        color: "#2196f3"
    }
    
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }
    
    ToolTip {
        visible: mouseArea.containsMouse
        text: appName
        delay: 500
        
        background: Rectangle {
            color: "#424242"
            radius: 4
        }
        
        contentItem: Text {
            text: appName
            color: "#ffffff"
            font.family: "Roboto"
            font.pixelSize: 12
        }
    }
}
