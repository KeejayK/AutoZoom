import QtQuick 
import QtQuick.Window 
import QtQuick.Controls 
import QtQuick.Controls.Material 


ApplicationWindow {
    id: splash
    color: "transparent"
    title: "AutoZoom Splash"
    modality: Qt.ApplicationModal
    flags: Qt.SplashScreen
    property int timeoutInterval: 100
    signal timeout
    x: (Screen.width - splashImage.width) / 2
    y: (Screen.height - splashImage.height) / 2
    width: splashImage.width
    height: splashImage.height

    Image {
        id: splashImage
        source: "../images/AutoZoomIcon.png"
        width: 200
        height: 200
    }
    Timer {
        interval: timeoutInterval; running: true; repeat: false
        onTriggered: {
            visible = false
            splash.timeout()
        }
    }
    Component.onCompleted: visible = true
}