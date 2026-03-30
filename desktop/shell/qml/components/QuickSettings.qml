import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects

Rectangle {
    id: root
    
    width: 380
    height: 500
    radius: 16
    color: "#ffffff"
    
    layer.enabled: true
    layer.effect: MultiEffect {
        shadowEnabled: true
        shadowColor: "#60000000"
        shadowBlur: 0.8
        shadowVerticalOffset: 4
    }
    
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 16
        
        // Header
        Label {
            text: "Quick Settings"
            font.family: "Roboto"
            font.pixelSize: 18
            font.weight: Font.Medium
            color: "#212121"
        }
        
        // Quick toggles grid
        GridLayout {
            Layout.fillWidth: true
            columns: 2
            rowSpacing: 12
            columnSpacing: 12
            
            Button {
                Layout.fillWidth: true
                
                property string icon: "qrc:/icons/wifi.svg"
                property string label: "Wi-Fi"
                property bool checked: true
                
                checkable: true
                height: 80
                
                background: Rectangle {
                    color: parent.checked ? "#e3f2fd" : "#f5f5f5"
                    radius: 12
                    border.color: parent.checked ? "#2196f3" : "transparent"
                    border.width: 2
                    
                    Behavior on color {
                        ColorAnimation { duration: 150 }
                    }
                }
                
                contentItem: ColumnLayout {
                    spacing: 8
                    
                    Image {
                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredWidth: 24
                        Layout.preferredHeight: 24
                        source: parent.parent.parent.icon
                        sourceSize: Qt.size(width, height)
                    }
                    
                    Label {
                        Layout.alignment: Qt.AlignHCenter
                        text: parent.parent.parent.label
                        font.family: "Roboto"
                        font.pixelSize: 12
                        color: parent.parent.parent.checked ? "#2196f3" : "#424242"
                    }
                }
            }
            
            Button {
                Layout.fillWidth: true
                
                property string icon: "qrc:/icons/bluetooth.svg"
                property string label: "Bluetooth"
                property bool checked: false
                
                checkable: true
                height: 80
                
                background: Rectangle {
                    color: parent.checked ? "#e3f2fd" : "#f5f5f5"
                    radius: 12
                    border.color: parent.checked ? "#2196f3" : "transparent"
                    border.width: 2
                    
                    Behavior on color {
                        ColorAnimation { duration: 150 }
                    }
                }
                
                contentItem: ColumnLayout {
                    spacing: 8
                    
                    Image {
                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredWidth: 24
                        Layout.preferredHeight: 24
                        source: parent.parent.parent.icon
                        sourceSize: Qt.size(width, height)
                    }
                    
                    Label {
                        Layout.alignment: Qt.AlignHCenter
                        text: parent.parent.parent.label
                        font.family: "Roboto"
                        font.pixelSize: 12
                        color: parent.parent.parent.checked ? "#2196f3" : "#424242"
                    }
                }
            }
            
            Button {
                Layout.fillWidth: true
                
                property string icon: "qrc:/icons/airplane.svg"
                property string label: "Airplane Mode"
                property bool checked: false
                
                checkable: true
                height: 80
                
                background: Rectangle {
                    color: parent.checked ? "#e3f2fd" : "#f5f5f5"
                    radius: 12
                    border.color: parent.checked ? "#2196f3" : "transparent"
                    border.width: 2
                    
                    Behavior on color {
                        ColorAnimation { duration: 150 }
                    }
                }
                
                contentItem: ColumnLayout {
                    spacing: 8
                    
                    Image {
                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredWidth: 24
                        Layout.preferredHeight: 24
                        source: parent.parent.parent.icon
                        sourceSize: Qt.size(width, height)
                    }
                    
                    Label {
                        Layout.alignment: Qt.AlignHCenter
                        text: parent.parent.parent.label
                        font.family: "Roboto"
                        font.pixelSize: 12
                        color: parent.parent.parent.checked ? "#2196f3" : "#424242"
                    }
                }
            }
            
            Button {
                Layout.fillWidth: true
                
                property string icon: "qrc:/icons/do-not-disturb.svg"
                property string label: "Do Not Disturb"
                property bool checked: false
                
                checkable: true
                height: 80
                
                background: Rectangle {
                    color: parent.checked ? "#e3f2fd" : "#f5f5f5"
                    radius: 12
                    border.color: parent.checked ? "#2196f3" : "transparent"
                    border.width: 2
                    
                    Behavior on color {
                        ColorAnimation { duration: 150 }
                    }
                }
                
                contentItem: ColumnLayout {
                    spacing: 8
                    
                    Image {
                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredWidth: 24
                        Layout.preferredHeight: 24
                        source: parent.parent.parent.icon
                        sourceSize: Qt.size(width, height)
                    }
                    
                    Label {
                        Layout.alignment: Qt.AlignHCenter
                        text: parent.parent.parent.label
                        font.family: "Roboto"
                        font.pixelSize: 12
                        color: parent.parent.parent.checked ? "#2196f3" : "#424242"
                    }
                }
            }
        }
        
        Rectangle {
            Layout.fillWidth: true
            height: 1
            color: "#e0e0e0"
        }
        
        // Volume slider
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 8
            
            RowLayout {
                Layout.fillWidth: true
                
                Image {
                    Layout.preferredWidth: 20
                    Layout.preferredHeight: 20
                    source: "qrc:/icons/volume-high.svg"
                }
                
                Label {
                    text: "Volume"
                    font.family: "Roboto"
                    font.pixelSize: 14
                    color: "#424242"
                    Layout.fillWidth: true
                }
                
                Label {
                    text: volumeSlider.value + "%"
                    font.family: "Roboto"
                    font.pixelSize: 14
                    color: "#757575"
                }
            }
            
            Slider {
                id: volumeSlider
                Layout.fillWidth: true
                from: 0
                to: 100
                value: 75
            }
        }
        
        // Brightness slider
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 8
            
            RowLayout {
                Layout.fillWidth: true
                
                Image {
                    Layout.preferredWidth: 20
                    Layout.preferredHeight: 20
                    source: "qrc:/icons/brightness.svg"
                }
                
                Label {
                    text: "Brightness"
                    font.family: "Roboto"
                    font.pixelSize: 14
                    color: "#424242"
                    Layout.fillWidth: true
                }
                
                Label {
                    text: brightnessSlider.value + "%"
                    font.family: "Roboto"
                    font.pixelSize: 14
                    color: "#757575"
                }
            }
            
            Slider {
                id: brightnessSlider
                Layout.fillWidth: true
                from: 0
                to: 100
                value: 80
            }
        }
        
        Rectangle {
            Layout.fillWidth: true
            height: 1
            color: "#e0e0e0"
        }
        
        // Power options
        RowLayout {
            Layout.fillWidth: true
            spacing: 12
            
            Button {
                Layout.fillWidth: true
                text: "Lock"
                icon.source: "qrc:/icons/lock.svg"
                
                background: Rectangle {
                    color: parent.pressed ? "#e0e0e0" : "#f5f5f5"
                    radius: 8
                }
            }
            
            Button {
                Layout.fillWidth: true
                text: "Logout"
                icon.source: "qrc:/icons/logout.svg"
                
                background: Rectangle {
                    color: parent.pressed ? "#e0e0e0" : "#f5f5f5"
                    radius: 8
                }
            }
            
            Button {
                Layout.fillWidth: true
                text: "Power"
                icon.source: "qrc:/icons/power.svg"
                
                background: Rectangle {
                    color: parent.pressed ? "#e0e0e0" : "#f5f5f5"
                    radius: 8
                }
            }
        }
        
        Item { Layout.fillHeight: true }
    }
    
    // QuickToggle component definition
    Component {
        id: quickToggleComponent
        
        Button {
            id: toggle
            
            property alias icon: iconImage.source
            property alias label: labelText.text
            property bool checked: false
            
            checkable: true
            height: 80
            
            background: Rectangle {
                color: toggle.checked ? "#e3f2fd" : "#f5f5f5"
                radius: 12
                border.color: toggle.checked ? "#2196f3" : "transparent"
                border.width: 2
                
                Behavior on color {
                    ColorAnimation { duration: 150 }
                }
            }
            
            contentItem: ColumnLayout {
                spacing: 8
                
                Image {
                    id: iconImage
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: 24
                    Layout.preferredHeight: 24
                    sourceSize: Qt.size(width, height)
                }
                
                Label {
                    id: labelText
                    Layout.alignment: Qt.AlignHCenter
                    font.family: "Roboto"
                    font.pixelSize: 12
                    color: toggle.checked ? "#2196f3" : "#424242"
                }
            }
        }
    }
}
