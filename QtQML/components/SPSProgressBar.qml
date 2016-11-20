import QtQuick 2.0

Rectangle {
    color:"darkgrey"
    property real minValue : 0
    property real maxValue : 100
    property real value : 0
    property bool showAsPerc : true
    property alias sourceSymbol : symbol.source
    property string prefixText : ""
    //property alias backgroundColor : color
    property alias foregroundColor : progress.color
    property alias textColor : embText.color

    property real percValue : Math.floor(( value - minValue) / ( maxValue - minValue) * 100)

    Rectangle{
        id:progress
        property int margins : 2
        radius : parent.radius
        x: margins
        y: margins
        height : parent.height - 2* margins
        width : Math.min( (parent.width - 2 * margins), ((parent.width - 2 * margins) * parent.percValue / 100))
        color: globals.ui.buttonBkColor


    }
    Image{
        id: symbol
        height : parent.height
        width : height
        source : ""
    }

    Text
    {
        id: embText
        text: parent.showAsPerc ? parent.prefixText + parent.percValue + " %" : parent.prefixText + parent.value
        anchors.fill: parent
        anchors.margins: globals.ui.buttonMargin
        color: globals.ui.textcolor
        font.pixelSize: globals.ui.textGodzilla
        minimumPixelSize: globals.ui.minimumPixelSize
        fontSizeMode : Text.Fit
        font.family: "Syncopate"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment : Text.AlignVCenter
    }
}

