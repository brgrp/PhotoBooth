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
                    //screenView_pictureView_photoPreview.source = preview  // Show the preview in an Image
                    screenView_pictureView_photoBIG.source=preview
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
                id: screenView_left
                visible: true
                width: parent.width*0.2
                anchors.left: parent.left
                height: parent.height
                color: "red"
            }

            Rectangle
            {
                id: screenView_midle
                visible: true
                width: parent.width*0.6
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                height: parent.height
                color: "green"

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
                        Image { source: "http://thumbs.dreamstime.com/z/abstraktes-pixel-dreieck-muster-38802215.jpg" }
                        Rectangle
                        {
                            id: screenView_pictureView
                            height: parent.height*0.9
                            width: parent.height*0.9
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: "black"
                            clip: true
                            border.color: "black"
                            border.width: 5
                                                                //transform: Scale {xScale: 0.5; yScale: 0.7}

                            VideoOutput
                            {
                                id: screenView_pictureView_live
                                source: camera
                                orientation:1
                                //anchors.fill: parent

                                focus : visible // to receive focus and capture key events when visible
                                transform: Scale {xScale: 0.938; yScale:0.938}
                                x:-(width-parent.width)/2
                            }

//                            Text
//                            {
//                                x: parent.x+200
//                                anchors.verticalCenter: parent.verticalCenter
//                                //anchors.fill : parent
//                                color: "red"
//                                text: "scale: " + parent.height/screenView_pictureView_live.height + "\ndeltaX: " + -(width-parent.width)/2+ "\ndeltaY: " + -(height-parent.height)/2
//                                font.pixelSize: 28
//                            }

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
                                screenView.visible=false;
                                camera.imageCapture.capture();
                                screenView_pictureView_photoBIG_button.color = "red";
                                camera.imageCapture.captureToLocation("../../../Bilder/"+Date.now()+".png");
                                screenView_pictureView_BigScreen.visible=true;
                                //camera.stop();
                            }
                        }
                    }
                }
             }

             Rectangle
             {
                id: screenView_right
                visible: true
                width: parent.width*0.2
                anchors.right: parent.right
                anchors.leftMargin: 22
                anchors.rightMargin: 22
                height: parent.height
                color: "blue"

            }


        }
        Rectangle
        {
            id: screenView_pictureView_BigScreen
            visible: false
            anchors { fill: parent; margins: 10 }

            color:"black"
            Image
            {
                clip: true
                id: screenView_pictureView_photoBIG
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
                asynchronous: true
                smooth: true
            }
            Rectangle
            {
                id:screenView_pictureView_photoBIG_button
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                width: parent.height*0.2
                height: width
                border.color: "white"
                color: "red"
                border.width: 5
                radius: width*0.5
            }
            Text
            {
                id:screenView_pictureView_photoBIG_button_text
                anchors.horizontalCenter: screenView_pictureView_photoBIG_button.horizontalCenter
                anchors.verticalCenter: screenView_pictureView_photoBIG_button.verticalCenter
                //anchors.fill : parent
                color: "white"
                text: "back!"
                font.family: "Ubuntu"
                font.pixelSize: 28
            }

            MouseArea
            {
                id:screenView_pictureView_photoBIG_button_mousearea
                anchors.fill: parent
                onClicked:
                {
                    screenView_pictureView_photoBIG_button.color = "darkred";
                    screenView_pictureView_live.visible=true;
                    screenView_pictureView_live.enabled=true;
                    screenView.visible=true;
                    screenView_pictureView_BigScreen.visible=false;
                    screenView_controleArea_button.color="red";
                    screenView_pictureView_photoBIG.source="";
                    //camera.start();

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
