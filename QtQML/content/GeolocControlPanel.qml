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

Rectangle{

    id:root
    //color:Assets.ui.menuBackground
    property string accessToken : ""
    property string mapId : ""

    property var map : undefined
    property alias routeQuery : route
    property alias staticModel: dummyModel
    property alias modelXml : bikeModelXml
    property alias searchModel : psm
    property alias geocodeModel : geocode

    Settings {
        property alias accessToken : root.accessToken
        property alias mapId : root.mapId
    }


    Flickable{

        anchors.fill: parent
        contentHeight: controls.childrenRect.height
        Flow{
            anchors.fill: parent
            id:controls
            property int rowHeight : 50
            GroupBox{
                title:qsTr("Mapbox token id")
                TextField {
                    id:field1
                    text:root.accessToken
                    placeholderText: qsTr("Enter your token id here")
                    onEditingFinished: root.accessToken = text
                }
            }
            GroupBox{
                title:qsTr("Mapbox map id")
                TextField {
                    id:field2
                    text:root.mapId
                    placeholderText: qsTr("Enter your map id here")
                    onEditingFinished: root.mapId = text
                }
            }

            GroupBox{
                title:qsTr("Device location (GPS)")
                CheckBox{
                    id:useDeviceLocation
                    text:qsTr("Use device location")
                }
            }
            GroupBox{
                title:qsTr("map types")
                ComboBox{
                    model:root.map.supportedMapTypes
                    textRole:"description"
                    onCurrentIndexChanged: root.map.activeMapType = root.map.supportedMapTypes[currentIndex]
                }
            }
            GroupBox{
                title:qsTr("Zoom control")
                Slider{
                    value:root.map.maximumZoomLevel
                    from: root.map.minimumZoomLevel
                    to: root.map.maximumZoomLevel
                    onValueChanged: root.map.zoomLevel=value

                }
            }


            GroupBox{
                title:qsTr("center coordinate")
                Row{

                    TextField{
                        text:root.map.center.latitude.toFixed(6)
                        onEditingFinished: root.map.center.latitude = text
                    }
                    TextField{
                        text:root.map.center.longitude.toFixed(6)
                        onEditingFinished: root.map.center.longitude = text
                    }
                    Button{
                        text:qsTr("Go near to Bike stations"); onClicked: root.map.center = QtPositioning.coordinate("38.9","-77.0")
                    }
                }

            }
            GroupBox{
                title:qsTr("Add a new item")
                Row{

                    TextField{ id:newItemName;text:"new item label";}
                    TextField{ id:newItemColor;text:"red";}
                    TextField{ id:newItemOrientation;text:"90";}
                    Button{
                        text:qsTr("Add new item")
                        onClicked: {
                            dummyModel.append({
                                                  "Latitude": root.map.center.latitude,"Longitude":root.map.center.longitude,"Label":newItemName.text , "Color":newItemColor.text, "Orientation":Number(newItemOrientation.text), })
                        }
                    }
                    Button{
                        text:qsTr("Clear")
                        onClicked: {
                            dummyModel.clear();
                        }
                    }
                }

            }

            GroupBox{
                title:qsTr("Search POI")
                Row{

                    TextField{ id:searchFieldName;text:qsTr("restaurant");}
                    TextField{ id:searchFieldRadius;text:"5000";}
                    TextField{ readOnly: true; text:psm.count}
                    Button{ text:qsTr("update"); onClicked: psm.update()}
                }

            }
            GroupBox{
                title:qsTr("adress lookup")
                Row{

                    TextField{ id:searchAddress;text:"11 rue juton, 44000 Nantes";}
                    Button{ text:qsTr("update"); onClicked: {
                            geocode.query =  searchAddress.text
                            geocode.update()
                        }}
                }

            }

            GroupBox{
                title:qsTr("Route")
                Row{
                    Button{ text:qsTr("add map center as waypoint"); onClicked: {
                            route.addWaypoint(root.map.center);
                            routeModel.update();
                        }}
                    Button{ text:qsTr("reset"); onClicked: {
                            route.clearWaypoints();
                            routeModel.update();
                        }}
                }

            }

        }
    }

    PositionSource{
        id:myPos
        updateInterval: 1000
        active:true
        preferredPositioningMethods: PositionSource.AllPositioningMethods
    }

    XmlListModel
    {
        id: bikeModelXml
        source: "https://www.capitalbikeshare.com/data/stations/bikeStations.xml"
        query: "/stations/station"
        XmlRole { name: "latitude"; query: "lat/string()"; isKey: true }
        XmlRole { name: "longitude"; query: "long/string()"; isKey: true }
    }


    PlaceSearchModel {
        id: psm
        plugin: mapbox
        searchTerm: searchFieldName.text
        searchArea: QtPositioning.circle(root.map.center, Number(searchFieldRadius.text));
        Component.onCompleted: update()
        limit:100

    }

    Location{
        id:myLocation
        coordinate {  latitude: 47.212047; longitude: -1.551647}
    }


    GeocodeModel{
        id:geocode
        plugin:mapbox
        autoUpdate:false

    }

    ListModel{
        id:dummyModel
        ListElement {
            Latitude: 47.212047
            Longitude: -1.551647
            Label: "something"
            Orientation: 0
            Color:"green"

        }
        ListElement {
            Latitude: 47.3
            Longitude: -1.581647
            Label: "something else"
            Orientation: 90
            Color:"darkgreen"
        }

    }
    RouteQuery{
        id:route
        travelModes:RouteQuery.CarTravel
        routeOptimizations : RouteQuery.FastestRoute
    }

    RouteModel {
        id: routeModel
        plugin:mapbox
        query: route
        onQueryChanged: Console.log(count)
        autoUpdate: false

    }

    ListView {
        id: listview
        anchors.fill: parent

        spacing: 10
        model: routeModel.status == RouteModel.Ready ? routeModel.get(0).segments : null
        visible: model ? true : false
        delegate: Rectangle{
            width: parent.width
            height:50
            color:"lightgrey"
            Row {
                anchors.fill: parent
                spacing: 10
                property bool hasManeuver : modelData.maneuver && modelData.maneuver.valid
                visible: hasManeuver
                Text { text: (1 + index) + "." }
                Text { text: hasManeuver ? modelData.maneuver.instructionText : "" }
            }
        }
    }

}
