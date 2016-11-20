import QtQuick 2.0
import QtQuick.Controls 2.0
import ATeam.QtQMLExemple.AssetsSingleton 1.0

Item {
    id:root
    property var lstImage : null
    property alias selection : imgSelector.currentIndex
    property int contentRotation : 0

    signal changed(int index, int value)
    Image{
        id:selectedImage
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        source:imgSelector.currentItem.source
        rotation: root.contentRotation

        MouseArea{
            anchors.fill : parent
            onClicked:{
                imgSelector.visible = !imgSelector.visible
            }
        }
    }


    ListView{
        id:imgSelector

        height : parent.height * lstImage.count
        width : parent.width
        anchors.top : selectedImage.bottom
        visible : false
        model: lstImage
        spacing: 5
        delegate: Image{
            width : root.width
            height: root.height
            source: imgPath
            rotation: root.contentRotation
            fillMode: Image.PreserveAspectFit
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    imgSelector.visible=false
                    imgSelector.currentIndex = index
                    root.changed(index,value);
                }
            }
        }
    }
}

