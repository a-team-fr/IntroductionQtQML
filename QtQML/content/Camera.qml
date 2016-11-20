import QtQuick 2.5
import QtMultimedia 5.5
import QtSensors 5.3
import QtQuick.Controls 2.0

import ATeam.QtQMLExemple.AssetsSingleton 1.0
import "../components/"

Pane{
//    background: Rectangle{
//        gradient:Assets.ui.backgradient
//    }
    Rectangle {
        property int heightHeader : Math.max(50, height * 0.08)
        property int animDuration : 500

        id:root
        anchors.fill:parent
        color:"black"

        function shoot(){
            if (( !delayShoot.activated) && camera.imageCapture.ready)

                camera.imageCapture.capture();
            else{
                delayTimer.start();
            }
        }

        OrientationSensor{
            id:orient
            active:true
            property int rotAngle :0
            property bool isPortrait : true
            onReadingChanged: {
                if (reading.orientation === OrientationReading.LeftUp)
                {
                    rotAngle = -90;
                    isPortrait = false;
                }
                else if (reading.orientation === OrientationReading.RightUp)
                {
                    rotAngle = 90;
                    isPortrait = false;
                }
                else if (reading.orientation === OrientationReading.TopDown)
                {
                    isPortrait = true;
                    rotAngle = 180;
                }
                else {
                    isPortrait = true;
                    rotAngle = 0;
                }

            }
        }

        Timer{
           id:delayTimer
           interval : 1000
           property int remainingSec : 5
           property int nbSec : 5
           repeat: true
           onTriggered: {
               if (remainingSec <= 0)
               {
                   stop();
                   remainingSec = nbSec;
                   camera.imageCapture.capture();
               }
               else remainingSec--;
           }

        }

        Camera {
            id: camera
            captureMode: Camera.CaptureStillImage

            position:Camera.BackFace
            flash.mode: Camera.FlashAuto

            property string lastPhotoPath :""

            imageCapture {
                onImageSaved: {

                     //image should be saved to "path" likely in QStandardPaths::writableLocation(QStandardPaths::PicturesLocation)

                    if (Qt.platform.os == 'ios' )
                        previewImage.source = "file://"+path;
                    else previewImage.source = "file:///"+path;
                    lastPhotoPath = path;
                    imagePreview.visible = true;
                    //utility.saveImageToCameraRoll(path);

                }
            }
        }

        VideoOutput {
            id: viewfinder
            visible: true
            anchors.fill : parent

            source: camera
            autoOrientation: Qt.platform.os == 'ios' ? false : true
            orientation: camera.orientation

            PinchArea{
                id:zoomPinch
                anchors.fill: parent
                enabled: true
                pinch.minimumScale: 1
                pinch.maximumScale: camera.maximumDigitalZoom
                scale: camera.digitalZoom
                onPinchStarted: {
                    scale = camera.digitalZoom;
                    zoom.visible = true;
                }
                onPinchFinished: zoom.visible = false;
                onPinchUpdated: {
                    camera.digitalZoom = pinch.scale;

                }
            }
        }

        Rectangle{
            id:header
            width: parent.width
            height: parent.heightHeader
            anchors.top : parent.top
            color: Assets.ui.aTGreen
            opacity:0.7
            border.width: 2
            border.color: "black"


            Row{
                anchors.fill: parent
                spacing: (width - nbElem * itemSize) / (nbElem - 1)
                property int nbElem : 4
                property int itemSize : Math.min( width  / nbElem, height) * 0.8

                //Flash
                Item{
                    height:parent.itemSize
                    width:height
                    anchors.verticalCenter: parent.verticalCenter
                    ATColImageSelector{
                        id:flash
                        height : orient.rotAngle == 0 ? parent.height : parent.width
                        width: orient.rotAngle == 0 ? parent.width : parent.height
                        contentRotation: orient.rotAngle

                        Behavior on contentRotation { NumberAnimation { duration: root.animDuration } }
                        lstImage:ListModel{
                            ListElement{ imgPath:"qrc:/res/img/cam_flash_auto.png"; value:Camera.FlashAuto}
                            ListElement{ imgPath:"qrc:/res/img/cam_flash_fill.png"; value:Camera.FlashOn}
                            ListElement{ imgPath:"qrc:/res/img/cam_flash_off.png"; value:Camera.FlashOff}
                            ListElement{ imgPath:"qrc:/res/img/cam_flash_redeye.png"; value:Camera.FlashRedEyeReduction}
                        }
                        onChanged: camera.flash.mode = value
                    }
                }
                Item{
                    height:parent.itemSize
                    width:height
                    anchors.verticalCenter: parent.verticalCenter
                    ATColImageSelector{
                        id:delayShoot
                        height : orient.rotAngle == 0 ? parent.height : parent.width
                        width: orient.rotAngle == 0 ? parent.width : parent.height
                        contentRotation: orient.rotAngle

                        Behavior on contentRotation { NumberAnimation { duration: root.animDuration } }
                        property bool activated : false

                        lstImage:ListModel{
                            ListElement{ imgPath:"qrc:/res/img/cam_delay_off.png"; value:0}
                            ListElement{ imgPath:"qrc:/res/img/cam_delay.png"; value:1}

                        }
                        onChanged: activated = value == 1
                    }
                }
                Item{
                    height:parent.itemSize
                    width:height
                    anchors.verticalCenter: parent.verticalCenter
                    //Camera change
                    Image{
                        id:changeCam
                        height : orient.rotAngle == 0 ? parent.height : parent.width
                        width: orient.rotAngle == 0 ? parent.width : parent.height
                        rotation: orient.rotAngle
                        Behavior on rotation { NumberAnimation { duration: root.animDuration } }
                        fillMode: Image.PreserveAspectFit
                        source:"qrc:/res/img/cam_change.png"

                        MouseArea{
                            anchors.fill : parent
                            onClicked:{
                                if (camera.position===Camera.BackFace)
                                    camera.position=Camera.FrontFace
                                else camera.position=Camera.BackFace
                            }
                        }
                    }
                }
            }
        }


        ProgressBar{
            id:zoom
            visible:false
            width: parent.width
            height: 15
            anchors.bottom : crosshair.top
            value : camera.opticalZoom * camera.digitalZoom
            from: 1
            to: camera.maximumOpticalZoom * camera.maximumDigitalZoom
        }




        Rectangle{
            id:crosshair
            width: parent.width * 0.2
            height: width

            anchors.bottom : parent.bottom
            anchors.bottomMargin: width*0.25
            anchors.horizontalCenter: parent.horizontalCenter

            color: "transparent"
            radius : width * 0.5

            border.color: Assets.ui.aTGreen
            border.width: width*0.1

            visible: camera.imageCapture.ready && !timeOut.visible

            Rectangle{
                anchors.fill: parent
                anchors.margins : parent.width *0.2
                color: Assets.ui.aTGreen
                radius : width * 0.5
                opacity : 0.4
            }
            MouseArea{
                anchors.fill : parent
                enabled: camera.imageCapture.ready
                onClicked: root.shoot()
            }
        }

        ATText{
            id:timeOut
            rotation: orient.rotAngle
            anchors.fill: viewfinder
            visible : delayTimer.running
            text : delayTimer.remainingSec
            color:Assets.ui.aTGreen
        }


        Item{
            id:imagePreview
            visible : false
            anchors.fill: parent

            Image{
                id:previewImage
                width:parent.width;
                height:parent.height;
                autoTransform:true
                rotation : orient.rotAngle//Qt.platform.os == 'ios' ? 90 : 0
                transformOrigin: Item.Center
                fillMode : Image.PreserveAspectFit
                scale : orient.isPortrait ? 1.0 :  height/width
            }

            Image{
                id:resumeTakePhoto
                anchors.centerIn: parent
                width:50
                height:50
                fillMode: Image.PreserveAspectFit
                source:"qrc:/res/img/cross.png"
                rotation: orient.rotAngle
                Behavior on rotation { NumberAnimation { duration: root.animDuration } }
                MouseArea{
                    anchors.fill : parent
                    onClicked:{
                        imagePreview.visible = false
                    }
                }
            }

        }
    }

}



