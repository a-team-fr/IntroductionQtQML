import QtQuick 2.5
import QtMultimedia 5.5
import QtSensors 5.3
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtPositioning 5.3
import QtLocation 5.5
import QtQuick.XmlListModel 2.0
import Qt.labs.settings 1.0

import ATeam.QtQMLExemple.AssetsSingleton 1.0
import "../components/"

Pane{
    background: Rectangle{
        color:"black"
    }

    ///////////////////////Error messages
    Text{
        id:mapErrorMessage
        visible:myMap.error !== Map.NoError
        text: myMap.errorString
        anchors.left: parent.left
        anchors.right:controlPanel.left
        anchors.top:controlPanelButton.bottom
        height:50
        color:"red"
    }
    Text{
        id:navErrorMessage
        visible:controlPanel.routeQuery.error !== RouteModel.NoError
        text: controlPanel.routeQuery.errorString ? controlPanel.routeQuery.errorString : ""
        anchors.left: parent.left
        anchors.right:controlPanel.left
        anchors.top:mapErrorMessage.bottom
        height:50
        color:"red"
    }


    ///////////////////////Map and plugin
    Plugin{
        id:mapbox
        name: "mapbox"
        PluginParameter{
            name:"mapbox.access_token"
            //value:controlPanel.accessToken
            value:"<PUT YOUR TOKEN HERE>"
            Component.onCompleted: console.log("accessToken:"+value)
        }
        PluginParameter{
            name:"mapbox.map_id"
            //value:controlPanel.mapId
            value:"<PUT YOUR TOKEN HERE>"
            Component.onCompleted: console.log("mapId:"+value)
        }

    }

    Map{
        id:myMap
        width:controlPanel.visible ? parent.width -controlPanel.width : parent.width
        height:parent.height
        plugin:mapbox
        center:QtPositioning.coordinate(47.212047, -1.551647)
        zoomLevel: myMap.maximumZoomLevel

        //dynamic items
        MapItemView{
            id:dynamicMapObject
            model: controlPanel.staticModel
            delegate: MapQuickItem {
                coordinate: QtPositioning.coordinate(Latitude,Longitude)
                sourceItem:  Text{
                    width:100
                    height:50
                    text:model.Label
                    rotation: model.Orientation
                    opacity: 0.6
                    color:model.Color
                }
            }

        }
        MapItemView{
            model: controlPanel.modelXml
            delegate: MapQuickItem {
                coordinate: QtPositioning.coordinate(model.latitude,model.longitude)
                sourceItem:  Image{ width:50;height:50;source:"qrc:/res/img/bike.png"

                }
            }

        }

        MapItemView{
            model: controlPanel.searchModel
            delegate: MapQuickItem {
                coordinate: model.place.location.coordinate
                sourceItem:  Image{ width:64;height:64;source:model.place.icon.url(Qt.size(64,64));
                    Text{
                        anchors.fill:parent
                        text:model.title
                    }

                }
            }

        }


        //Bunch of static items
        MapQuickItem {
            //a static item (fixed screen size) always at 50m west of the map center
            id:west50mScreenDimension
            coordinate: myMap.center.atDistanceAndAzimuth(50,270)
            sourceItem:  Rectangle{
                width:50; height:50; radius:25; color:"blue"; opacity:0.8
            }
        }
        MapCircle {
            //a static item (fixed real dimension) always at 100m east of the map center
            id:east100mFixedDimension
            center: myMap.center.atDistanceAndAzimuth(100,90)
            opacity:0.8
            color:"red"
            radius:10

        }


        MapQuickItem {
            id:geocodeResult
            coordinate: controlPanel.geocodeModel.count >  0 ? controlPanel.geocodeModel.get(0).coordinate : QtPositioning.coordinate()
            sourceItem:  Image{ width:50;height:50;source:"qrc:/res/img/poi.png" }

        }

    }

    /////////////////////Control panel///////////////////////
    ATButtonText {
        id:controlPanelButton
        height: 50
        width: 50
        anchors.left:parent.left
        anchors.top:parent.top
        fontFamily: Assets.fonts.awesome.name
        text:"\uf279" //fa-map
        onClicked: controlPanel.visible = !controlPanel.visible
    }
    GeolocControlPanel{
        id:controlPanel
        anchors.right:parent.right
        anchors.top:parent.top
        height:parent.height
        width: 0.6 * parent.width
        map:myMap

    }

}



