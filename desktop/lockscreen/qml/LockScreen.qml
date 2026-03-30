import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects

Rectangle {
    id: root
    anchors.fill: parent
    
    // Blurred background
    Image {
        anchors.fill: parent
        source: "qrc:/images/wallpaper.jpg"
        fillMode: Image.PreserveAspectCrop
        
        layer.enabled: true
        layer.effect: MultiEffect {
            blurEnabled: true
            blur: 1.0
            brightness: -0.3
        }
    }
    
    // Lock screen content
    ColumnLayout {
        anchors.centerIn: parent
        spacing: 32
        width: 400
        
        // Clock
        Column {
            Layout.alignment: Qt.AlignHCenter
            spacing: 8
            
            Label {
                id: timeLabel
                anchors.horizontalCenter: parent.horizontalCenter
                text: Qt.formatDateTime(new Date(), "hh:mm")
                font.family: "Roboto"
                font.pixelSize: 96
                font.weight: Font.Light
                color: "#ffffff"
                
                Timer {
                    interval: 1000
                    running: true
                    repeat: true
                    onTriggered: {
                        timeLabel.text = Qt.formatDateTime(new Date(), "hh:mm")
                        dateLabel.text = Qt.formatDateTime(new Date(), "dddd, MMMM d")
                    }
                }
            }
            
            Label {
                id: dateLabel
                anchors.horizontalCenter: parent.horizontalCenter
                text: Qt.formatDateTime(new Date(), "dddd, MMMM d")
                font.family: "Roboto"
                font.pixelSize: 24
                font.weight: Font.Normal
                color: "#ffffff"
                opacity: 0.9
            }
        }
        
        // User avatar
        Rectangle {
            Layout.alignment: Qt.AlignHCenter
            width: 96
            height: 96
            radius: 48
            color: "#2196f3"
            
            Label {
                anchors.centerIn: parent
                text: "U"
                font.family: "Roboto"
                font.pixelSize: 48
                font.weight: Font.Medium
                color: "#ffffff"
            }
        }
        
        // Username
        Label {
            Layout.alignment: Qt.AlignHCenter
            text: "User"
            font.family: "Roboto"
            font.pixelSize: 24
            font.weight: Font.Medium
            color: "#ffffff"
        }
        
        // Password field
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 56
            radius: 28
            color: "#40ffffff"
            
            RowLayout {
                anchors.fill: parent
                anchors.margins: 16
                spacing: 12
                
                Image {
                    Layout.preferredWidth: 24
                    Layout.preferredHeight: 24
                    source: "qrc:/icons/lock.svg"
                }
                
                TextField {
                    id: passwordField
                    Layout.fillWidth: true
                    placeholderText: "Enter password"
                    echoMode: TextInput.Password
                    font.family: "Roboto"
                    font.pixelSize: 16
                    color: "#ffffff"
                    
                    background: Item {}
                    
                    Keys.onReturnPressed: unlock()
                }
                
                Button {
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 40
                    
                    background: Rectangle {
                        radius: 20
                        color: parent.pressed ? "#2196f3" : "#40ffffff"
                    }
                    
                    contentItem: Image {
                        source: "qrc:/icons/arrow-forward.svg"
                        sourceSize: Qt.size(24, 24)
                    }
                    
                    onClicked: unlock()
                }
            }
        }
        
        // Error message
        Label {
            id: errorLabel
            Layout.alignment: Qt.AlignHCenter
            text: ""
            font.family: "Roboto"
            font.pixelSize: 14
            color: "#f44336"
            visible: text.length > 0
        }
    }
    
    function unlock() {
        if (passwordField.text.length > 0) {
            // TODO: Implement actual authentication
            console.log("Unlocking...")
            root.visible = false
        } else {
            errorLabel.text = "Please enter a password"
        }
    }
}
