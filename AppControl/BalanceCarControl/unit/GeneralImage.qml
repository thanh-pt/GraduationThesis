import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: root
    property alias colorImg: overlayColor.color
    property alias sourceImg: img.source
    Image{
        id: img
        width: root.height * 0.6; height: width
        anchors.centerIn: root
        visible: false
    }

    ColorOverlay{
        id: overlayColor
        anchors.fill: img
        source: img
        color: "black"
    }
}
