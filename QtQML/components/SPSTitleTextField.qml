import QtQuick 2.4

FocusScope {
    id:textField
    property alias text : embTextInput.text
    property alias title: title.text
    property alias placeholderText: placeholder.text
    property alias color : embTextInput.color
    property alias backgroundColor : embRect.color
    property alias echoMode : embTextInput.echoMode
    property alias validator : embTextInput.validator
    property alias horizontalAlignment : embTextInput.horizontalAlignment
    property alias verticalAlignment : embTextInput.verticalAlignment
    signal editingFinished
    signal accepted

    activeFocusOnTab: true

    SPSText {
        id: title
        anchors { left: parent.left; top: parent.top }
        horizontalAlignment: Text.AlignLeft
        height: parent.height * 0.3
        width: parent.width * 0.7
        color: "white"
    }
    Rectangle{
        id:embRect
        radius : 0.5 * height//height * globals.ui.buttonRadiusPercHeight
        opacity: 1//globals.ui.buttonBkOpacity
        height:parent.height * 0.7
        anchors { left: parent.left; right: parent.right; bottom: parent.bottom; leftMargin: 5 }
        //width: parent.width
        color:globals.ui.textInputBackground
        border.color: embTextInput.activeFocus ? "#428bca" : "#999999"
        border.width: embTextInput.activeFocus ? 2 : 1
        /*gradient: Gradient {
            GradientStop {color: "white" ; position: 0}
            GradientStop {color: "lightgrey" ; position: 0.9}
            GradientStop {color: globals.ui.textInputBackground ; position: 1}
        }*/



        TextInput{
            id:embTextInput
            text: ""
            //anchors.fill: embRect
            //anchors.centerIn: embRect
            verticalAlignment: TextInput.AlignVCenter
            horizontalAlignment: TextInput.AlignHCenter
            height:parent.height
            width: parent.width
            focus: true

            font.pixelSize: Math.min(width * 0.1, height*0.45)//6 * globals.ui.sizeFactor //globals.ui.textM
            color: globals.ui.textEditColor
            onEditingFinished: textField.editingFinished();
            onAccepted: textField.accepted()

            Text {
                id: placeholder
                text:"enter your text here"
                anchors.fill: parent
                verticalAlignment: TextInput.AlignVCenter
                horizontalAlignment: TextInput.AlignHCenter
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



