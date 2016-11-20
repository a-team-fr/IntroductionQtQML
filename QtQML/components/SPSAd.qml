import QtQuick 2.0

Item {
    property alias title: title.text
    property alias content: content.text
    property alias icon: icon.source

    anchors.margins: width * 0.05

    Image {
        id: icon
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.1
        height: parent.height * 0.4
        width: height
    }

    Text {
        id: title
        anchors.left: icon.right
        anchors.verticalCenter: icon.verticalCenter
        anchors.leftMargin: parent.width * 0.05
        font.pixelSize: Math.min(parent.width * 0.1, parent.height * 0.15)
    }

    Text {
        id: content
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: icon.bottom
        font.pixelSize: title.font.pixelSize * 0.8

        wrapMode: Text.WordWrap
    }
}
