import QtQuick 2.0
import "../unit"

Item {
    id: root
    objectName: "M E N U"
    property string previousScreen: "qrc:/pages/Menu.qml"
    ListModel{
        id: list_model
        ListElement{name: "Control"; source: "qrc:/pages/Control.qml"; icon: "qrc:/png/control_app.png"}
        ListElement{name: "Setting"; source: "qrc:/pages/Setting.qml"; icon: "qrc:/png/settings.png"}
        ListElement{name: "Information"; source: "qrc:/pages/Information.qml"; icon: "qrc:/png/info.png"}
        ListElement{name: "Test"; source: "qrc:/pages/TestData.qml"; icon: "qrc:/png/logo.png"}
    }
    GridView{
        id: grid_view
        anchors.fill: parent
        cellWidth: root.width/3
        cellHeight: root.width/3
        model: list_model
        delegate: GridViewDelegate{
            width: root.width/3; height: root.height/5
            sourceImg: model.icon
            textName: model.name
            mouseAreaAlias.onClicked: UIBridge.changeScreen(model.source)
        }
    }
}
