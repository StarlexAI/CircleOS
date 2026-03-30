import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects

Rectangle {
    id: root
    
    anchors.centerIn: parent
    width: 800
    height: 500
    radius: 16
    color: "#ffffff"
    opacity: 0
    visible: opacity > 0
    
    layer.enabled: true
    layer.effect: MultiEffect {
        shadowEnabled: true
        shadowColor: "#80000000"
        shadowBlur: 1.0
        shadowVerticalOffset: 8
    }
    
    Behavior on opacity {
        NumberAnimation { duration: 200 }
    }
    
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 24
        spacing: 16
        
        Label {
            text: "Switch Windows"
            font.family: "Roboto"
            font.pixelSize: 18
            font.weight: Font.Medium
            color: "#212121"
        }
        
        GridView {
            id: windowGrid
            Layout.fillWidth: true
            Layout.fillHeight: true
            
            cellWidth: 240
            cellHeight: 180
            clip: true
            
            model: windowsModel
            delegate: Item {
                width: windowGrid.cellWidth
                height: windowGrid.cellHeight
                
                Rectangle {
                    anchors.fill: parent
                    anchors.margins: 8
                    radius: 12
                    color: mouseArea.containsMouse ? "#e3f2fd" : "#f5f5f5"
                    border.color: model.active ? "#2196f3" : "transparent"
                    border.width: 2
                    
                    Behavior on color {
                        ColorAnimation { duration: 150 }
                    }
                    
                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 12
                        spacing: 8
                        
                        // Window preview
                        Rectangle {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            color: "#e0e0e0"
                            radius: 8
                            
                            Image {
                                anchors.centerIn: parent
                                width: 48
                                height: 48
                                source: model.icon
                            }
                        }
                        
                        // Window title
                        Label {
                            Layout.fillWidth: true
                            text: model.title
                            font.family: "Roboto"
                            font.pixelSize: 13
                            color: "#424242"
                            elide: Text.ElideRight
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                    
                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        
                        onClicked: {
                            // Switch to window
                            root.opacity = 0
                        }
                    }
                }
            }
        }
    }
    
    ListModel {
        id: windowsModel
        
        ListElement {
            title: "Files"
            icon: "qrc:/icons/folder.svg"
            active: false
        }
        ListElement {
            title: "Terminal"
            icon: "qrc:/icons/terminal.svg"
            active: true
        }
        ListElement {
            title: "Browser"
            icon: "qrc:/icons/web.svg"
            active: false
        }
        ListElement {
            title: "Settings"
            icon: "qrc:/icons/settings.svg"
            active: false
        }
    }
    
    // Keyboard shortcuts
    Keys.onEscapePressed: root.opacity = 0
    Keys.onReturnPressed: root.opacity = 0
}
