import QtQuick 2.0
import QtSensors 5.3
import QtQuick.Controls 2.0
import ATeam.QtQMLExemple.AssetsSingleton 1.0
import "../../components/"
Pane {

    Flickable{
        width:parent.width
        height:parent.height
        contentHeight: column.implicitHeight
        contentWidth: parent.width

        Column {
            id: column
            anchors.fill: parent
            anchors.margins: 7

            ATText {
                height:30
                width:parent.width

                AmbientTemperatureSensor{
                    active:true
                    onReadingChanged: parent.text = "température ambiante :" + reading.temperature +"°C"
                }

            }

            ATText {
                height:30
                width:parent.width

                Magnetometer{
                    active:true
                    onReadingChanged: parent.text = "Magneto x :"+ reading.x +"- y :"+reading.y+"- z :"+reading.z
                }
            }

            ATText {
                text: "Orientation : unknown"
                height:30
                width:parent.width

                OrientationSensor{
                    active:true
                    onReadingChanged: {
                        if (reading.orientation == OrientationReading.Undefined)
                            parent.text = qsTr("Orientation: Unknown");
                        else if (reading.orientation == OrientationReading.TopUp)
                            parent.text = qsTr("Orientation: Coté haut en haut");
                        else if (reading.orientation == OrientationReading.TopDown)
                            parent.text = qsTr("Orientation: Coté haut en bas");
                        else if (reading.orientation == OrientationReading.LeftUp)
                            parent.text = qsTr("Orientation: Coté gauche en haut");
                        else if (reading.orientation == OrientationReading.RightUp)
                            parent.text = qsTr("Orientation: Coté droit en haut");
                        else if (reading.orientation == OrientationReading.FaceUp)
                            parent.text = qsTr("Orientation: Face en haut");
                        else if (reading.orientation == OrientationReading.FaceDown)
                            parent.text = qsTr("Orientation: Face en bas");
                    }
                }

            }
            ATText {
                height:30
                width:parent.width

                Gyroscope{
                    active:true
                    onReadingChanged: parent.text = "Gyro x :"+reading.x+"- y :"+reading.y+"- z :"+reading.z
                }
            }
            ATText {
                height:30
                width:parent.width
                RotationSensor{
                    active:true
                    onReadingChanged: parent.text = "Rotation x :"+reading.x+"- y :"+reading.y+"- z :"+reading.z
                }
            }

            ATText {
                height:30
                width:parent.width
                AmbientLightSensor {
                    active: true

                    onReadingChanged: {
                        if (reading.lightLevel === AmbientLightReading.Unknown)
                            parent.text = qsTr("Ambient light: Unknown");
                        else if (reading.lightLevel === AmbientLightReading.Dark)
                            parent.text = qsTr("Ambient light: Dark");
                        else if (reading.lightLevel === AmbientLightReading.Twilight)
                            parent.text = qsTr("Ambient light: Twilight");
                        else if (reading.lightLevel === AmbientLightReading.Light)
                            parent.text = qsTr("Ambient light: Light");
                        else if (reading.lightLevel === AmbientLightReading.Bright)
                            parent.text = qsTr("Ambient light: Bright");
                        else if (reading.lightLevel === AmbientLightReading.Sunny)
                            parent.text = qsTr("Ambient light: Sunny");
                    }
                }
            }
            ATText {
                height:30
                width:parent.width

                LightSensor {
                    active: true
                    onReadingChanged: parent.text = "Luminosité : " + reading.illuminance
                }
            }
            ATText {
                height:30
                width:parent.width
                ProximitySensor {
                    active: true
                    onReadingChanged: parent.text = "Proximity: " + reading.near ? "Near" : "Far"
                }
            }

        }
    }


}

