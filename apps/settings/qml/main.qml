import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: root
    visible: true
    width: 1000
    height: 700
    title: "Settings"
    
    color: "#f5f5f5"
    
    RowLayout {
        anchors.fill: parent
        spacing: 0
        
        // Sidebar
        Rectangle {
            Layout.preferredWidth: 250
            Layout.fillHeight: true
            color: "#ffffff"
            
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 16
                spacing: 8
                
                Label {
                    text: "Settings"
                    font.family: "Roboto"
                    font.pixelSize: 24
                    font.weight: Font.Medium
                    color: "#212121"
                }
                
                Rectangle {
                    Layout.fillWidth: true
                    height: 1
                    color: "#e0e0e0"
                }
                
                ListView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    
                    model: settingsCategories
                    delegate: ItemDelegate {
                        width: ListView.view.width
                        height: 48
                        
                        contentItem: RowLayout {
                            spacing: 12
                            
                            Image {
                                Layout.preferredWidth: 24
                                Layout.preferredHeight: 24
                                source: model.icon
                            }
                            
                            Label {
                                text: model.name
                                font.family: "Roboto"
                                font.pixelSize: 14
                                color: "#424242"
                                Layout.fillWidth: true
                            }
                        }
                        
                        background: Rectangle {
                            color: parent.highlighted ? "#e3f2fd" : "transparent"
                            radius: 8
                        }
                        
                        onClicked: {
                            settingsCategories.currentIndex = index
                            stackView.replace(model.component)
                        }
                    }
                    
                    highlight: Rectangle {
                        color: "#e3f2fd"
                        radius: 8
                    }
                }
            }
        }
        
        // Content area
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#f5f5f5"
            
            StackView {
                id: stackView
                anchors.fill: parent
                anchors.margins: 24
                
                initialItem: displaySettings
            }
        }
    }
    
    ListModel {
        id: settingsCategories
        
        ListElement {
            name: "Display"
            icon: "qrc:/icons/display.svg"
            component: "DisplaySettings.qml"
        }
        ListElement {
            name: "Network"
            icon: "qrc:/icons/network.svg"
            component: "NetworkSettings.qml"
        }
        ListElement {
            name: "Sound"
            icon: "qrc:/icons/volume.svg"
            component: "SoundSettings.qml"
        }
        ListElement {
            name: "Power"
            icon: "qrc:/icons/battery.svg"
            component: "PowerSettings.qml"
        }
        ListElement {
            name: "Appearance"
            icon: "qrc:/icons/palette.svg"
            component: "AppearanceSettings.qml"
        }
        ListElement {
            name: "Users"
            icon: "qrc:/icons/account.svg"
            component: "UserSettings.qml"
        }
        ListElement {
            name: "About"
            icon: "qrc:/icons/info.svg"
            component: "AboutSettings.qml"
        }
    }
    
    Component {
        id: displaySettings
        
        ScrollView {
            ColumnLayout {
                width: parent.width
                spacing: 24
                
                Label {
                    text: "Display"
                    font.family: "Roboto"
                    font.pixelSize: 32
                    font.weight: Font.Medium
                    color: "#212121"
                }
                
                GroupBox {
                    Layout.fillWidth: true
                    title: "Resolution"
                    
                    ColumnLayout {
                        anchors.fill: parent
                        spacing: 12
                        
                        ComboBox {
                            Layout.fillWidth: true
                            model: ["1920x1080", "2560x1440", "3840x2160"]
                            currentIndex: 0
                        }
                    }
                }
                
                GroupBox {
                    Layout.fillWidth: true
                    title: "Scaling"
                    
                    ColumnLayout {
                        anchors.fill: parent
                        spacing: 12
                        
                        Slider {
                            Layout.fillWidth: true
                            from: 100
                            to: 200
                            value: 100
                            stepSize: 25
                        }
                        
                        Label {
                            text: "100%"
                            font.family: "Roboto"
                        }
                    }
                }
                
                Item { Layout.fillHeight: true }
            }
        }
    }
}
