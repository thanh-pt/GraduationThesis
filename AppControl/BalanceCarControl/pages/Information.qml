import QtQuick 2.0
import "../unit"

Item {
    id: root
    objectName: "I N F O"
    property string previousScreen: "qrc:/pages/Menu.qml"
    Text {
        id: name
        text: qsTr("Information page!")
        anchors.centerIn: parent
    }
}
