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
        StackPage1 {

        }

        // --------- Stack Layout - Item 2 - Select Device -----------
        StackPage2 {

        }

        // --------- Stack Layout - Item 3 - Format & Burn Selection -----------
        StackPage3 {

        }

        // --------- Stack Layout - Item 4 - Format Device -----------
        StackPage4 {

        }

        // --------- Stack Layout - Item 5 - Burn Device -----------
        StackPage5 {

        }
    }
}
