import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects

Rectangle {
    id: root
    
    anchors.centerIn: parent
    width: 400
    height: 300
    radius: 16
    color: "#ffffff"
    opacity: 0
    visible: opacity > 0
    
    signal lockRequested()
    signal logoutRequested()
    signal suspendRequested()
    signal rebootRequested()
    signal shutdownRequested()
    
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
            text: "Power Options"
            font.family: "Roboto"
            font.pixelSize: 18
            font.weight: Font.Medium
            color: "#212121"
            Layout.alignment: Qt.AlignHCenter
        }
        
        GridLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            columns: 2
            rowSpacing: 16
            columnSpacing: 16
            
            Button {
                Layout.fillWidth: true
                Layout.fillHeight: true
                
                property string icon: "qrc:/icons/lock.svg"
                property string label: "Lock"
                
                background: Rectangle {
                    color: parent.pressed ? "#e0e0e0" : parent.hovered ? "#f5f5f5" : "#fafafa"
                    radius: 12
                    border.color: "#e0e0e0"
                    border.width: 1
                    
                    Behavior on color {
                        ColorAnimation { duration: 150 }
                    }
                }
                
                contentItem: ColumnLayout {
                    spacing: 8
                    
                    Rectangle {
                        Layout.alignment: Qt.AlignHCenter
                        width: 48
                        height: 48
                        radius: 24
                        color: "#e3f2fd"
                        
                        Image {
                            anchors.centerIn: parent
                            width: 24
                            height: 24
                            source: parent.parent.parent.parent.icon
                            sourceSize: Qt.size(width, height)
                        }
                    }
                    
                    Label {
                        Layout.alignment: Qt.AlignHCenter
                        text: parent.parent.parent.label
                        font.family: "Roboto"
                        font.pixelSize: 13
                        color: "#424242"
                    }
                }
                
                onClicked: {
                    root.lockRequested()
                    root.opacity = 0
                }
            }
            
            Button {
                Layout.fillWidth: true
                Layout.fillHeight: true
                
                property string icon: "qrc:/icons/logout.svg"
                property string label: "Logout"
                
                background: Rectangle {
                    color: parent.pressed ? "#e0e0e0" : parent.hovered ? "#f5f5f5" : "#fafafa"
                    radius: 12
                    border.color: "#e0e0e0"
                    border.width: 1
                    
                    Behavior on color {
                        ColorAnimation { duration: 150 }
                    }
                }
                
                contentItem: ColumnLayout {
                    spacing: 8
                    
                    Rectangle {
                        Layout.alignment: Qt.AlignHCenter
                        width: 48
                        height: 48
                        radius: 24
                        color: "#e3f2fd"
                        
                        Image {
                            anchors.centerIn: parent
                            width: 24
                            height: 24
                            source: parent.parent.parent.parent.icon
                            sourceSize: Qt.size(width, height)
                        }
                    }
                    
                    Label {
                        Layout.alignment: Qt.AlignHCenter
                        text: parent.parent.parent.label
                        font.family: "Roboto"
                        font.pixelSize: 13
                        color: "#424242"
                    }
                }
                
                onClicked: {
                    root.logoutRequested()
                    root.opacity = 0
                }
            }
            
            Button {
                Layout.fillWidth: true
                Layout.fillHeight: true
                
                property string icon: "qrc:/icons/sleep.svg"
                property string label: "Suspend"
                
                background: Rectangle {
                    color: parent.pressed ? "#e0e0e0" : parent.hovered ? "#f5f5f5" : "#fafafa"
                    radius: 12
                    border.color: "#e0e0e0"
                    border.width: 1
                    
                    Behavior on color {
                        ColorAnimation { duration: 150 }
                    }
                }
                
                contentItem: ColumnLayout {
                    spacing: 8
                    
                    Rectangle {
                        Layout.alignment: Qt.AlignHCenter
                        width: 48
                        height: 48
                        radius: 24
                        color: "#e3f2fd"
                        
                        Image {
                            anchors.centerIn: parent
                            width: 24
                            height: 24
                            source: parent.parent.parent.parent.icon
                            sourceSize: Qt.size(width, height)
                        }
                    }
                    
                    Label {
                        Layout.alignment: Qt.AlignHCenter
                        text: parent.parent.parent.label
                        font.family: "Roboto"
                        font.pixelSize: 13
                        color: "#424242"
                    }
                }
                
                onClicked: {
                    root.suspendRequested()
                    root.opacity = 0
                }
            }
            
            Button {
                Layout.fillWidth: true
                Layout.fillHeight: true
                
                property string icon: "qrc:/icons/restart.svg"
                property string label: "Restart"
                
                background: Rectangle {
                    color: parent.pressed ? "#e0e0e0" : parent.hovered ? "#f5f5f5" : "#fafafa"
                    radius: 12
                    border.color: "#e0e0e0"
                    border.width: 1
                    
                    Behavior on color {
                        ColorAnimation { duration: 150 }
                    }
                }
                
                contentItem: ColumnLayout {
                    spacing: 8
                    
                    Rectangle {
                        Layout.alignment: Qt.AlignHCenter
                        width: 48
                        height: 48
                        radius: 24
                        color: "#e3f2fd"
                        
                        Image {
                            anchors.centerIn: parent
                            width: 24
                            height: 24
                            source: parent.parent.parent.parent.icon
                            sourceSize: Qt.size(width, height)
                        }
                    }
                    
                    Label {
                        Layout.alignment: Qt.AlignHCenter
                        text: parent.parent.parent.label
                        font.family: "Roboto"
                        font.pixelSize: 13
                        color: "#424242"
                    }
                }
                
                onClicked: {
                    root.rebootRequested()
                    root.opacity = 0
                }
            }
        }
        
        Button {
            Layout.fillWidth: true
            Layout.preferredHeight: 48
            text: "Shutdown"
            font.family: "Roboto"
            font.pixelSize: 14
            font.weight: Font.Medium
            
            background: Rectangle {
                color: parent.pressed ? "#d32f2f" : "#f44336"
                radius: 24
            }
            
            contentItem: Text {
                text: parent.text
                font: parent.font
                color: "#ffffff"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            
            onClicked: {
                root.shutdownRequested()
                root.opacity = 0
            }
        }
        
        Button {
            Layout.fillWidth: true
            text: "Cancel"
            flat: true
            font.family: "Roboto"
            font.pixelSize: 14
            
            onClicked: root.opacity = 0
        }
    }
    
    Keys.onEscapePressed: root.opacity = 0
    
    // PowerOption component definition
    Component {
        id: powerOptionComponent
        
        Button {
            id: option
            
            property alias icon: iconImage.source
            property alias label: labelText.text
            
            background: Rectangle {
                color: option.pressed ? "#e0e0e0" : option.hovered ? "#f5f5f5" : "#fafafa"
                radius: 12
                border.color: "#e0e0e0"
                border.width: 1
                
                Behavior on color {
                    ColorAnimation { duration: 150 }
                }
            }
            
            contentItem: ColumnLayout {
                spacing: 8
                
                Rectangle {
                    Layout.alignment: Qt.AlignHCenter
                    width: 48
                    height: 48
                    radius: 24
                    color: "#e3f2fd"
                    
                    Image {
                        id: iconImage
                        anchors.centerIn: parent
                        width: 24
                        height: 24
                        sourceSize: Qt.size(width, height)
                    }
                }
                
                Label {
                    id: labelText
                    Layout.alignment: Qt.AlignHCenter
                    font.family: "Roboto"
                    font.pixelSize: 13
                    color: "#424242"
                }
            }
        }
    }
}
