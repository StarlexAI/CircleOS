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
            radius: 32
            color: "#f5f5f5"
            anchors.horizontalCenter: parent.horizontalCenter
            
            Image {
                anchors.centerIn: parent
                width: 40
                height: 40
                source: model.icon
                sourceSize: Qt.size(width, height)
                smooth: true
            }
            
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: launchApp(model.exec)
                
                onEntered: parent.color = "#e0e0e0"
                onExited: parent.color = "#f5f5f5"
            }
        }
        
        Label {
            text: model.name
            font.family: "Roboto"
            font.pixelSize: 12
            color: "#424242"
            anchors.horizontalCenter: parent.horizontalCenter
            width: 100
            horizontalAlignment: Text.AlignHCenter
            elide: Text.ElideRight
        }
    }
    
    function launchApp(exec) {
        console.log("Launching:", exec)
        root.visible = false
    }
}
