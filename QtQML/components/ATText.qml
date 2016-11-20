import QtQuick 2.0
import QtQuick.Controls 2.0
import ATeam.QtQMLExemple.AssetsSingleton 1.0

Label
{
    width: Assets.ui.defaultWidth
    height:Assets.ui.defaultHeight
    color: Assets.ui.textcolor
    font.pixelSize: Assets.ui.maximumPixelSize
    minimumPixelSize: Assets.ui.minimumPixelSize
    fontSizeMode : Text.Fit
    font.family: Assets.fonts.defaultFont.name
    horizontalAlignment: Qt.AlignHCenter
    verticalAlignment : Qt.AlignVCenter
}
