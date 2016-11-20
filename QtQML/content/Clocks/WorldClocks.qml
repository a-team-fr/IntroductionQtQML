import QtQuick 2.4
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import "../../components/"
import ATeam.QtQMLExemple.AssetsSingleton 1.0

Pane {


    ListView {
        id: clockview
        property int sideWidth : Math.min( parent.width, parent.height)
        width: sideWidth
        height : sideWidth
        anchors.centerIn: parent
        orientation: ListView.Horizontal
        cacheBuffer: 2000
        clip:true
        snapMode: ListView.SnapOneItem
        highlightRangeMode:ListView.StrictlyEnforceRange
        delegate: Clock {
            width:clockview.sideWidth
            height:clockview.sideWidth
            city: cityName;
            shift: timeShift
        }
        model: ListModel {
            ListElement { cityName: "New York"; timeShift: -4 }
            ListElement { cityName: "London"; timeShift: 0 }
            ListElement { cityName: "Oslo"; timeShift: 1 }
            ListElement { cityName: "Mumbai"; timeShift: 5.5 }
            ListElement { cityName: "Tokyo"; timeShift: 9 }
            ListElement { cityName: "Brisbane"; timeShift: 10 }
            ListElement { cityName: "Los Angeles"; timeShift: -8 }
        }
    }


    ATButtonText {
        width:150
        height:150
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.margins: 10
        text:"\uf104" //fa-angle-left
        textColor:"green"
        showOutline: true
        fontFamily: Assets.fonts.awesome.name
        opacity: clockview.atXBeginning ? 0 : 0.8
        Behavior on opacity { NumberAnimation { duration: 500 } }
        onClicked: clockview.decrementCurrentIndex()

    }
    ATButtonText {
        width:150
        height:150
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 10
        text:"\uf105" //fa-angle-right
        textColor:"green"
        fontFamily: Assets.fonts.awesome.name
        showOutline: true
        opacity: clockview.atXEnd ? 0 : 0.8
        Behavior on opacity { NumberAnimation { duration: 500 } }
        onClicked: clockview.incrementCurrentIndex()

    }


}
