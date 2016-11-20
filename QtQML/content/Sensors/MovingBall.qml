import QtQuick 2.0

Rectangle {
    width:300
    height:300

    property real pitch: 0
    property real roll:0
    property real inertiaFactor : 0.1

    property alias ballRadius : ball.radius
    property alias ballColor: ball.color

    onRollChanged: {
        ball.x += roll*inertiaFactor
        ball.x = Math.max(0, ball.x);
        ball.x = Math.min(width - 2*ballRadius, ball.x)
    }
    onPitchChanged: {
        ball.y -= pitch*inertiaFactor
        ball.y = Math.max(0, ball.y);
        ball.y = Math.min(height - 2*ballRadius, ball.y)
    }

    color:"lightgrey"
    border.color: "black"
    border.width: 3

    Rectangle {
        id: ball
        color: "blue"
        width: 2 * radius
        height : 2 * radius
        radius: 15
        smooth: true
        x: parent.width / 2 - radius
        y: parent.height / 2 - radius


    }
}
