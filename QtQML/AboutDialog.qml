import QtQuick 2.0
import QtQuick.Controls 2.0


Popup {
    id: aboutDialog
    modal: true
    focus: true
    x: (window.width - width) / 2
    y: window.height / 6
    width: Math.min(window.width, window.height) / 3 * 2
    contentHeight: aboutColumn.height

    Column {
        id: aboutColumn
        spacing: 20

        Label {
            text: "About"
            font.bold: true
        }

        Label {
            width: aboutDialog.availableWidth
            text: qsTr("This sample application purpose is to demonstrate how to use QML for mobile.")
            wrapMode: Label.Wrap
            font.pixelSize: 12
        }

        Label {
            width: aboutDialog.availableWidth
            text: qsTr("Some features :"
                +"<ul>"
                +"<li>Using QtQuick Controls 2"
                +"<li>Using Camera"
                +"<li>and more.."
                +"</ul>")
            wrapMode: Label.Wrap
            font.pixelSize: 12
        }
    }
}
