import QtQuick 2.0

Item {
    id: root
    property alias sourceImg: img.sourceImg
    property alias textName: name.text
    property alias mouseAreaAlias: mouseArea
    GeneralImage{
        id: img
        width: root.width; height: width
        anchors.horizontalCenter: root.horizontalCenter
        anchors.verticalCenter: name.top
        anchors.verticalCenterOffset: -name.y/2
    }

    Text {
        id: name
        anchors.horizontalCenter: root.horizontalCenter
        anchors.bottom: root.bottom
        color: img.colorImg
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
