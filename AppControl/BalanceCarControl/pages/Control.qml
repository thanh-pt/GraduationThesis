import QtQuick 2.0
import QtCharts 2.0
import "../unit"

Item {
    id: root
    objectName: "C O N T R O L"
    property string previousScreen: "qrc:/pages/Menu.qml"
    property real maxY: 0.0
    property real minY: 0.0
    property real plotLengh: 5
    property real lx: 0.0
    property real ly: 0.0
    ChartView{
        width: root.width; height: root.height * 3 / 5 * 0.8
        anchors.top: root.top
        anchors.topMargin: 50
        LineSeries{
            id: dataline2
            name: "Test 2"
            axisY: dataline.axisY
            axisX: dataline.axisX
        }

        LineSeries {
            id: dataline
            name: "LineSeries"
            axisY: CategoryAxis{
                min: minY; max: maxY
                CategoryRange {
                    endValue: minY
                }
                CategoryRange {
                    endValue: maxY
                }
            }
            axisX: CategoryAxis{
                id: xRange
                CategoryRange {
                    endValue: 0
                }
                CategoryRange {
                    endValue: 0
                }
            }
        }
    }
    Timer{
        id: adding_data
        interval: 100
        running: true
        repeat: true
        onTriggered: {
            lx += 0.1;
            ly=parseFloat(btSocket.stringData);
            xRange.min = lx - plotLengh
            xRange.max = lx
            if (ly > maxY) maxY = ly
            if (ly < minY) minY = ly
            if (-ly + 0.3 > maxY) maxY = -ly + 0.3
            if (-ly + 0.3 < minY) minY = -ly + 0.3
            dataline2.append(lx,-ly + 0.3)
            dataline.append(lx,ly)
        }
    }
    Item{
        width: root.width; height: root.height * 2 / 5
        anchors.bottom: root.bottom
        anchors.bottomMargin: 30
        CircleControl{
            width: parent.width * 3 / 5
            height: width
            anchors.centerIn: parent
        }
    }
}
