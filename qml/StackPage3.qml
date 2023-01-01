import QtQuick.Layouts 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 1.4
import QtQuick.Controls 2.0
import QtQuick 2.0
import QtQuick.Window 2.0
import QtQml.Models 2.1
import QtQuick.Dialogs 1.3


Item {
    id: item_stack_page3

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
}
