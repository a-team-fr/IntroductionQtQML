import QtQuick 2.0
import QtSensors 5.3

Item {
    id:ahrs
    property bool active : !demo

    property real pitch : demo ? demoAngle : accel.degPitch;
    property real roll : demo ? demoAngle : accel.degRoll;
    property real heading : demo ? demoAngle : magneto.degHeading;

    property bool demo : false
    property real demoAngle: 0
    SequentialAnimation on demoAngle {
        loops: Animation.Infinite
        running: demo
        NumberAnimation {
            from: -45
            to: 45
            duration: 3000
        }
        NumberAnimation {
            from: 45
            to: -45
            duration: 3000
        }
    }


    Accelerometer {
        id: accel
        active:ahrs.active

        property real degPitch:0
        property real degRoll:0
        property real rad2deg : 180.0 / Math.PI
        onReadingChanged: {
            var v = orient.vec3ChangeAxis(reading.x, reading.y, reading.z);

            //Compute roll
            if (v.y == 0) degRoll = 90;
            else degRoll = Math.atan( v.x / v.y) * rad2deg;

            //Compute pitch
            if (v.y == 0) degPitch = 90;
            else degPitch = Math.atan( v.z / v.y) * rad2deg;
        }
    }

    Magnetometer{
        id:magneto
        active:ahrs.active

        property real degHeading:0
        property real rad2deg : 180.0 / Math.PI
        onReadingChanged: {
            var v = orient.vec3ChangeAxis(reading.x, reading.y, reading.z);
            if (v.y >0)
                degHeading = 90 - (Math.atan2(v.x,v.y)) * rad2deg;
            else if (v.y<0)
                degHeading = 270 - (Math.atan2(v.x,v.y)) * rad2deg;
            else if (v.x < 0)
                degHeading = 180.0;
            else
                degHeading = 0.0;
        }
    }

    OrientationSensor{
        id:orient
        active:ahrs.active

        function vec3ChangeAxis(x,y,z){
            var vec3Ret={x:0,y:0,z:0};

            switch (reading.orientation)
            {
                 case OrientationReading.TopDown:
                     vec3Ret.x = -x;
                     vec3Ret.y = -y;
                     vec3Ret.z = z;
                     break;
                 case OrientationReading.LeftUp:
                     vec3Ret.x = -y;
                     vec3Ret.y = x;
                     vec3Ret.z = z;
                     break;
                 case OrientationReading.RightUp:
                     vec3Ret.x = y;
                     vec3Ret.y = -x;
                     vec3Ret.z = z;
                     break;
                 case OrientationReading.FaceUp:
                     vec3Ret.x = x;
                     vec3Ret.y = -z;
                     vec3Ret.z = y;
                     break;
                 case OrientationReading.FaceDown:
                     vec3Ret.x = -x;
                     vec3Ret.y = -z;
                     vec3Ret.z = -y;
                     break;
                 case OrientationReading.Undefined:
                 case OrientationReading.TopUp:
                     vec3Ret.x = x;
                     vec3Ret.y = y;
                     vec3Ret.z = z;
                     break;
                 default:
                     break;
            }
            return vec3Ret;

        }
    }

}
