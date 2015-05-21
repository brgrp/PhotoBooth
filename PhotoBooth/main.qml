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

    Image {
        id: preview_image

    }

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
            captureMode: Camera.CaptureStillImage

            exposure {
                exposureCompensation: -1.0
                exposureMode: Camera.ExposureBeach
            }

            imageCapture {
                onImageCaptured: {
                    screenView_pictureView_photoBIG.source = preview  // Show the preview in an Image
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
                height: parent.height*0.75
                color: "lightgrey"


                Rectangle
                {
                    id: screenView_pictureView_frame
                    visible: true
                    anchors.leftMargin: 22
                    anchors.rightMargin: 22
                    height: parent.height
                    width: parent.height
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    clip: true
                    Image { source: "https://thumbs.dreamstime.com/z/abstraktes-pixel-dreieck-muster-38802215.jpg" }

                    Rectangle
                    {
                        id: screenView_pictureView
                        height: parent.height*0.9
                        width: parent.height*0.9
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: "red"
                        clip: true
                        border.color: "red"
                        border.width: 5

                        VideoOutput
                        {
                            id: screenView_pictureView_live
                            source: camera
                            focus: visible
                            smooth: true
                        }

                        Image
                        {
                            clip: true
                            id: screenView_pictureView_photoPreview
                            //anchors.fill: parent
                            fillMode: Image.PreserveAspectFit
                            asynchronous: true
                            smooth: true
                        }
                    }
                }

                Rectangle
                {
                    id: screenView_pictureView_BigScreen
                    visible: false

                    Image
                    {
                        clip: true
                        id: screenView_pictureView_photoBIG
                        //anchors.fill: parent
                        fillMode: Image.PreserveAspectFit
                        asynchronous: true
                        smooth: true
                    }

                }

                MouseArea
                {
                    id:screenView_pictureView_button_mousearea
                    anchors.fill: parent
                    onClicked:
                    {
                        screenView_controleArea_button_text.color = "red";
                        console.log("Take new picture")

                        screenView_pictureView_live.visible=true;
                        screenView_pictureView_live.enabled=true;
                        camera.imageCapture.capture();

                    }
                }

            }
            Rectangle
            {
                id: screenView_controleArea
                width: parent.width
                height: parent.height*0.25
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
                             screenView_pictureView_live.visible=false;
                             screenView_pictureView_live.enabled=false;
                             screenView_pictureView_frame.visible=false;
                             screenView_pictureView_BigScreen.visible=true;
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
