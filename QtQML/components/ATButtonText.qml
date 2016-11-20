import QtQuick 2.0
import QtGraphicalEffects 1.0
import ATeam.QtQMLExemple.AssetsSingleton 1.0

Item{
    property alias text : embText.text
    property alias textColor : embText.color
    property color color : Assets.ui.buttonBkColor
    signal clicked()
    property alias fontFamily: embText.font.family
    property bool showOutline : false
    property alias fontPixelSize : embText.font.pixelSize
    width: Assets.ui.defaultWidth
    height:Assets.ui.defaultHeight

    Rectangle{
        id:embRect
        border.color: Qt.darker(color)
        border.width: 2
        radius: height * 0.5
        opacity: Assets.ui.buttonBkOpacity
        visible: parent.showOutline
        anchors.fill: parent
        color: parent.enabled ? parent.color : Assets.ui.buttonBkColorDisabled

        transformOrigin: Item.Center

        gradient: Gradient{
            GradientStop { position: 0.0; color: "white"}//#A07E8F" }
            GradientStop { position: 1.0; color: "black"}//"#6E4F61" }
        }

    }

    ATText
    {
        id: embText
        enabled: parent.enabled
        anchors.fill: parent
        anchors.margins: Assets.ui.buttonMargin
        color: Assets.ui.buttonTextcolor

    }

    MouseArea{
        id:embMA
        anchors.fill:parent
        enabled: parent.enabled
        onClicked: parent.clicked()
    }

}



