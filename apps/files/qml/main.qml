import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.folderlistmodel

ApplicationWindow {
    id: root
    visible: true
    width: 1200
    height: 800
    title: "Files"
    
    color: "#f5f5f5"
    
    ColumnLayout {
        anchors.fill: parent
        spacing: 0
        
        // Toolbar
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 56
            color: "#ffffff"
            
            RowLayout {
                anchors.fill: parent
                anchors.margins: 12
                spacing: 8
                
                // Navigation buttons
                ToolButton {
                    icon.source: "qrc:/icons/arrow-back.svg"
                    onClicked: folderModel.folder = folderModel.parentFolder
                    enabled: folderModel.folder != "file:///"
                }
                
                ToolButton {
                    icon.source: "qrc:/icons/arrow-forward.svg"
                }
                
                ToolButton {
                    icon.source: "qrc:/icons/arrow-up.svg"
                    onClicked: folderModel.folder = folderModel.parentFolder
                }
                
                Rectangle {
                    width: 1
                    Layout.fillHeight: true
                    Layout.margins: 4
                    color: "#e0e0e0"
                }
                
                // Path bar
                TextField {
                    id: pathField
                    Layout.fillWidth: true
                    text: folderModel.folder.toString().replace("file://", "")
                    font.family: "Roboto"
                    
                    background: Rectangle {
                        color: "#f5f5f5"
                        radius: 8
                    }
                    
                    onAccepted: {
                        folderModel.folder = "file://" + text
                    }
                }
                
                // View options
                ToolButton {
                    icon.source: "qrc:/icons/view-grid.svg"
                    checkable: true
                    checked: true
                }
                
                ToolButton {
                    icon.source: "qrc:/icons/view-list.svg"
                    checkable: true
                }
                
                Rectangle {
                    width: 1
                    Layout.fillHeight: true
                    Layout.margins: 4
                    color: "#e0e0e0"
                }
                
                // Search
                TextField {
                    Layout.preferredWidth: 200
                    placeholderText: "Search..."
                    font.family: "Roboto"
                    
                    background: Rectangle {
                        color: "#f5f5f5"
                        radius: 8
                    }
                }
            }
            
            Rectangle {
                anchors.bottom: parent.bottom
                width: parent.width
                height: 1
                color: "#e0e0e0"
            }
        }
        
        // Main content
        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 0
            
            // Sidebar
            Rectangle {
                Layout.preferredWidth: 200
                Layout.fillHeight: true
                color: "#ffffff"
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 12
                    spacing: 8
                    
                    Label {
                        text: "Places"
                        font.family: "Roboto"
                        font.pixelSize: 12
                        font.weight: Font.Medium
                        color: "#757575"
                    }
                    
                    ListView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        
                        model: placesModel
                        delegate: ItemDelegate {
                            width: ListView.view.width
                            height: 40
                            
                            contentItem: RowLayout {
                                spacing: 12
                                
                                Image {
                                    Layout.preferredWidth: 20
                                    Layout.preferredHeight: 20
                                    source: model.icon
                                }
                                
                                Label {
                                    text: model.name
                                    font.family: "Roboto"
                                    font.pixelSize: 13
                                    color: "#424242"
                                }
                            }
                            
                            background: Rectangle {
                                color: parent.highlighted ? "#e3f2fd" : "transparent"
                                radius: 6
                            }
                            
                            onClicked: folderModel.folder = model.path
                        }
                    }
                }
                
                Rectangle {
                    anchors.right: parent.right
                    width: 1
                    height: parent.height
                    color: "#e0e0e0"
                }
            }
            
            // File grid
            GridView {
                id: fileGrid
                Layout.fillWidth: true
                Layout.fillHeight: true
                
                cellWidth: 120
                cellHeight: 120
                clip: true
                
                model: FolderListModel {
                    id: folderModel
                    folder: "file://" + StandardPaths.writableLocation(StandardPaths.HomeLocation)
                    showDirs: true
                    showFiles: true
                }
                
                delegate: Item {
                    width: fileGrid.cellWidth
                    height: fileGrid.cellHeight
                    
                    Column {
                        anchors.centerIn: parent
                        spacing: 8
                        
                        Rectangle {
                            width: 64
                            height: 64
                            radius: 12
                            color: "#e3f2fd"
                            anchors.horizontalCenter: parent.horizontalCenter
                            
                            Image {
                                anchors.centerIn: parent
                                width: 40
                                height: 40
                                source: model.fileIsDir ? "qrc:/icons/folder.svg" : "qrc:/icons/file.svg"
                            }
                        }
                        
                        Label {
                            text: model.fileName
                            font.family: "Roboto"
                            font.pixelSize: 12
                            color: "#424242"
                            width: 100
                            horizontalAlignment: Text.AlignHCenter
                            elide: Text.ElideMiddle
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                    
                    MouseArea {
                        anchors.fill: parent
                        onDoubleClicked: {
                            if (model.fileIsDir) {
                                folderModel.folder = model.fileURL
                            }
                        }
                    }
                }
                
                ScrollBar.vertical: ScrollBar {}
            }
        }
        
        // Status bar
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 32
            color: "#ffffff"
            
            RowLayout {
                anchors.fill: parent
                anchors.margins: 8
                
                Label {
                    text: folderModel.count + " items"
                    font.family: "Roboto"
                    font.pixelSize: 12
                    color: "#757575"
                }
                
                Item { Layout.fillWidth: true }
            }
            
            Rectangle {
                anchors.top: parent.top
                width: parent.width
                height: 1
                color: "#e0e0e0"
            }
        }
    }
    
    ListModel {
        id: placesModel
        
        ListElement {
            name: "Home"
            icon: "qrc:/icons/home.svg"
            path: "file:///home"
        }
        ListElement {
            name: "Documents"
            icon: "qrc:/icons/folder-documents.svg"
            path: "file:///home/documents"
        }
        ListElement {
            name: "Downloads"
            icon: "qrc:/icons/folder-download.svg"
            path: "file:///home/downloads"
        }
        ListElement {
            name: "Pictures"
            icon: "qrc:/icons/folder-images.svg"
            path: "file:///home/pictures"
        }
        ListElement {
            name: "Music"
            icon: "qrc:/icons/folder-music.svg"
            path: "file:///home/music"
        }
        ListElement {
            name: "Videos"
            icon: "qrc:/icons/folder-video.svg"
            path: "file:///home/videos"
        }
    }
}
