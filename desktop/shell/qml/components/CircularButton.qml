import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Item {
    id: root
    
    property alias iconSource: icon.source
    property alias tooltip: toolTip.text
    property color backgroundColor: "#f5f5f5"
    property color hoverColor: "#e0e0e0"
    property color pressColor: "#bdbdbd"
    
    signal clicked()
    
    width: 40
    height: 40
    
    Rectangle {
        id: background
        anchors.fill: parent
        radius: width / 2
        color: {
            if (mouseArea.pressed) return root.pressColor
            if (mouseArea.containsMouse) return root.hoverColor
            return root.backgroundColor
        }
        
        Behavior on color {
            ColorAnimation { duration: 150 }
        }
        
        // Circular shadow
        layer.enabled: true
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor: "#40000000"
            shadowBlur: 0.3
            shadowVerticalOffset: 2
        }
    }
    
    Image {
        id: icon
        anchors.centerIn: parent
        width: parent.width * 0.5
        height: parent.height * 0.5
        sourceSize: Qt.size(width, height)
        smooth: true
    }
    
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }
    
    ToolTip {
        id: toolTip
        visible: mouseArea.containsMouse && text.length > 0
        delay: 500
        
        background: Rectangle {
            color: "#424242"
            radius: 4
        }
        
        contentItem: Text {
            text: toolTip.text
            color: "#ffffff"
            font.family: "Roboto"
            font.pixelSize: 12
        }
    }
    
    // Ripple effect on click
    Rectangle {
        id: ripple
        anchors.centerIn: parent
        width: 0
        height: width
        radius: width / 2
        color: "#40000000"
        opacity: 0
        
        ParallelAnimation {
            id: rippleAnimation
            NumberAnimation {
                target: ripple
                property: "width"
                from: 0
                to: root.width * 2
                duration: 300
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: ripple
                property: "opacity"
                from: 1
                to: 0
                duration: 300
            }
        }
    }
    
    Connections {
        target: mouseArea
        function onClicked() {
            rippleAnimation.restart()
        }
    }
}
