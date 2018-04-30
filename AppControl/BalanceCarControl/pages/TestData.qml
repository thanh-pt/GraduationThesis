import QtQuick 2.0
import QtCharts 2.0
import "../unit"

Item {
    id: root
    objectName: "T E S T"
    property string previousScreen: "qrc:/pages/Menu.qml"
    property string rawData: btSocket.stringData

    //fuction
    // on signal
    onRawDataChanged: {
        if (rawData != ""){
            console.log(rawData);
            dataRowText.text = rawData
        }
    }
    //Component
    Text {
        id: dataRowText
        anchors.centerIn: parent
    }
}
