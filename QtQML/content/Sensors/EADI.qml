import QtQuick 2.3

Item {
    id:root
    property real roll : 0
    property real pitch : 0
    property real heading : 0

    width:300
    height:300

    property real maxPitch : 90
    function limit(val, min, max){
        return Math.min(Math.max(min, val),max)
    }

    Rectangle{
        id:sky
        color:"blue"
        anchors.fill : parent
        anchors.margins: 10
        clip:true
        Rectangle{
            id:ground
            height: sky.height*0.5 + root.limit(root.pitch, -root.maxPitch, root.maxPitch) * sky.height / (2 * root.maxPitch)
            rotation: root.roll
            width:sky.width *1.5
            color: "red"
            anchors.horizontalCenter : parent.horizontalCenter
            anchors.bottom : parent.bottom

        }
    }



    Image{
        source: "qrc:/res/img/eadi_cache.png"
        anchors.fill:parent
    }
    Image{
        id:ring
        rotation: heading
        source: "qrc:/res/img/eadi_couronne.png"
        anchors.fill:parent
    }


    Column {
        id: column
        anchors.fill: parent

        Text {
            id:  pitchTxt
            text: "Pitch : " + root.pitch.toLocaleString() + "°"
            font.pointSize: 10
            color: "white"
        }
        Text {
            id:  rollTxt
            text: "Roll : " + root.roll.toLocaleString() + "°"
            font.pointSize: 10
            color: "white"
        }
        Text {
            id:  yawTxt
            text: "heading : " + root.heading.toLocaleString() + "°"
            font.pointSize: 10
            color: "white"
        }
    }


}
