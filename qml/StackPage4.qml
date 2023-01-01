import QtQuick.Layouts 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 1.4
import QtQuick.Controls 2.0
import QtQuick 2.0
import QtQuick.Window 2.0
import QtQml.Models 2.1
import QtQuick.Dialogs 1.3


Item {
    id: item_stack_page4

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
}
