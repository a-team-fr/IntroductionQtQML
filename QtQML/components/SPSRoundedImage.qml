import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    property alias source : imgBubble.source
    Rectangle{
        id:mask
        anchors.fill: parent
        color:"white"
        visible:false
        radius: width*0.5
    }
    Image{
        id:imgBubble
        anchors.fill: mask
        source:"qrc:/res/bubblevent.png"
        visible:false
    }
    OpacityMask {
        id:opMask
        anchors.fill: mask
        visible:true
        source: imgBubble
        maskSource: mask

    }
}

