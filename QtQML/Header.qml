import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import ATeam.QtQMLExemple.AssetsSingleton 1.0
import "./components/"

Rectangle {
    id:root

    signal toggleSettingsVisibility
    signal toggleAboutVisibility
    color: Assets.ui.menuBackground
    Row {

        anchors.fill: parent
        anchors.margins: 10
        spacing : 10


        ATText {
            text: qsTr("QtQML introduction")
            width : parent.width - (parent.height + parent.spacing)
            height: parent.height
            color:Assets.ui.titleTextcolor
        }

        ATButtonText {
            height: parent.height
            width: height
            fontFamily: Assets.fonts.awesome.name
            text:"\uf0ad" //fa-wrench
            onClicked: optionsMenu.open()
            Menu {
                id: optionsMenu
                x: parent.width - width
                transformOrigin: Menu.TopRight

                MenuItem {
                    text: "Settings"
                    onTriggered: root.toggleSettingsVisibility()
                }
                MenuItem {
                    text: "About"
                    onTriggered: root.toggleAboutVisibility()
                }
            }
        }
    }
}
