import QtQuick 2.0
import QtCharts 2.0
import "../unit"

Item {
    id: root
    objectName: "C O N T R O L"
    property string previousScreen: "qrc:/pages/Menu.qml"

    property string dirControl: "0"
    property string rawData: btSocket.stringData

    property real maxY: 0.0
    property real minY: 0.0
    property real plotLengh: 5

    property real x_time: 0.0
    property real y_angle: 0.0
    property real y_velocity: 0.0
    property real y_acceleration: 0.0

    ChartView{
        id: chart_view_area
        width: root.width; height: root.height * 3 / 5 * 0.8
        anchors.top: root.top
        anchors.topMargin: 50
        function updateNewRange(){
            xRange.min = x_time - plotLengh
            xRange.max = x_time
            // update max y
            maxY = (maxY < y_angle) ? y_angle : maxY
            maxY = (maxY < y_velocity) ? y_velocity : maxY
            maxY = (maxY < y_acceleration) ? y_acceleration : maxY
            // update min y
            minY = (minY > y_angle) ? y_angle : minY
            minY = (minY > y_velocity) ? y_velocity : minY
            minY = (minY > y_acceleration) ? y_acceleration : minY
        }
        LineSeries{
            id: line_acceleration
            name: "Acceleration"
            axisY: line_angle.axisY
            axisX: line_angle.axisX
        }
        LineSeries{
            id: line_velocity
            name: "Velocity"
            axisY: line_angle.axisY
            axisX: line_angle.axisX
        }
        LineSeries {
            id: line_angle
            name: "Angle"
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

    onRawDataChanged: {
        if (rawData != ""){
            //console.log(rawData);
            x_time += 0.1;
            var Data = rawData.split(" ");
            y_angle = parseFloat(Data[0]);
            y_velocity = parseFloat(Data[1]);
            y_acceleration = parseFloat(Data[2]);
            //New range
            chart_view_area.updateNewRange()
            //Append new data
            line_angle.append(x_time, y_angle)
            line_velocity.append(x_time, y_velocity)
            line_acceleration.append(x_time, y_acceleration)
            request_data.restart()
        }
    }

    Timer{
        id: request_data
        interval: 100
        running: true
        onTriggered: {
            btSocket.stringData = dirControl
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
            MouseArea{
                anchors.fill: parent
                onPressed: dirControl = "1"
                onReleased: dirControl = "0"
                onCanceled: dirControl = "0"
            }
        }
    }
}
