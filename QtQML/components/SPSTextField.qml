import QtQuick 2.4

FocusScope {
    id:textField
    property alias text : embTextInput.text
    property alias placeholderText: placeholder.text
    property alias color : embTextInput.color
    property alias backgroundColor : embRect.color
    property alias echoMode : embTextInput.echoMode
    property alias validator : embTextInput.validator
    property alias horizontalAlignment : embTextInput.horizontalAlignment
    property alias verticalAlignment : embTextInput.verticalAlignment
    property alias radius : embRect.radius
    property alias border : embRect.border
    property alias imgSource : embImage.source
    property alias inputMethodHints : embTextInput.inputMethodHints
    //property alias activeFocus : embTextInput.activeFocus
    signal editingFinished
    signal accepted

    activeFocusOnTab: true

    Rectangle{
        id:embRect
        radius : 2//height * globals.ui.buttonRadiusPercHeight
        opacity: globals.ui.buttonBkOpacity
        height:parent.height
        width: parent.width
        color:globals.ui.textInputBackground
        border.color: embTextInput.activeFocus ? "#428bca" : "#999999"
        border.width: embTextInput.activeFocus ? 2 : 1
        /*gradient: Gradient {
            GradientStop {color: "white" ; position: 0}
            GradientStop {color: "lightgrey" ; position: 0.9}
            GradientStop {color: globals.ui.textInputBackground ; position: 1}
        }*/

        Image{
            id:embImage
            property real imgRatio : sourceSize ? sourceSize.height / sourceSize.width :1
            visible: source!=null
            height : parent.height * 0.3
            width : height * imgRatio
            anchors.verticalCenter: parent.verticalCenter
            anchors.margins: 0.5*parent.radius
            anchors.left: parent.left

            horizontalAlignment: Image.AlignHCenter
            verticalAlignment: Image.AlignVCenter
        }

        TextInput{
            id:embTextInput
            text: ""
            maximumLength: 25

            anchors.leftMargin: 0.5*parent.radius
            anchors.left: embImage.right
            anchors.right: embRect.right
            anchors.top: embRect.top
            anchors.bottom: embRect.bottom

            //anchors.centerIn: embRect
            verticalAlignment: TextInput.AlignVCenter
            horizontalAlignment: TextInput.AlignHCenter
            //height:parent.height
            //width: parent.width
            focus: true
            font.pixelSize: globals.ui.textM

            color: globals.ui.textEditColor
            onEditingFinished: textField.editingFinished();
            onAccepted: textField.accepted()
            selectionColor : Qt.darker( embRect.color)
            Text {
                id: placeholder
                text:"enter your text here"
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: parent.horizontalAlignment//Text.AlignHCenter
                //font.pixelSize: parent.font.pixelSize
                minimumPixelSize: globals.ui.minimumPixelSize
                fontSizeMode : Text.Fit
                visible: !(parent.text.length || embTextInput.inputMethodComposing)
                font: parent.font
                color: "#aaa"
            }

        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                embRect.forceActiveFocus()
                Qt.inputMethod.show()
            }
        }
        function forceActiveFocus()
        {
            embTextInput.forceActiveFocus()
            embTextInput.selectAll()
        }

    }



    onAccepted: {
        Qt.inputMethod.commit();
        Qt.inputMethod.hide();
    }
}

