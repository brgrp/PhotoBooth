import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtMultimedia 5.4

ApplicationWindow {
    id:idWindow
    title: qsTr("PhotoBooth")
    width: 1280
    height: 1024
    visible: true

    Rectangle {
        id: idMainWindow
        width: idWindow.width
        height: idWindow.height
        color: "red"

        //Functions
        Camera
        {
            id: camera
            imageProcessing.whiteBalanceMode: CameraImageProcessing.WhiteBalanceAuto

            exposure {
                exposureCompensation: -1.0
                exposureMode: Camera.ExposurePortrait
            }

//                flash.mode: Camera.FlashRedEyeReduction

            imageCapture {
                onImageCaptured: {
                    screenView_pictureView_photoPreview.source = preview  // Show the preview in an Image
                    console.log("imageCapture successfull")
                }
            }
        }

        Rectangle
        {
            id: screenView
            anchors { fill: parent; margins: 10 }

            Rectangle
            {
                id: screenView_pictureView
                visible: true
                width: parent.width
                anchors.leftMargin: 22
                anchors.rightMargin: 22
                height: parent.height*0.7
                color: "blue"

                VideoOutput
                {
                    id: screenView_pictureView_live
                    source: camera
                    anchors.fill: parent
                    focus : visible // to receive focus and capture key events when visible
                }
                Image
                {
                    id: screenView_pictureView_photoPreview
                    anchors.fill: parent
                }

            }
            Rectangle
            {
                id: screenView_controleArea
                width: parent.width
                height: parent.height*0.3
                anchors.bottom: parent.bottom
                color: "green"

                Rectangle
                {
                         id:screenView_controleArea_button
                         width: parent.width < parent.height ?parent.width : parent.height
                         anchors.horizontalCenter: parent.horizontalCenter
                         height: width
                         color: "red"
                         border.color: "black"
                         border.width: 1
                         radius: width*0.5

                     Text
                     {
                         id:screenView_controleArea_button_text
                         anchors.horizontalCenter: parent.horizontalCenter
                         anchors.verticalCenter: parent.verticalCenter
                              //anchors.fill : parent
                              color: "black"
                              text: "Boom"
                              font.family: "Ubuntu"
                              font.pixelSize: 28
                     }
                     MouseArea
                     {
                         id:screenView_controleArea_button_mousearea
                         anchors.fill: parent
                         onClicked:
                         {
                             parent.color = "blue";
                             //screenView_pictureView_live.visible=false;
                             camera.start();
                             camera.imageCapture.capture();
                             camera.stop();




                         }
                     }

                }


            }



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
