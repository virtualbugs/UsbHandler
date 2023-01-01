import QtQuick 2.0
import QtQuick.Layouts 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 1.4
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.3



Item {
    id: item_stack_page1

    Connections {
        target: qmlSlots

        // Slots
        function onUsbDevicesFound(devices) {
            for(var i=0; i<devices.length; i++) {
                usbDevices.push(devices[i][0])
                usbDevicePath.push(devices[i][1])
                usbDeviceFormat.push(devices[i][2])
                usbDeviceSize.push(devices[i][3])
                usbDevicePercentages.push(devices[i][4])

                console.log("QML-Found-USB Device Count : ", devices.length)
                console.log("*********** Device-", i, " :" , devices[i][0]);
                console.log("*********** Device-", i, " :" , devices[i][4]);

                modelSelectDevice.append({ "name": devices[i][0], "value": devices[i][4]})
            }
            if (devices.length > 0) {
                usbDeviceCount = devices.length
                stacklayout.currentIndex = 1
            }
            else {
                labelInfo.text = "Any USB is not detected. \nPlease, be sure you gave root access to app"
            }
        }
        function onFormatFailured() {
            // ToDo : Failure Screen
        }
        function onFormatSuccess() {
            // ToDo : Success Screen
        }
    }

    Rectangle {
        color: 'teal'
        implicitWidth: 440
        implicitHeight: 520
        // USB Devices
        ColumnLayout {
            anchors.centerIn: parent

            Label {
                id: labelHeader
                horizontalAlignment: "AlignHCenter"
                verticalAlignment: "AlignVCenter"
                font.pixelSize: 22
                font.italic: true
                text: "Search Inserted Devices"
            }
            Label {
                id: labelInfo
                horizontalAlignment: "AlignHCenter"
                verticalAlignment: "AlignVCenter"
                font.pixelSize: 15
                font.italic: true
                text: ""
            }
            Button{
                id: searchBtn
                Layout.alignment: Qt.AlignHCenter
                anchors.top: labelInfo
                anchors.topMargin: 150
                width: 100
                height: 35

                background: Rectangle {
                      id: searchBtnRect
                      implicitWidth: 100
                      implicitHeight: 35
                      border.color: "#888"
                      color: "black"
                      radius: 4

                      Text {
                          id: btnSearchTxt
                          color: "white"
                          text: "Search"
                          font.pixelSize: 20
                          anchors.fill: searchBtnRect
                          horizontalAlignment : Text.AlignHCenter
                      }

                      MouseArea {
                          anchors.fill: parent
                          onClicked: window.checkUSBDevices("From yes")
                      }
                }
            }
        }
    }

}
