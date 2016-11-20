import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.0
import QtQuick.Dialogs 1.2
import ATeam.QtQMLExemple.AssetsSingleton 1.0

Popup {
    id: settingsPopup
    x: (window.width - width) / 2
    y: window.height / 6
    width: Math.min(window.width, window.height) / 3 * 2
    height: settingsColumn.implicitHeight + topPadding + bottomPadding
    modal: true
    focus: true

    property string style : ""

    contentItem: ColumnLayout {
        id: settingsColumn
        spacing: 20

        Label {
            text: "Settings"
            font.bold: true
        }

        RowLayout {
            spacing: 10

            Label {
                text: "Style:"
            }

            ComboBox {
                id: styleBox
                property int styleIndex: -1
                model: ["Default", "Material", "Universal"]
                Component.onCompleted: {
                    styleIndex = find(settingsPopup.style, Qt.MatchFixedString)
                    if (styleIndex !== -1)
                        currentIndex = styleIndex
                }
                Layout.fillWidth: true
            }
        }

        RowLayout {
            spacing: 10
            Label {
                text: "background color"
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
            Button {
                id: backcolorPickerButton
                text: "pick color"
                onClicked: {
                    colorDialog.open()
                }
                background: Rectangle {
                              implicitWidth: 100
                              implicitHeight: 40
                              color: backcolorPickerButton.down ? Qt.darker(Assets.ui.menuBackground) : Assets.ui.menuBackground
                              border.color: "black"
                              border.width: 1
                              radius: 4
                          }

                Material.foreground: Material.primary
                Material.background: "transparent"
                Material.elevation: 0

                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }

        Label {
            text: "Restart required"
            color: "#e41e25"
            opacity: styleBox.currentIndex !== styleBox.styleIndex ? 1.0 : 0.0
            horizontalAlignment: Label.AlignHCenter
            verticalAlignment: Label.AlignVCenter
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        RowLayout {
            spacing: 10

            Button {
                id: okButton
                text: "Ok"
                onClicked: {
                    settingsPopup.style = styleBox.displayText
                    settingsPopup.close()
                }

                Material.foreground: Material.primary
                Material.background: "transparent"
                Material.elevation: 0

                Layout.preferredWidth: 0
                Layout.fillWidth: true
            }

            Button {
                id: cancelButton
                text: "Cancel"
                onClicked: {
                    styleBox.currentIndex = styleBox.styleIndex
                    settingsPopup.close()
                }

                Material.background: "transparent"
                Material.elevation: 0

                Layout.preferredWidth: 0
                Layout.fillWidth: true
            }
        }
    }

    ColorDialog{
        id:colorDialog
        title:""
        width: parent.width * 0.8
        height: parent.height * 0.8

        onAccepted: Assets.ui.menuBackground = color

    }


}
