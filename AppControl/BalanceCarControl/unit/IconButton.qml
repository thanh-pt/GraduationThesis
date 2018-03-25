import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    property alias sourceImg: img.sourceImg
    property alias mouseAreaAlias: mouseArea
    GeneralImage {
        id: img
        anchors.fill: parent
    }

    MouseArea{
        id: mouseArea
        anchors.fill: parent
        onPressed: {
            img.colorImg = "#ffb142"
        }
        onReleased: {
            img.colorImg = "black"
        }
        onCanceled: {
            img.colorImg = "black"
        }
    }
}
