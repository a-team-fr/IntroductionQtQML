import QtQuick 2.0

Item {
    id:root
    property alias groupTitleText : groupTitle.text
    property alias selected : lstView.currentIndex
    property var listModel : ListModel{
        ListElement{ label:"dummy element to demonstrate"}
    }
    property variant currentData : lstView.currentItem.currentData


    Column{
        id:content
        anchors.fill : parent
        spacing : 5
        property int nbRow : root.listModel.count
        property int rowHeight : (height-10 - spacing * nbRow) / (nbRow + 1)
        SPSText{
            id:groupTitle
            width : parent.width
            height : parent.rowHeight
            text : ""
            horizontalAlignment: Text.AlignLeft
        }
        ListView{
            id:lstView
            model:root.listModel
            width : parent.width
            height : 1.05 * content.rowHeight * parent.nbRow
            spacing : content.spacing
            delegate:SPSCheckbox{
                width : content.width * 0.8
                height : content.rowHeight
                checked : index== root.selected
                text : model.label


            }
        }
    }

}

