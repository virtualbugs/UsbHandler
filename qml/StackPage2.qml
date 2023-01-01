import QtQuick.Layouts 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 1.4
import QtQuick.Controls 2.0
import QtQuick 2.0
import QtQuick.Window 2.0
import QtQml.Models 2.1
import QtQuick.Dialogs 1.3

Item {
    id: item_stack_page2

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
}
