import QtQuick
import QtQuick.Controls

Menu {
    id: root
    
    background: Rectangle {
        color: "#ffffff"
        radius: 8
        border.color: "#e0e0e0"
        border.width: 1
        
        layer.enabled: true
        layer.effect: DropShadow {
            color: "#40000000"
            radius: 8
            samples: 16
        }
    }
    
    delegate: MenuItem {
        id: menuItem
        
        contentItem: Row {
            spacing: 12
            leftPadding: 12
            rightPadding: 12
            
            Image {
                visible: menuItem.icon.source != ""
                source: menuItem.icon.source
                width: 20
                height: 20
                anchors.verticalCenter: parent.verticalCenter
            }
            
            Label {
                text: menuItem.text
                font.family: "Roboto"
                font.pixelSize: 13
                color: menuItem.enabled ? "#424242" : "#9e9e9e"
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        
        background: Rectangle {
            color: menuItem.highlighted ? "#e3f2fd" : "transparent"
            radius: 4
        }
    }
}
