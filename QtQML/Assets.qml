import QtQuick 2.0
import QtMultimedia 5.0
import Qt.labs.settings 1.0

pragma Singleton

Item {
    property var ui:ui
    property var sounds:sounds
    property var fonts:fonts


    //Component.onCompleted: console.info("loading Assets singleton")

    Settings{
        property alias menuBackground : ui.menuBackground
    }

    Item{
        id:fonts
        property FontLoader awesome: FontLoader{ source: "qrc:/res/fonts/fontawesome-webfont.ttf" }
        property FontLoader defaultFont: FontLoader{ source: "qrc:/res/fonts/Arista2.0.ttf" }
    }

    Item{
        id:ui
        property int defaultHeight : 30
        property int defaultWidth : 200
//        property color green:"#A2C64C"
        property color darkBlue:"#171B3E"
        property color aTGreen : "#41B34F"
        property color aTLightBlue : "#1E75B4"
        property color aTDarkBlue : "#156294"
//        property color background:"lightgrey"
        property color menuBackground:aTDarkBlue
        property color titleTextcolor:"white"
        property color textcolor:"darkGrey"
//        property color textEditColor:"white"
//        property color buttonMenuBkColor:"lightgrey"
//        property color buttonMenuBkColorDisabled:"grey"
        property color buttonBkColor:"#428bca"
        property color buttonBkColorDisabled:"grey"
        property color buttonTextcolor:"white"
        property real buttonBkOpacity:0.3
//        property color borderColor:"grey"
//        property color textInputBackground:"#171B3E"
//        property real buttonRadiusPercHeight: 0.2 //Defines the perc of height to compute the corner radius
//        property real backgroundRadiusPercHeight: 0.1
        property int buttonMargin: 10
        property int minimumPixelSize:6
        property int maximumPixelSize:250
//        property int textInputDynSize: textM
//        property real scaleFactor: 1
//        property int textS:8
//        property int textM:16
//        property int textXL:32
//        property int textXXL:54
//        property int textXXXL:72
//        property int textGodzilla:100
        property Gradient backgradient: Gradient{
            GradientStop{ position: 0; color:ui.aTDarkBlue}
            GradientStop{ position: 0.35; color:ui.aTLightBlue}
            GradientStop{ position: 1; color:ui.aTGreen}
        }


    }
    Item{
        id:sounds
        property var scanQrOk:scanQrOk

        SoundEffect {
            id: scanQrOk
            source: "qrc:/res/audio/scanQrOk.wav"
        }
    }




}




