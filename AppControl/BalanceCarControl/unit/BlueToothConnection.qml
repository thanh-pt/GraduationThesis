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
                UIBridge.Info("Error: Bluetooth device not turned on");
                break;
            case BluetoothDiscoveryModel.InputOutputError:
                UIBridge.Info("Error: Bluetooth I/O Error");
                break;
            case BluetoothDiscoveryModel.InvalidBluetoothAdapterError:
                UIBridge.Info("Error: Invalid Bluetooth Adapter Error"); break;
            case BluetoothDiscoveryModel.NoError:
                break;
            default:
                UIBridge.Info("Error: Unknown Error"); break;
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
                    console.log("Connected to server");
                    UIBridge.Info("Connected to server.")
                    break;
                case BluetoothSocket.Connecting:
                case BluetoothSocket.ServiceLookup:
                case BluetoothSocket.Closing:
                case BluetoothSocket.Listening:
                case BluetoothSocket.Bound:
                    break;
            }
        }
    }
}
