import QtQuick 2.0

Item {
    id: root
    property int radius: height/2
    Rectangle {
        id: circle
        width: 2 * radius
        height: 2 * radius
        radius: root.radius
        color: 'lightgray'
        opacity: 0.3
    }

    Rectangle {
        id: mark
        width: circle.width * 3 / 5 / 2
        height: width
        radius: width/2
        property int x0
        property int y0
        x: (dragObj.dragRadius <= root.radius ? dragObj.x : root.radius + ((dragObj.x - root.radius) * (root.radius / dragObj.dragRadius))) - mark.radius
        y: (dragObj.dragRadius <= root.radius ? dragObj.y : root.radius + ((dragObj.y - root.radius) * (root.radius / dragObj.dragRadius))) - mark.radius
        color: 'gray'

        MouseArea {
            id: markArea
            anchors.fill: parent
            drag.target: dragObj
            onPressed: {
                dragObj.x = mark.x + mark.radius
                dragObj.y = mark.y + mark.radius
            }
            onReleased: {
                dragObj.x = mark.x0
                dragObj.y = mark.y0
            }
        }
        Component.onCompleted: {
            mark.x0 = dragObj.x
            mark.y0 = dragObj.y
        }
    }

    Item {
        id: dragObj
        readonly property real dragRadius: Math.sqrt(Math.pow(x - root.radius, 2) + Math.pow(y - root.radius, 2))
        x: root.radius
        y: root.radius
    }
}
