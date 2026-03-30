import QtQuick
import QtQuick.Controls

Item {
    width: GridView.view.cellWidth
    height: GridView.view.cellHeight
    
    Column {
        anchors.centerIn: parent
        spacing: 8
        
        Rectangle {
            width: 64
            height: 64
            radius: 12
            color: "transparent"
            anchors.horizontalCenter: parent.horizontalCenter
            
            Image {
                anchors.centerIn: parent
                width: 48
                height: 48
                source: "qrc:/icons/" + model.icon + ".svg"
                sourceSize: Qt.size(width, height)
                smooth: true
            }
        }
        
        Label {
            text: model.name
            font.family: "Roboto"
            font.pixelSize: 13
            color: "#212121"
            anchors.horizontalCenter: parent.horizontalCenter
            
            background: Rectangle {
                color: "#e0ffffff"
                radius: 4
            }
            
            padding: 4
        }
    }
    
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onDoubleClicked: openItem(model.path)
    }
    
    function openItem(path) {
        console.log("Opening:", path)
    }
}
