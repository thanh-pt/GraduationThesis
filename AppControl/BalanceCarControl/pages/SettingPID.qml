import QtQuick 2.0
import "../unit"

Item {
    id: root
    objectName: "S E T T I N G"
    property string previousScreen: "qrc:/pages/Setting.qml"
    property string rawData: btSocket.StringData
    property var pid
    property var pid_test : ["12.3", "0.9", "20"]
    /*function*/
    Component.onCompleted: {
        //request_Data
        btSocket.stringData = "2"
    }

    onRawDataChanged: {
        if (rawData != ""){
            pid = rawData.split(" ")
        }
    }

    /*Component*/
    //Top bar
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
            width: parent.width/2; height: parent.height
            anchors.right: parent.right
            Text {
                text: "PID Controler"
                anchors.right: icon.left
                anchors.rightMargin: 5
                anchors.verticalCenter: parent.verticalCenter
            }
            GeneralImage{
                id: icon
                width: parent.height; height: width
                anchors.right: parent.right
                anchors.rightMargin: 5
                sourceImg: "qrc:/png/controls.png"
            }
        }
    }

    //main content
    Column{
        width: root.width; height: root.height - top_bar.height
        anchors.top: top_bar.bottom
        Repeater{
            model: pid_test
            delegate: Item{
                width: root.width; height: top_bar.height
                Row{
                    anchors.fill: parent
                    spacing: 3
                    Text {
                        id: parameter_name
                        text: "Parameter: "
                    }
                    TextInput{
                        id: parameter_value
                        width: root.width/5
                        text: modelData
                    }
                    IconButton{
                        id: btn_up
                        width: parent.height * 0.6; height: width
                        sourceImg: "qrc:/png/arrow.png"
                        rotation: -90
                        mouseAreaAlias.onClicked: {
                        }
                    }
                    IconButton{
                        id: btn_down
                        width: parent.height * 0.6; height: width
                        sourceImg: "qrc:/png/arrow.png"
                        rotation: 90
//                        mouseAreaAlias: pid_test[index] = pid_test[index] - 1;
                    }
                }
            }
        }
    }
}
