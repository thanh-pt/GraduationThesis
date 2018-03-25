import QtQuick 2.0

Item {
    id: root
    objectName: "S E T T I N G"
    property string previousScreen: "qrc:/pages/Setting.qml"
    Text{
        text: "This page setting MPU6050 sensor"
        anchors.centerIn: root
    }
}
