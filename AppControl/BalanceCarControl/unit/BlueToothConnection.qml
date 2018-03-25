import QtQuick 2.0
import QtBluetooth 5.2

Item {
    id: root
    property alias btModel: btModel
    property alias btSocket: btSocket
    visible: false
    BluetoothDiscoveryModel{
        id: btModel
        running: true
        discoveryMode: BluetoothDiscoveryModel.FullServiceDiscovery
        onErrorChanged: {
            switch (btModel.error) {
            case BluetoothDiscoveryModel.PoweredOffError:
                console.log("Error: Bluetooth device not turned on"); break;
            case BluetoothDiscoveryModel.InputOutputError:
                console.log("Error: Bluetooth I/O Error"); break;
            case BluetoothDiscoveryModel.InvalidBluetoothAdapterError:
                console.log("Error: Invalid Bluetooth Adapter Error"); break;
            case BluetoothDiscoveryModel.NoError:
                break;
            default:
                console.log("Error: Unknown Error"); break;
            }
        }
    }
    BluetoothSocket{
        id: btSocket
        connected: true
        onSocketStateChanged: {
            switch (socketState) {
                case BluetoothSocket.Unconnected:
                    break;
                case BluetoothSocket.NoServiceSet:
                    break;
                case BluetoothSocket.Connected:
                    console.log("Connected to server ");
                    break;
                case BluetoothSocket.Connecting:
                case BluetoothSocket.ServiceLookup:
                case BluetoothSocket.Closing:
                case BluetoothSocket.Listening:
                case BluetoothSocket.Bound:
                    break;
            }
        }
//        onStringDataChanged: {
//            var data = btSocket.stringData
//            txt_receive.text = data
//            var cover = txt_receive + 1
//            console.log(cover)
//        }
    }
}
