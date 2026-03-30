import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: root
    visible: true
    width: 1200
    height: 800
    title: "Music"
    
    color: "#121212"
    
    RowLayout {
        anchors.fill: parent
        spacing: 0
        
        // Sidebar
        Rectangle {
            Layout.preferredWidth: 250
            Layout.fillHeight: true
            color: "#1e1e1e"
            
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 16
                spacing: 16
                
                Label {
                    text: "Music"
                    font.family: "Roboto"
                    font.pixelSize: 24
                    font.weight: Font.Bold
                    color: "#ffffff"
                }
                
                ListView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    
                    model: ListModel {
                        ListElement { name: "Library"; icon: "qrc:/icons/library.svg" }
                        ListElement { name: "Playlists"; icon: "qrc:/icons/playlist.svg" }
                        ListElement { name: "Artists"; icon: "qrc:/icons/artist.svg" }
                        ListElement { name: "Albums"; icon: "qrc:/icons/album.svg" }
                        ListElement { name: "Songs"; icon: "qrc:/icons/music-note.svg" }
                    }
                    
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
                                color: "#ffffff"
                            }
                        }
                        
                        background: Rectangle {
                            color: parent.highlighted ? "#2196f3" : "transparent"
                            radius: 8
                        }
                    }
                }
            }
        }
        
        // Main content
        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 0
            
            // Header
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 200
                
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#2196f3" }
                    GradientStop { position: 1.0; color: "#1976d2" }
                }
                
                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 32
                    spacing: 24
                    
                    Rectangle {
                        Layout.preferredWidth: 150
                        Layout.preferredHeight: 150
                        radius: 8
                        color: "#424242"
                        
                        Image {
                            anchors.centerIn: parent
                            width: 64
                            height: 64
                            source: "qrc:/icons/music.svg"
                        }
                    }
                    
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 8
                        
                        Label {
                            text: "Your Library"
                            font.family: "Roboto"
                            font.pixelSize: 32
                            font.weight: Font.Bold
                            color: "#ffffff"
                        }
                        
                        Label {
                            text: "0 songs"
                            font.family: "Roboto"
                            font.pixelSize: 14
                            color: "#e0e0e0"
                        }
                    }
                }
            }
            
            // Song list
            ListView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                
                model: ListModel {
                    ListElement { title: "No songs yet"; artist: "Add music to your library"; duration: "" }
                }
                
                delegate: ItemDelegate {
                    width: ListView.view.width
                    height: 64
                    
                    contentItem: RowLayout {
                        anchors.fill: parent
                        anchors.margins: 16
                        spacing: 16
                        
                        Label {
                            text: (index + 1).toString()
                            font.family: "Roboto"
                            font.pixelSize: 14
                            color: "#9e9e9e"
                            Layout.preferredWidth: 30
                        }
                        
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 4
                            
                            Label {
                                text: model.title
                                font.family: "Roboto"
                                font.pixelSize: 14
                                color: "#ffffff"
                            }
                            
                            Label {
                                text: model.artist
                                font.family: "Roboto"
                                font.pixelSize: 12
                                color: "#9e9e9e"
                            }
                        }
                        
                        Label {
                            text: model.duration
                            font.family: "Roboto"
                            font.pixelSize: 14
                            color: "#9e9e9e"
                        }
                    }
                    
                    background: Rectangle {
                        color: parent.hovered ? "#2a2a2a" : "transparent"
                    }
                }
            }
        }
    }
    
    // Player bar
    Rectangle {
        anchors.bottom: parent.bottom
        width: parent.width
        height: 90
        color: "#1e1e1e"
        
        RowLayout {
            anchors.fill: parent
            anchors.margins: 16
            spacing: 16
            
            // Now playing
            RowLayout {
                Layout.preferredWidth: 250
                spacing: 12
                
                Rectangle {
                    width: 56
                    height: 56
                    radius: 4
                    color: "#424242"
                }
                
                ColumnLayout {
                    spacing: 4
                    
                    Label {
                        text: "No song playing"
                        font.family: "Roboto"
                        font.pixelSize: 14
                        color: "#ffffff"
                    }
                    
                    Label {
                        text: ""
                        font.family: "Roboto"
                        font.pixelSize: 12
                        color: "#9e9e9e"
                    }
                }
            }
            
            // Controls
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 8
                
                RowLayout {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 16
                    
                    Button {
                        icon.source: "qrc:/icons/shuffle.svg"
                        flat: true
                    }
                    
                    Button {
                        icon.source: "qrc:/icons/skip-previous.svg"
                        flat: true
                    }
                    
                    Button {
                        icon.source: "qrc:/icons/play-circle.svg"
                        flat: true
                        
                        background: Rectangle {
                            radius: 20
                            color: "#2196f3"
                        }
                    }
                    
                    Button {
                        icon.source: "qrc:/icons/skip-next.svg"
                        flat: true
                    }
                    
                    Button {
                        icon.source: "qrc:/icons/repeat.svg"
                        flat: true
                    }
                }
                
                RowLayout {
                    Layout.fillWidth: true
                    spacing: 8
                    
                    Label {
                        text: "0:00"
                        font.family: "Roboto"
                        font.pixelSize: 11
                        color: "#9e9e9e"
                    }
                    
                    Slider {
                        Layout.fillWidth: true
                        from: 0
                        to: 100
                        value: 0
                    }
                    
                    Label {
                        text: "0:00"
                        font.family: "Roboto"
                        font.pixelSize: 11
                        color: "#9e9e9e"
                    }
                }
            }
            
            // Volume
            RowLayout {
                Layout.preferredWidth: 150
                spacing: 8
                
                Image {
                    width: 20
                    height: 20
                    source: "qrc:/icons/volume-high.svg"
                }
                
                Slider {
                    Layout.fillWidth: true
                    from: 0
                    to: 100
                    value: 75
                }
            }
        }
        
        Rectangle {
            anchors.top: parent.top
            width: parent.width
            height: 1
            color: "#2a2a2a"
        }
    }
}
