import QtQuick 2.0
import QtQuick.Controls 2.0
import ATeam.QtQMLExemple.AssetsSingleton 1.0
import "./components/"

Rectangle {
    id:root

    property int nbPages : 1
    property int currentPage:0
    property string label:""

    signal toggleDrawerVisibility
    signal nextPane
    signal previousPane

    width:200
    height:50
    color: Assets.ui.aTGreen//menuBackground
    Row{
        anchors.fill: parent
        property int widthLabel : width - 3 * height - 2* spacing
        ATButtonText {
            height: parent.height
            width: height
            fontFamily: Assets.fonts.awesome.name
            text:"\uf0c9" //fa-align-justify
            onClicked: root.toggleDrawerVisibility()
        }

        Item{
            height: parent.height
            width: height
            ATButtonText {
                anchors.fill: parent
                fontFamily: Assets.fonts.awesome.name
                text:"\uf104" //fa-angle-left
                onClicked: root.previousPane()
                visible:root.currentPage>0
            }
        }



        ATText{
            height:parent.height
            width : parent.widthLabel
            text:root.label
            color:Assets.ui.titleTextcolor

        }

        ATButtonText {
            height: parent.height
            width: height
            fontFamily: Assets.fonts.awesome.name
            text:"\uf105" //fa-angle-right
            onClicked: root.nextPane()
            visible:root.currentPage!= (nbPages-1)
        }

    }
}
