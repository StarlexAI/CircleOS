import QtQuick
import QtQuick.Controls

Item {
    id: root
    
    property int workspaceNumber: 1
    property bool active: false
    property var windows: []
    
    signal activated()
    signal windowAdded(var window)
    signal windowRemoved(var window)
    
    // Workspace background
    Rectangle {
        anchors.fill: parent
        color: "transparent"
        
        // Grid for window positioning
        Grid {
            id: windowGrid
            anchors.fill: parent
            anchors.margins: 20
            columns: 3
            rows: 3
            spacing: 10
            
            Repeater {
                model: root.windows
                
                delegate: Rectangle {
                    width: (windowGrid.width - windowGrid.spacing * 2) / 3
                    height: (windowGrid.height - windowGrid.spacing * 2) / 3
                    color: "#ffffff"
                    radius: 8
                    border.color: "#e0e0e0"
                    border.width: 1
                    
                    Label {
                        anchors.centerIn: parent
                        text: modelData.title || "Window"
                        font.family: "Roboto"
                        font.pixelSize: 14
                        color: "#424242"
                    }
                    
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            // Focus window
                        }
                    }
                }
            }
        }
    }
    
    // Workspace indicator
    Rectangle {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 20
        width: 40
        height: 40
        radius: 20
        color: root.active ? "#2196f3" : "#e0e0e0"
        
        Label {
            anchors.centerIn: parent
            text: root.workspaceNumber.toString()
            font.family: "Roboto"
            font.pixelSize: 16
            font.weight: Font.Medium
            color: root.active ? "#ffffff" : "#757575"
        }
        
        Behavior on color {
            ColorAnimation { duration: 200 }
        }
    }
    
    function addWindow(window) {
        windows.push(window)
        windowAdded(window)
    }
    
    function removeWindow(window) {
        var index = windows.indexOf(window)
        if (index > -1) {
            windows.splice(index, 1)
            windowRemoved(window)
        }
    }
}
