import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.0
import QtQuick.Dialogs 1.2
import ATeam.QtQMLExemple.AssetsSingleton 1.0
import QtQuick.XmlListModel 2.0
import "./components/"

Pane {
        background: Rectangle{
            gradient:Assets.ui.backgradient
        }

    Item{
        width:parent.width
        height:parent.height


        Image{
            source:"qrc:/res/img/a-teamLogo.png"
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
        }

        ATText{
            anchors.right: parent.right
            anchors.bottom : parent.bottom
            height:50
            color:"white"
            textFormat: Text.StyledText
            text:qsTr("www.a-team.fr")
            Layout.fillWidth: true

        }
    }

}
