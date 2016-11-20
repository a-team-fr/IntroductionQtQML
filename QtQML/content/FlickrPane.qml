import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.0
import QtQuick.Dialogs 1.2
import ATeam.QtQMLExemple.AssetsSingleton 1.0
import QtQuick.XmlListModel 2.0

Pane {

    XmlListModel{
       id:flickerModel
       source: "http://api.flickr.com/services/feeds/photos_public.gne?format=rss2&tags=" + myTextEdit.text
       query: "/rss/channel/item"
       namespaceDeclarations: "declare namespace media=\"http://search.yahoo.com/mrss/\";"
       XmlRole { name:"title"; query: "title/string()"}
       XmlRole { name:"url"; query: "media:thumbnail/@url/string()"}
    }

    Column{
        anchors.fill: parent
        spacing : 10
        TextField{
            id:myTextEdit
            width : parent.width
            height : 50
            text:"travel"
            Layout.minimumHeight: 10
            Layout.preferredHeight: 50
            Layout.maximumHeight: 100


        }
        GridView{
           id:lstImages
           height: parent.height - myTextEdit.height
           width: parent.width
           property int nbImage: 3
           cellHeight: height / nbImage
           cellWidth: cellHeight
           delegate:myDelegate
           model: flickerModel
           clip: true
        }
    }

    Component{
        id:myDelegate
        Item{
            height: lstImages.cellHeight
            width: lstImages.cellHeight

            Image{
                id:highQuality
                height: lstImages.cellHeight
                width: lstImages.cellHeight
                source: image.status == Image.Loading ? "" : url.toString().replace("_s","_b")
                visible : status == Image.Ready
            }
            Image{
                id:image
                source: url
                height: lstImages.cellHeight
                width: lstImages.cellHeight
                visible: highQuality.status == Image.Loading
                Label{
                    id:info
                    text:title + " - Loading:" + Math.ceil(highQuality.progress *100) + "%"
                }
            }
        }
    }

}
