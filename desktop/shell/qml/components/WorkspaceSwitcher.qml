import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    
    width: 600
    height: 400
    radius: 16
    color: "#ffffff"
    opacity: 0
    visible: opacity > 0
    
    property int currentWorkspace: 1
    property int totalWorkspaces: 4
    
    signal workspaceChanged(int workspace)
    
    Behavior on opacity {
        NumberAnimation { duration: 200 }
    }
    
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 24
        spacing: 16
        
        Label {
            text: "Workspaces"
            font.family: "Roboto"
            font.pixelSize: 18
            font.weight: Font.Medium
            color: "#212121"
        }
        
        GridLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            columns: 2
            rowSpacing: 16
            columnSpacing: 16
            
            Repeater {
                model: root.totalWorkspaces
                
                delegate: Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    radius: 12
                    color: (index + 1) === root.currentWorkspace ? "#e3f2fd" : "#f5f5f5"
                    border.color: (index + 1) === root.currentWorkspace ? "#2196f3" : "transparent"
                    border.width: 2
                    
                    Behavior on color {
                        ColorAnimation { duration: 150 }
                    }
                    
                    ColumnLayout {
                        anchors.centerIn: parent
                        spacing: 8
                        
                        Rectangle {
                            Layout.alignment: Qt.AlignHCenter
                            width: 48
                            height: 48
                            radius: 24
                            color: (index + 1) === root.currentWorkspace ? "#2196f3" : "#e0e0e0"
                            
                            Label {
                                anchors.centerIn: parent
                                text: (index + 1).toString()
                                font.family: "Roboto"
                                font.pixelSize: 20
                                font.weight: Font.Medium
                                color: (index + 1) === root.currentWorkspace ? "#ffffff" : "#757575"
                            }
                        }
                        
                        Label {
                            Layout.alignment: Qt.AlignHCenter
                            text: "Workspace " + (index + 1)
                            font.family: "Roboto"
                            font.pixelSize: 13
                            color: "#424242"
                        }
                    }
                    
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        
                        onClicked: {
                            root.currentWorkspace = index + 1
                            root.workspaceChanged(index + 1)
                            root.opacity = 0
                        }
                    }
                }
            }
        }
    }
    
    Keys.onEscapePressed: root.opacity = 0
}
