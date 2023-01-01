import QtQuick.Layouts 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 1.4
import QtQuick.Controls 2.0
import QtQuick 2.0
import QtQuick.Window 2.0
import QtQml.Models 2.1
import QtQuick.Dialogs 1.3


Item {
    id: item_stack_page5

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
