import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Row {
    id: root
    spacing: 8
    
    signal networkClicked()
    signal volumeClicked()
    signal batteryClicked()
    
    // Network indicator
    CircularButton {
        width: 32
        height: 32
        iconSource: networkConnected ? "qrc:/icons/network-wifi.svg" : "qrc:/icons/network-wifi-off.svg"
        tooltip: networkConnected ? "Connected to " + networkName : "Not connected"
        onClicked: root.networkClicked()
        
        property bool networkConnected: true
        property string networkName: "Wi-Fi Network"
    }
    
    // Volume indicator
    CircularButton {
        width: 32
        height: 32
        iconSource: {
            if (volumeMuted) return "qrc:/icons/volume-mute.svg"
            if (volumeLevel > 66) return "qrc:/icons/volume-high.svg"
            if (volumeLevel > 33) return "qrc:/icons/volume-medium.svg"
            return "qrc:/icons/volume-low.svg"
        }
        tooltip: volumeMuted ? "Muted" : "Volume: " + volumeLevel + "%"
        onClicked: root.volumeClicked()
        
        property int volumeLevel: 75
        property bool volumeMuted: false
    }
    
    // Battery indicator
    CircularButton {
        width: 32
        height: 32
        iconSource: {
            if (batteryCharging) return "qrc:/icons/battery-charging.svg"
            if (batteryLevel > 80) return "qrc:/icons/battery-full.svg"
            if (batteryLevel > 50) return "qrc:/icons/battery-80.svg"
            if (batteryLevel > 20) return "qrc:/icons/battery-50.svg"
            return "qrc:/icons/battery-alert.svg"
        }
        tooltip: batteryCharging ? "Charging: " + batteryLevel + "%" : "Battery: " + batteryLevel + "%"
        onClicked: root.batteryClicked()
        
        property int batteryLevel: 85
        property bool batteryCharging: false
        
        // Battery level indicator
        Rectangle {
            visible: batteryLevel < 20 && !batteryCharging
            anchors.centerIn: parent
            width: 8
            height: 8
            radius: 4
            color: "#f44336"
        }
    }
}
