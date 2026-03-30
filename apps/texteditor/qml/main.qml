import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

ApplicationWindow {
    id: root
    visible: true
    width: 1000
    height: 700
    title: currentFile ? "Text Editor - " + currentFile : "Text Editor - Untitled"
    
    property string currentFile: ""
    property bool modified: false
    
    menuBar: MenuBar {
        Menu {
            title: "File"
            MenuItem { text: "New"; onTriggered: newFile() }
            MenuItem { text: "Open..."; onTriggered: fileDialog.open() }
            MenuItem { text: "Save"; onTriggered: saveFile() }
            MenuItem { text: "Save As..."; onTriggered: saveAsDialog.open() }
            MenuSeparator {}
            MenuItem { text: "Quit"; onTriggered: Qt.quit() }
        }
        Menu {
            title: "Edit"
            MenuItem { text: "Undo"; onTriggered: textArea.undo() }
            MenuItem { text: "Redo"; onTriggered: textArea.redo() }
            MenuSeparator {}
            MenuItem { text: "Cut"; onTriggered: textArea.cut() }
            MenuItem { text: "Copy"; onTriggered: textArea.copy() }
            MenuItem { text: "Paste"; onTriggered: textArea.paste() }
            MenuSeparator {}
            MenuItem { text: "Select All"; onTriggered: textArea.selectAll() }
        }
        Menu {
            title: "View"
            MenuItem { text: "Zoom In"; onTriggered: textArea.font.pixelSize++ }
            MenuItem { text: "Zoom Out"; onTriggered: textArea.font.pixelSize-- }
            MenuItem { text: "Reset Zoom"; onTriggered: textArea.font.pixelSize = 14 }
        }
    }
    
    ColumnLayout {
        anchors.fill: parent
        spacing: 0
        
        // Toolbar
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 48
            color: "#f5f5f5"
            
            RowLayout {
                anchors.fill: parent
                anchors.margins: 8
                spacing: 8
                
                ToolButton {
                    icon.source: "qrc:/icons/file-new.svg"
                    onClicked: newFile()
                    ToolTip.text: "New"
                    ToolTip.visible: hovered
                }
                
                ToolButton {
                    icon.source: "qrc:/icons/folder-open.svg"
                    onClicked: fileDialog.open()
                    ToolTip.text: "Open"
                    ToolTip.visible: hovered
                }
                
                ToolButton {
                    icon.source: "qrc:/icons/save.svg"
                    onClicked: saveFile()
                    ToolTip.text: "Save"
                    ToolTip.visible: hovered
                }
                
                Rectangle {
                    width: 1
                    Layout.fillHeight: true
                    Layout.margins: 4
                    color: "#e0e0e0"
                }
                
                ToolButton {
                    icon.source: "qrc:/icons/undo.svg"
                    onClicked: textArea.undo()
                    enabled: textArea.canUndo
                    ToolTip.text: "Undo"
                    ToolTip.visible: hovered
                }
                
                ToolButton {
                    icon.source: "qrc:/icons/redo.svg"
                    onClicked: textArea.redo()
                    enabled: textArea.canRedo
                    ToolTip.text: "Redo"
                    ToolTip.visible: hovered
                }
                
                Item { Layout.fillWidth: true }
                
                Label {
                    text: "Line " + (textArea.cursorPosition > 0 ? textArea.lineCount : 1) + 
                          ", Column " + textArea.cursorPosition
                    font.family: "Roboto"
                    font.pixelSize: 12
                    color: "#757575"
                }
            }
            
            Rectangle {
                anchors.bottom: parent.bottom
                width: parent.width
                height: 1
                color: "#e0e0e0"
            }
        }
        
        // Text editor
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            
            TextArea {
                id: textArea
                font.family: "Roboto Mono"
                font.pixelSize: 14
                selectByMouse: true
                wrapMode: TextEdit.Wrap
                
                onTextChanged: root.modified = true
            }
        }
        
        // Status bar
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 28
            color: "#f5f5f5"
            
            RowLayout {
                anchors.fill: parent
                anchors.margins: 4
                
                Label {
                    text: root.modified ? "Modified" : "Saved"
                    font.family: "Roboto"
                    font.pixelSize: 11
                    color: root.modified ? "#ff9800" : "#4caf50"
                }
                
                Item { Layout.fillWidth: true }
                
                Label {
                    text: textArea.length + " characters"
                    font.family: "Roboto"
                    font.pixelSize: 11
                    color: "#757575"
                }
            }
            
            Rectangle {
                anchors.top: parent.top
                width: parent.width
                height: 1
                color: "#e0e0e0"
            }
        }
    }
    
    FileDialog {
        id: fileDialog
        title: "Open File"
        onAccepted: {
            // Load file
            currentFile = selectedFile.toString()
            // TODO: Implement file loading
        }
    }
    
    FileDialog {
        id: saveAsDialog
        title: "Save File As"
        fileMode: FileDialog.SaveFile
        onAccepted: {
            currentFile = selectedFile.toString()
            saveFile()
        }
    }
    
    function newFile() {
        textArea.text = ""
        currentFile = ""
        modified = false
    }
    
    function saveFile() {
        if (currentFile === "") {
            saveAsDialog.open()
        } else {
            // TODO: Implement file saving
            modified = false
        }
    }
}
