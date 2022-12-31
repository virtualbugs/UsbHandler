import QtQuick.Layouts 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 1.4
import QtQuick.Controls 2.0
import QtQuick 2.0
import QtQuick.Window 2.0
import QtQml.Models 2.1
import QtQuick.Dialogs 1.3


Window {
    id: window
    width: 440
    height: 520
    x:50
    y:50
    maximumHeight: height
    maximumWidth: width
    minimumHeight: height
    minimumWidth: width
    visible: true
    title: qsTr("USB Handler")
    color: "#9CC069"


    // ---------- Connections, Variables ------------
    // signals
    signal checkUSBDevices(string msg)
    signal format(string formatType, string path)

    // variables
    property var usbDeviceCount: 0
    property var usbDevices: []
    property var usbDevicePath: []
    property var usbDeviceFormat: []
    property var usbDeviceSize: []
    property var usbDevicePercentages: []
    property var selectedDeviceName: ""
    property var selectedDevicePath: ""
    property var selectedImagePath: ""

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


    FileDialog {
        id: fileDialogSelectImage
        title: "Please choose image file"
        folder: shortcuts.home
        onAccepted: {
            var path = fileDialogSelectImage.fileUrl.toString();
            path = path.replace(/^(file:\/{2})/,"");
            selectedImagePath = path
            console.log("Chosed file : " + path)
            usbBurnSelectImageTxt.text = "Selected Image : \n" + selectedImagePath
            fileDialogSelectImage.close()
        }
        onRejected: {
            console.log("Canceled")
            fileDialogSelectImage.close()
        }
        Component.onCompleted: visible = false
    }

    ButtonGroup { id: selectDevicesGroup }
    ButtonGroup { id: selectUSBFormatGroup }



    StackLayout {
        id: stacklayout
        anchors.fill: parent
        currentIndex: 0

        // --------- Stack Layout - Item 1 - Search Devices -----------
        Rectangle {
            color: 'teal'
            implicitWidth: 200
            implicitHeight: 200
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

        // --------- Stack Layout - Item 2 - Select Device -----------
        Rectangle {
            id: rectModel
            color: 'teal'
            implicitWidth: 180
            implicitHeight: 200

            ColumnLayout {
                anchors.centerIn: parent

                Rectangle {
                    color: 'teal'
                    width: 180; height: 200

                    ListView {
                        id: listviewSelectDevice
                        anchors.fill: parent
                        model: modelSelectDevice
                        delegate: delegateSelectDevice
                        focus: true
                        spacing: 10

                    }

                    ListModel {
                        id: modelSelectDevice
                    }

                    Component {
                        id: delegateSelectDevice
                        Item {
                            width: 180; height: 40

                            Rectangle {
                                color: "lightsteelblue";
                                anchors.fill: parent
                                Row {
                                    anchors.fill: parent

                                    RadioButton {
                                        width: 30
                                        height: 40
                                        ButtonGroup.group: selectDevicesGroup
                                        onCheckedChanged: {
                                            if(checked) {
                                                listviewSelectDevice.currentIndex = index
                                                console.log("Selected Index : ", listviewSelectDevice.currentIndex)
                                            }
                                        }
                                    }

                                    Column {
                                        width: 150
                                        height: 40
                                        Text { text: '<b>Device:</b> ' + model.name }
                                        ProgressBar {
                                            value: model.value
                                            anchors.fill: parent
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                Button{
                    id: selectBtn
                    Layout.alignment: Qt.AlignHCenter
                    anchors.topMargin: 150
                    width: 100
                    height: 35

                    background: Rectangle {
                          implicitWidth: 100
                          implicitHeight: 35
                          color: "black"
                          radius: 4

                          Text {
                              color: "white"
                              text: "Select"
                              font.pixelSize: 20
                              anchors.fill: rect
                              horizontalAlignment : Text.AlignHCenter
                              width: parent.width
                          }

                          MouseArea {
                              anchors.fill: parent
                              onClicked: {
                                  stacklayout.currentIndex = 2


                                  usbInfoText_1.text = usbDevices[listviewSelectDevice.currentIndex]
                                  usbInfoText_2.text += usbDeviceSize[listviewSelectDevice.currentIndex]
                                  usbInfoText_3.text += usbDevicePath[listviewSelectDevice.currentIndex]
                                  usbInfoText_4.text += usbDeviceFormat[listviewSelectDevice.currentIndex]
                                  usbInfoText_5.text += 100* usbDevicePercentages[listviewSelectDevice.currentIndex] + "% is used"

                                  selectedDeviceName = usbDevices[listviewSelectDevice.currentIndex]
                                  selectedDevicePath = usbDevicePath[listviewSelectDevice.currentIndex]
                              }
                          }
                    }
                }

            }

        }

        // --------- Stack Layout - Item 3 - Format & Burn Selection -----------
        Rectangle {
            id: rectUSBInfo
            color: 'teal'
            implicitWidth: 180
            implicitHeight: 500

            Column {
                anchors{
                    horizontalCenter: parent.horizontalCenter
                    fill: parent
                }

                Text {
                    id: usbInfoText_1
                    text: ""
                    horizontalAlignment : Text.AlignHCenter
                    font.pixelSize: 35
                    width: parent.width
                }
                Text {
                    id: usbInfoText_2
                    text: ""
                    horizontalAlignment : Text.AlignHCenter
                    font.pixelSize: 20
                    width: parent.width
                }
                Text {
                    id: usbInfoText_3
                    text: ""
                    horizontalAlignment : Text.AlignHCenter
                    font.pixelSize: 20
                    width: parent.width
                }
                Text {
                    id: usbInfoText_4
                    text: ""
                    horizontalAlignment : Text.AlignHCenter
                    font.pixelSize: 20
                    width: parent.width
                }
                Text {
                    id: usbInfoText_5
                    text: ""
                    horizontalAlignment : Text.AlignHCenter
                    font.pixelSize: 20
                    width: parent.width
                }

                Column {
                    height: 500



                    Button{
                        id: formatSectionBtn

                        background: Rectangle {
                              width: 210
                              height: 35
                              x: 120
                              y: 100
                              color: "black"
                              radius: 4

                              Text {
                                  color: "white"
                                  text: "Format USB"
                                  font.pixelSize: 20
                                  anchors.fill: rect
                                  horizontalAlignment : Text.AlignHCenter
                                  width: parent.width
                              }

                              MouseArea {
                                  anchors.fill: parent
                                  onClicked: {
                                      stacklayout.currentIndex = 3
                                  }
                              }
                        }
                    }
                    Button{
                        id: burnSectionBtn
                        Layout.alignment: Qt.AlignHCenter


                        background: Rectangle {
                              width: 210
                              height: 35
                              x: 120
                              y: 150
                              color: "black"
                              radius: 4

                              Text {
                                  color: "white"
                                  text: "Burn Image on USB"
                                  font.pixelSize: 20
                                  anchors.fill: rect
                                  horizontalAlignment : Text.AlignHCenter
                                  width: parent.width
                              }

                              MouseArea {
                                  anchors.fill: parent
                                  onClicked: {
                                      stacklayout.currentIndex = 4
                                  }
                              }
                        }
                    }
                }

            }

        }

        // --------- Stack Layout - Item 4 - Format Device -----------
        Rectangle {
            id: rectUSBFormat
            color: 'teal'
            implicitWidth: 180
            implicitHeight: 500

            // Format Type Selection
            ColumnLayout {
                anchors.centerIn: parent

                Rectangle {
                    color: 'teal'
                    width: 180; height: 200

                    ListView {
                        id: listviewUsbFormats
                        anchors.fill: parent
                        model: usbFormatModel
                        delegate: usbFormatDelegate
                        spacing: 10
                    }
                    ListModel {
                        id: usbFormatModel
                        ListElement {
                            name: "FAT32"
                        }
                        ListElement {
                            name: "NTFS"
                        }
                        ListElement {
                            name: "exFAT"
                        }
                    }

                    Component {
                        id: usbFormatDelegate
                        Item {
                            width: 180; height: 40

                            Rectangle {
                                color: "#E3E566";
                                anchors.fill: parent
                                Row {
                                    anchors.fill: parent

                                    RadioButton {
                                        width: 30
                                        height: 40
                                        ButtonGroup.group: selectUSBFormatGroup
                                        onCheckedChanged: {
                                            if(checked) {
                                                listviewUsbFormats.currentIndex = index
                                                console.log("Selected Format : ", listviewUsbFormats.currentIndex)
                                            }
                                        }
                                    }

                                    Column {
                                        width: 150
                                        height: 40
                                        Text {
                                            text: model.name
                                            font.pixelSize: 20
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                // Warning Text
                Text {
                    text: "Warning, you will lose \nall your data after this operation."
                    horizontalAlignment : Text.AlignHCenter
                    font.pixelSize: 15
                }

                // Format Button
                Button{
                    id: formatBtn
                    Layout.alignment: Qt.AlignHCenter
                    anchors.topMargin: 150
                    width: 100
                    height: 35

                    background: Rectangle {
                          implicitWidth: 100
                          implicitHeight: 35
                          color: "black"
                          radius: 4

                          Text {
                              color: "white"
                              text: "Format"
                              font.pixelSize: 20
                              anchors.fill: rect
                              horizontalAlignment : Text.AlignHCenter
                              width: parent.width
                          }

                          MouseArea {
                              anchors.fill: parent
                              onClicked: {
                                  if(listviewUsbFormats.currentIndex == 0)
                                    format("fat32" , selectedDevicePath)
                                  else if(listviewUsbFormats.currentIndex == 1)
                                    format("ntfs" , selectedDevicePath)
                                  else if(listviewUsbFormats.currentIndex == 2)
                                    format("exfat" , selectedDevicePath)
                              }
                          }
                    }
                }
            }
        }

        // --------- Stack Layout - Item 5 - Burn Device -----------
        Rectangle {
            id: rectUSBBurn
            color: 'teal'
            implicitWidth: 180
            implicitHeight: 500

            ColumnLayout {
                anchors.fill: parent

                Text {
                    id: usbBurnSelectImageTxt
                    Layout.alignment: Qt.AlignHCenter
                    anchors.top: rectUSBBurn.top
                    text: "Please Select Image"
                    font.pixelSize: 15
                }

                // Button Select Image
                Button{
                    id: buttonSelectImage
                    Layout.alignment: Qt.AlignHCenter
                    anchors.top: usbBurnSelectImageTxt.bottom
                    anchors.topMargin: 30
                    width: 24
                    height: 24

                    background: Rectangle {
                          id: buttonSelectImageRect
                          radius: 20
                          width: 24
                          height: 24

                          Image {
                              id: buttonSelectImage_Image
                              anchors.fill: parent
                              source: "res/plus.png"
                              horizontalAlignment : Text.AlignHCenter
                          }

                          MouseArea {
                              anchors.fill: parent

                              onClicked: {
                                 fileDialogSelectImage.open()
                              }
                          }
                    }
                }

                // Button Burn
                Button{
                    id: buttonBurn
                    Layout.alignment: Qt.AlignHCenter
                    anchors.top: buttonSelectImage.bottom
                    anchors.topMargin: 60
                    width: 100
                    height: 35

                    background: Rectangle {
                          id: buttonBurnRect
                          implicitWidth: 100
                          implicitHeight: 35
                          color: "black"
                          radius: 4

                          Text {
                              id: buttonBurnTxt
                              color: "white"
                              text: "Burn"
                              font.pixelSize: 20
                              Layout.alignment: Qt.AlignHCenter
                          }

                          MouseArea {
                              anchors.fill: parent

                          }
                    }
                }
            }

        }

    }
}
