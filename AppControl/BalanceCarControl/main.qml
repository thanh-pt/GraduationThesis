import QtQuick 2.0
import "unit"

Item {
    id: root
    anchors.fill: parent
    property string infomation
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
        id: infoView
        width: root.width; height: root.height/5
        anchors.bottom: parent.bottom
        radius: height / 6
        color: "#84817a"
        opacity: 0.8
        scale: 0.8
        visible: false
        Text {
            id: info_text
            anchors.centerIn: parent
            color: "white"
            text: infomation
            onTextChanged: {
                if (info_text.text != ""){
                    infoView.visible = true
                    info_timer_show.restart()
                }
            }
        }
        Timer{
            id: info_timer_show
            interval: 3000
            onTriggered: {
                infoView.visible = false
                infomation = ""
            }
        }
    }
    Rectangle{
        id: top_bar
        width: root.width; height: root.height * 2 / 25
        color: "#227093"
        IconButton{
            width: height; height: parent.height
            sourceImg: "qrc:/png/menu.png"
            mouseAreaAlias.onClicked: UIBridge.changeScreen("qrc:/pages/Menu.qml")
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
            UIBridge.changeScreen(mainloader.item.previousScreen)
            event.accepted = true
        }
    }
}
