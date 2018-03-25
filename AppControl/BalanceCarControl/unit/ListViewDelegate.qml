import QtQuick 2.0

Item {
    id: root
    property alias textName: name.text
    property alias sourceImg: icon.sourceImg
    property alias mouseAreaAlias: mouseArea
    Text{
        id: name
        anchors.verticalCenter: root.verticalCenter
        anchors.left: icon.right
        anchors.leftMargin: 5
        color: img.colorImg
    }
    GeneralImage{
        id: img
        width: root.height * 0.6; height: width
        anchors.right: root.right
        anchors.rightMargin: width/4
        anchors.verticalCenter: root.verticalCenter
        sourceImg: "qrc:/png/arrow.png"
    }

    GeneralImage{
        id: icon
        width: root.height; height: width
        anchors.left: root.left
        anchors.leftMargin: 5
        colorImg: img.colorImg
    }

    Rectangle{
        width: root.width; height: 3
        radius: 2
        anchors.bottom: root.bottom
        color: "#227093"
        opacity: 0.4
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
