import QtQuick 2.0
import "unit"

Item {
    id: root
    anchors.fill: parent
    focus: true
    Loader{
        id: mainloader
        objectName: "objMainLoader"
        width: root.width; height: root.height - top_bar.height
        anchors.bottom: parent.bottom
        property variant btModel: bluetooth_connection.btModel
        property variant btSocket: bluetooth_connection.btSocket
    }
    Rectangle{
        id: top_bar
        width: root.width; height: root.height * 2 / 25
        color: "#227093"
        IconButton{
            width: height; height: parent.height
            sourceImg: "qrc:/png/menu.png"
            mouseAreaAlias.onClicked: UIBridge.ChangeScreen("qrc:/pages/Menu.qml")
        }
        Text {
            id: top_bar_string
            text: mainloader.item ? mainloader.item.objectName : ""
            anchors.centerIn: parent
            font.pixelSize: 60
            font.bold: true
            color: "white"
        }
    }
    BlueToothConnection{
        id: bluetooth_connection
    }

    Keys.onReleased: {
        if (event.key == Qt.Key_Back){
            UIBridge.ChangeScreen(mainloader.item.previousScreen)
            event.accepted = true
        }
    }
}
