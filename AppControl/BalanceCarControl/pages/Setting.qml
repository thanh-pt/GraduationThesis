import QtQuick 2.0
import "../unit"

Item {
    id: root
    objectName: "S E T T I N G"
    property string previousScreen: "qrc:/pages/Menu.qml"
    ListModel{
        id: list_model
        ListElement{name: "Bluetooth"; source: "qrc:/pages/SettingBluetooth.qml"; icon: "qrc:/png/bluetooth.png"}
        ListElement{name: "PID Controler"; source: "qrc:/pages/SettingPID.qml"; icon: "qrc:/png/controls.png"}
        ListElement{name: "Filter Method"; source: "qrc:/pages/SettingFilter.qml"; icon: "qrc:/png/filter.png"}
        ListElement{name: "MPU6050 Sensor"; source: "qrc:/pages/SettingSensor.qml"; icon: "qrc:/png/mpu6050.png"}
    }
    ListView{
        id: list_view
        anchors.fill: parent
        model: list_model
        delegate: ListViewDelegate{
            width: root.width; height: root.height/10
            textName: model.name
            sourceImg: model.icon
            mouseAreaAlias.onClicked: UIBridge.ChangeScreen(model.source)
        }
    }
}
