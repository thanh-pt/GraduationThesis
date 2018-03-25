import QtQuick 2.0
import QtBluetooth 5.2
import "../unit"

Item {
    id: root
    objectName: "S E T T I N G"
    property string previousScreen: "qrc:/pages/Setting.qml"
    Item{
        id: top_bar
        width: root.width; height: root.height/10
        Item{
            id: btn_back
            width: parent.width / 2; height: parent.height
            GeneralImage{
                id: img
                width: parent.height * 0.6; height: width
                anchors.left: parent.left
                anchors.leftMargin: width/4
                anchors.verticalCenter: parent.verticalCenter
                sourceImg: "qrc:/png/arrow.png"
                rotation: 180
            }
            Text{
                id: name
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: img.right
                anchors.leftMargin: 10
                color: img.colorImg
                text: "Back"
            }
            MouseArea{
                anchors.fill: parent
                onPressed: img.colorImg = "#ffb142"
                onReleased: img.colorImg = "black"
                onCanceled: img.colorImg = "black"
                onClicked: UIBridge.ChangeScreen(previousScreen)
            }
        }
        Item {
            id: btn_scan
            width: parent.width/2; height: parent.height
            anchors.right: parent.right
            Text {
                id: scan_status
                text: btModel.running ? "Scanning..." : "Scan Now"
                anchors.right: icon.left
                anchors.rightMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                color: icon.colorImg
            }
            GeneralImage{
                id: icon
                width: parent.height; height: width
                anchors.right: parent.right
                anchors.rightMargin: 5
                sourceImg: "qrc:/png/bluetooth.png"
                SequentialAnimation on colorImg {
                    id: busyThrobber
                    ColorAnimation { easing.type: Easing.InOutSine; from: "#ffb142"; to: "black"; duration: 1000; }
                    ColorAnimation { easing.type: Easing.InOutSine; to: "#ffb142"; from: "black"; duration: 1000 }
                    running: btModel.running
                    loops: Animation.Infinite
                }
            }
            MouseArea{
                anchors.fill: parent
                enabled: !btModel.running
                onPressed: icon.colorImg = "#ffb142"
                onReleased: icon.colorImg = "black"
                onCanceled: icon.colorImg = "black"
                onClicked: {
                    btModel.discoveryMode = BluetoothDiscoveryModel.FullServiceDiscovery
                    btModel.running = false
                    btModel.running = true
                }
                onEnabledChanged: {
                    if (entered){
                        icon.colorImg = "black"
                    }
                }
            }
        }
        Rectangle{
            width: parent.width; height: 3
            radius: 2
            anchors.bottom: parent.bottom
            color: "#227093"
            opacity: 0.4
        }
        Rectangle{
            width: 3; height: parent.height * 0.6
            radius: 2
            color: "#227093"
            anchors.centerIn: parent
            opacity: 0.3
        }
    }

    ListView{
        id: view
        width: root.width; height: root.height / 10
        anchors.top : top_bar.bottom
        model: btModel
        delegate: Item{
            width: root.width; height: root.height / 10
            Text {
                id: txt_name
                text: deviceName ? deviceName : name
                anchors.left: parent.left
                anchors.leftMargin: parent.width/10
                anchors.verticalCenter: parent.verticalCenter
                color: (btSocket.service  == service) ? "blue" : "black"
            }
            Rectangle{
                width: parent.width; height: 3
                radius: 2
                anchors.bottom: parent.bottom
                color: "#227093"
                opacity: 0.4
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    btSocket.setService(service)
                }
            }
        }
    }
}
