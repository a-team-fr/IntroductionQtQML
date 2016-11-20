import QtQuick 2.0
import QtQuick.Controls 2.0
import ATeam.QtQMLExemple.AssetsSingleton 1.0
import "../../components/"
Pane {
    AHRS{
        id:ahrs
    }

    Flickable{
        width:parent.width
        height:parent.height
        contentHeight: column.implicitHeight
        contentWidth: parent.width

        Flow {
            id: column
            anchors.fill: parent
            anchors.margins: 7
            EADI{
                roll: ahrs.roll
                pitch: ahrs.pitch
                heading: ahrs.heading
            }

            MovingBall{
                roll: ahrs.roll
                pitch: ahrs.pitch
            }
        }
    }

}

