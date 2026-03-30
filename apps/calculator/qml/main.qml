import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: root
    visible: true
    width: 400
    height: 600
    title: "Calculator"
    
    color: "#1e1e1e"
    
    property string display: "0"
    property real firstNumber: 0
    property string operation: ""
    property bool newNumber: true
    
    ColumnLayout {
        anchors.fill: parent
        spacing: 0
        
        // Display
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 150
            color: "#252526"
            
            Label {
                anchors.fill: parent
                anchors.margins: 20
                text: root.display
                font.family: "Roboto"
                font.pixelSize: 48
                font.weight: Font.Light
                color: "#ffffff"
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideLeft
            }
        }
        
        // Buttons
        GridLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            columns: 4
            rowSpacing: 1
            columnSpacing: 1
            
            // Row 1
            Button {
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: "C"
                onClicked: clear()
                background: Rectangle { color: parent.pressed ? "#424242" : "#616161" }
                contentItem: Text { text: parent.text; font.family: "Roboto"; font.pixelSize: 24; color: "#ffffff"; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
            }
            Button {
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: "±"
                onClicked: negate()
                background: Rectangle { color: parent.pressed ? "#424242" : "#616161" }
                contentItem: Text { text: parent.text; font.family: "Roboto"; font.pixelSize: 24; color: "#ffffff"; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
            }
            Button {
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: "%"
                onClicked: percent()
                background: Rectangle { color: parent.pressed ? "#424242" : "#616161" }
                contentItem: Text { text: parent.text; font.family: "Roboto"; font.pixelSize: 24; color: "#ffffff"; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
            }
            Button {
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: "÷"
                onClicked: setOperation("/")
                background: Rectangle { color: parent.pressed ? "#d67600" : "#ff9800" }
                contentItem: Text { text: parent.text; font.family: "Roboto"; font.pixelSize: 24; color: "#ffffff"; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
            }
            
            // Row 2
            Button {
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: "7"
                onClicked: appendDigit("7")
                background: Rectangle { color: parent.pressed ? "#303030" : "#424242" }
                contentItem: Text {
                    text: parent.text
                    font.family: "Roboto"
                    font.pixelSize: 24
                    color: "#ffffff"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
            Button {
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: "8"
                onClicked: appendDigit("8")
                background: Rectangle { color: parent.pressed ? "#303030" : "#424242" }
                contentItem: Text {
                    text: parent.text
                    font.family: "Roboto"
                    font.pixelSize: 24
                    color: "#ffffff"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
            Button {
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: "9"
                onClicked: appendDigit("9")
                background: Rectangle { color: parent.pressed ? "#303030" : "#424242" }
                contentItem: Text {
                    text: parent.text
                    font.family: "Roboto"
                    font.pixelSize: 24
                    color: "#ffffff"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
            Button {
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: "×"
                onClicked: setOperation("*")
                background: Rectangle { color: parent.pressed ? "#d67600" : "#ff9800" }
                contentItem: Text {
                    text: parent.text
                    font.family: "Roboto"
                    font.pixelSize: 24
                    color: "#ffffff"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
            
            // Row 3
            Button {
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: "4"
                onClicked: appendDigit("4")
                background: Rectangle { color: parent.pressed ? "#303030" : "#424242" }
                contentItem: Text {
                    text: parent.text
                    font.family: "Roboto"
                    font.pixelSize: 24
                    color: "#ffffff"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
            Button {
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: "5"
                onClicked: appendDigit("5")
                background: Rectangle { color: parent.pressed ? "#303030" : "#424242" }
                contentItem: Text {
                    text: parent.text
                    font.family: "Roboto"
                    font.pixelSize: 24
                    color: "#ffffff"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
            Button {
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: "6"
                onClicked: appendDigit("6")
                background: Rectangle { color: parent.pressed ? "#303030" : "#424242" }
                contentItem: Text {
                    text: parent.text
                    font.family: "Roboto"
                    font.pixelSize: 24
                    color: "#ffffff"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
            Button {
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: "−"
                onClicked: setOperation("-")
                background: Rectangle { color: parent.pressed ? "#d67600" : "#ff9800" }
                contentItem: Text {
                    text: parent.text
                    font.family: "Roboto"
                    font.pixelSize: 24
                    color: "#ffffff"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
            
            // Row 4
            Button {
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: "1"
                onClicked: appendDigit("1")
                background: Rectangle { color: parent.pressed ? "#303030" : "#424242" }
                contentItem: Text {
                    text: parent.text
                    font.family: "Roboto"
                    font.pixelSize: 24
                    color: "#ffffff"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
            Button {
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: "2"
                onClicked: appendDigit("2")
                background: Rectangle { color: parent.pressed ? "#303030" : "#424242" }
                contentItem: Text {
                    text: parent.text
                    font.family: "Roboto"
                    font.pixelSize: 24
                    color: "#ffffff"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
            Button {
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: "3"
                onClicked: appendDigit("3")
                background: Rectangle { color: parent.pressed ? "#303030" : "#424242" }
                contentItem: Text {
                    text: parent.text
                    font.family: "Roboto"
                    font.pixelSize: 24
                    color: "#ffffff"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
            Button {
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: "+"
                onClicked: setOperation("+")
                background: Rectangle { color: parent.pressed ? "#d67600" : "#ff9800" }
                contentItem: Text {
                    text: parent.text
                    font.family: "Roboto"
                    font.pixelSize: 24
                    color: "#ffffff"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
            
            // Row 5
            Button {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.columnSpan: 2
                text: "0"
                onClicked: appendDigit("0")
                background: Rectangle { color: parent.pressed ? "#303030" : "#424242" }
                contentItem: Text {
                    text: parent.text
                    font.family: "Roboto"
                    font.pixelSize: 24
                    color: "#ffffff"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
            Button {
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: "."
                onClicked: appendDigit(".")
                background: Rectangle { color: parent.pressed ? "#303030" : "#424242" }
                contentItem: Text {
                    text: parent.text
                    font.family: "Roboto"
                    font.pixelSize: 24
                    color: "#ffffff"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
            Button {
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: "="
                onClicked: calculate()
                background: Rectangle { color: parent.pressed ? "#d67600" : "#ff9800" }
                contentItem: Text {
                    text: parent.text
                    font.family: "Roboto"
                    font.pixelSize: 24
                    color: "#ffffff"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }
    }
    
    function clear() {
        display = "0"
        firstNumber = 0
        operation = ""
        newNumber = true
    }
    
    function appendDigit(digit) {
        if (newNumber) {
            display = digit
            newNumber = false
        } else {
            if (display === "0" && digit !== ".") {
                display = digit
            } else {
                display += digit
            }
        }
    }
    
    function setOperation(op) {
        firstNumber = parseFloat(display)
        operation = op
        newNumber = true
    }
    
    function calculate() {
        if (operation === "") return
        
        let secondNumber = parseFloat(display)
        let result = 0
        
        switch(operation) {
            case "+": result = firstNumber + secondNumber; break
            case "-": result = firstNumber - secondNumber; break
            case "*": result = firstNumber * secondNumber; break
            case "/": result = firstNumber / secondNumber; break
        }
        
        display = result.toString()
        operation = ""
        newNumber = true
    }
    
    function negate() {
        display = (parseFloat(display) * -1).toString()
    }
    
    function percent() {
        display = (parseFloat(display) / 100).toString()
    }
}
