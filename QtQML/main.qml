import QtQuick 2.7
import QtQuick.Controls 2.0
import Qt.labs.settings 1.0
import ATeam.QtQMLExemple.AssetsSingleton 1.0
import "./components/"

ApplicationWindow {
    id:window
    visible: true
    width: 640
    height: 480
    title: qsTr("Introduction to Qt and QML")



    Settings {
        id: settings
        property alias width : window.width
        property alias height : window.height
        property alias style : settingsDialog.style

    }

    header:Header{
        height:Math.max(50,window.height / 6)

        onToggleAboutVisibility: aboutDialog.open()
        onToggleSettingsVisibility: settingsDialog.open()
    }


    ListModel{
        id:contentList
        ListElement{
            label: qsTr("Sensors : accel and mag")
            url: "qrc:/content/Sensors/SensorsPane.qml"
        }
        ListElement{
            label: qsTr("Sensors : others")
            url: "qrc:/content/Sensors/SensorsPane2.qml"
        }
        ListElement{
            label: qsTr("Flick'r")
            url: "qrc:/content/FlickrPane.qml"
        }
        ListElement{
            label: qsTr("Clocks of the world")
            url: "qrc:/content/Clocks/WorldClocks.qml"
        }
        ListElement{
            label: qsTr("Playing with camera")
            url: "qrc:/content/Camera.qml"
        }
        ListElement{
            label: qsTr("around the world")
            url: "qrc:/content/Geoloc.qml"
        }
    }


    Drawer{
        id:drawer
        height:window.height
        width: 0.6 * window.width
        background: Rectangle{ color:Assets.ui.menuBackground}
        ListView{
            id:listView
            model:contentList
            anchors.fill: parent
            currentIndex: -1
            onCurrentIndexChanged: loadPane()

            delegate:ATButtonText{
                property var modelData : model
                width: drawer.width
                height: drawer.height / 5
                text:model.label
                showOutline:ListView.isCurrentItem
                onClicked: {
                    if (listView.currentIndex !== index) {
                        listView.currentIndex = index
                    }
                    drawer.close()
                }
            }
            function loadPane()
            {
                footer.label = currentItem.modelData.label
                stackView.replace(currentItem.modelData.url)
            }
        }
    }
    StackView{
        id:stackView
        anchors.fill: parent
        initialItem:Welcome{ }
    }


    footer: Footer{
        id:footer
        width:window.width
        height:window.height / 6
        nbPages: listView.count
        currentPage: listView.currentIndex
        label: qsTr("Open drawer and pick a topic...")
        onToggleDrawerVisibility: drawer.open()
        onPreviousPane: listView.decrementCurrentIndex()
        onNextPane: listView.incrementCurrentIndex()
    }

    SettingsDialog{
        id:settingsDialog
    }
    AboutDialog{
        id:aboutDialog
    }
}
