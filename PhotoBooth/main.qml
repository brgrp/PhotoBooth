import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2

ApplicationWindow {
    id:idWindow
    title: qsTr("PhotoBooth")
    width: 800
    height: 600
    visible: true

    menuBar: MenuBar {
        Menu {
            title: qsTr("&File")
            MenuItem {
                text: qsTr("&Open")
                onTriggered: messageDialog.show(qsTr("Open action triggered"));
            }
            MenuItem {
                text: qsTr("E&xit")
                onTriggered: Qt.quit();
            }
        }  
    }
    /*
    MainForm {
        anchors.fill: parent
        button1.onClicked: messageDialog.show(qsTr("Button 1 pressed"))
        button2.onClicked: messageDialog.show(qsTr("Button 2 pressed"))
        button3.onClicked: messageDialog.show(qsTr("Button 3 pressed"))
    }*/


    Rectangle {
        id: idMainWindow
        width: idWindow.width
        height: idWindow.height
        color: "red"

        Rectangle
        {
            id: screenView
            anchors { fill: parent; margins: 10 }


        }

        Rectangle{
            id: pictureView
            width: parent.width
            anchors.leftMargin: 22
            anchors.rightMargin: 22
            height: parent.height*0.7
            color: "blue"
        }
        Rectangle
        {
            id: controleArea
            height: parent.height*0.3
            color: "grey"
        }

    }


    MessageDialog {
        id: messageDialog
        title: qsTr("May I have your attention, please?")

        function show(caption) {
            messageDialog.text = caption;
            messageDialog.open();
        }
    }
}
