import QtQuick 2.0

Item {
    id: root
    objectName: "S E T T I N G"
    property string previousScreen: "qrc:/pages/Setting.qml"
    Text{
        text: btSocket.stringData;
        anchors.centerIn: root
    }
    MouseArea{
        anchors.fill: parent
        onClicked: btSocket.stringData = "0 12.3 22.12 2"
    }
}
