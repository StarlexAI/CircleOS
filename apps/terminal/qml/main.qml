import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: root
    visible: true
    width: 900
    height: 600
    title: "Terminal"
    
    color: "#1e1e1e"
    
    ColumnLayout {
        anchors.fill: parent
        spacing: 0
        
        // Terminal output
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            
            TextEdit {
                id: terminalOutput
                color: "#d4d4d4"
                font.family: "Roboto Mono"
                font.pixelSize: 14
                readOnly: true
                selectByMouse: true
                wrapMode: TextEdit.Wrap
                
                text: "CircleOS Terminal v1.0.0\n" +
                      "Type 'help' for available commands\n\n" +
                      "user@circleos:~$ "
            }
        }
        
        // Input area
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 40
            color: "#252526"
            
            RowLayout {
                anchors.fill: parent
                anchors.margins: 8
                spacing: 8
                
                Label {
                    text: "user@circleos:~$"
                    font.family: "Roboto Mono"
                    font.pixelSize: 14
                    color: "#4ec9b0"
                }
                
                TextField {
                    id: commandInput
                    Layout.fillWidth: true
                    font.family: "Roboto Mono"
                    font.pixelSize: 14
                    color: "#d4d4d4"
                    
                    background: Rectangle {
                        color: "transparent"
                    }
                    
                    Keys.onReturnPressed: {
                        executeCommand(text)
                        text = ""
                    }
                    
                    Component.onCompleted: forceActiveFocus()
                }
            }
        }
    }
    
    function executeCommand(cmd) {
        terminalOutput.text += cmd + "\n"
        
        // Simple command simulation
        switch(cmd.trim()) {
            case "help":
                terminalOutput.text += "Available commands:\n" +
                                      "  help    - Show this help\n" +
                                      "  clear   - Clear terminal\n" +
                                      "  exit    - Close terminal\n" +
                                      "  about   - About CircleOS\n\n"
                break
            case "clear":
                terminalOutput.text = "user@circleos:~$ "
                return
            case "exit":
                Qt.quit()
                return
            case "about":
                terminalOutput.text += "CircleOS 1.0.0\n" +
                                      "Modern Linux distribution with circular UI\n\n"
                break
            case "":
                break
            default:
                terminalOutput.text += "Command not found: " + cmd + "\n\n"
        }
        
        terminalOutput.text += "user@circleos:~$ "
    }
}
