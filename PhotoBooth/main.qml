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
        color: "white"

        //Functions
        Camera
        {
            id: camera
            imageProcessing.whiteBalanceMode: CameraImageProcessing.WhiteBalanceAuto

            exposure {
                exposureCompensation: -1.0
                exposureMode: Camera.ExposureBeach
            }

//                flash.mode: Camera.FlashRedEyeReduction

            imageCapture {
                resolution: Qt.size(120,120)
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
                id: screenView_picture
                visible: true
                width: parent.width
                anchors.leftMargin: 22
                anchors.rightMargin: 22
                height: parent.height*0.7
                color: "lightgrey"

                Rectangle
                {
                    id: screenView_pictureView_frame
                    visible: true
                    anchors.leftMargin: 22
                    anchors.rightMargin: 22
                    height: parent.height
                    width: parent.width*0.5
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "black"

                    Rectangle
                    {
                        id: screenView_pictureView
                        height: parent.height*0.96
                        width: parent.width
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: "black"

                        VideoOutput
                        {
                            id: screenView_pictureView_live
                            source: camera
                            height: 100
                            width:100
                            focus : visible // to receive focus and capture key events when visible

                        }

                        Image
                        {
                            id: screenView_pictureView_photoPreview

                            width: 130; height: 100
                        }
                    }
                }

            }
            Rectangle
            {
                id: screenView_controleArea
                width: parent.width
                height: parent.height*0.3
                anchors.bottom: parent.bottom
                color: "lightgrey"


                Rectangle
                {
                    id:screenView_controleArea_button
                    width: parent.width < parent.height ?parent.width : parent.height
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: width
                    color: "red"
                    border.color: "white"
                    border.width: 5
                    radius: width*0.5

                     Text
                     {
                         id:screenView_controleArea_button_text
                         anchors.horizontalCenter: parent.horizontalCenter
                         anchors.verticalCenter: parent.verticalCenter
                              //anchors.fill : parent
                        color: "white"
                        text: "Take my \n Picture!"
                        font.family: "Ubuntu"
                        font.pixelSize: 28
                     }
                     MouseArea
                     {
                         id:screenView_controleArea_button_mousearea
                         anchors.fill: parent
                         onClicked:
                         {
                             parent.color = "darkred";
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
