import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects

Rectangle {
    id: root
    
    width: 720
    height: 580
    radius: 24
    color: "#ffffff"
    
    layer.enabled: true
    layer.effect: MultiEffect {
        shadowEnabled: true
        shadowColor: "#80000000"
        shadowBlur: 1.0
        shadowVerticalOffset: 8
    }
    
    // Fade in/out animation
    opacity: 0
    visible: opacity > 0
    
    Behavior on opacity {
        NumberAnimation { duration: 200 }
    }
    
    onVisibleChanged: {
        if (visible) {
            opacity = 1
            searchField.forceActiveFocus()
        } else {
            opacity = 0
        }
    }
    
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 24
        spacing: 16
        
        // Search bar
        TextField {
            id: searchField
            Layout.fillWidth: true
            Layout.preferredHeight: 48
            
            placeholderText: "Search applications..."
            font.family: "Roboto"
            font.pixelSize: 16
            
            background: Rectangle {
                radius: 24
                color: "#f5f5f5"
                border.color: searchField.activeFocus ? "#2196f3" : "transparent"
                border.width: 2
            }
            
            leftPadding: 48
            
            Image {
                anchors.left: parent.left
                anchors.leftMargin: 16
                anchors.verticalCenter: parent.verticalCenter
                width: 20
                height: 20
                source: "qrc:/icons/search.svg"
            }
        }
        
        // App categories
        Row {
            Layout.fillWidth: true
            spacing: 8
            
            Repeater {
                model: ["All", "Internet", "Office", "Graphics", "Development", "System"]
                
                Button {
                    text: modelData
                    flat: true
                    font.family: "Roboto"
                    font.pixelSize: 13
                    
                    background: Rectangle {
                        radius: 16
                        color: parent.checked ? "#2196f3" : "#f5f5f5"
                    }
                    
                    contentItem: Text {
                        text: parent.text
                        font: parent.font
                        color: parent.checked ? "#ffffff" : "#424242"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
        }
        
        // App grid
        GridView {
            id: appGrid
            Layout.fillWidth: true
            Layout.fillHeight: true
            
            cellWidth: 120
            cellHeight: 120
            clip: true
            
            model: appsModel
            delegate: AppIcon {}
            
            ScrollBar.vertical: ScrollBar {
                policy: ScrollBar.AsNeeded
            }
        }
    }
    
    ListModel {
        id: appsModel
        
        ListElement { name: "Files"; icon: "qrc:/icons/folder.svg"; exec: "circleos-files" }
        ListElement { name: "Terminal"; icon: "qrc:/icons/terminal.svg"; exec: "circleos-terminal" }
        ListElement { name: "Browser"; icon: "qrc:/icons/web.svg"; exec: "firefox" }
        ListElement { name: "Settings"; icon: "qrc:/icons/settings.svg"; exec: "circleos-settings" }
        ListElement { name: "Store"; icon: "qrc:/icons/shopping.svg"; exec: "circleos-store" }
        ListElement { name: "Calculator"; icon: "qrc:/icons/calculator.svg"; exec: "gnome-calculator" }
        ListElement { name: "Text Editor"; icon: "qrc:/icons/edit.svg"; exec: "circleos-editor" }
        ListElement { name: "Music"; icon: "qrc:/icons/music.svg"; exec: "circleos-music" }
        ListElement { name: "Videos"; icon: "qrc:/icons/video.svg"; exec: "circleos-videos" }
        ListElement { name: "Photos"; icon: "qrc:/icons/photo.svg"; exec: "circleos-photos" }
        ListElement { name: "Calendar"; icon: "qrc:/icons/calendar.svg"; exec: "circleos-calendar" }
        ListElement { name: "Mail"; icon: "qrc:/icons/mail.svg"; exec: "circleos-mail" }
    }
    
    // Close on Escape
    Keys.onEscapePressed: root.visible = false
    
    // Click outside to close
    MouseArea {
        anchors.fill: parent
        z: -1
        onClicked: root.visible = false
    }
}
