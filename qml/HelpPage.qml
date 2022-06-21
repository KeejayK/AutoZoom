import QtQuick 
import QtQuick.Window 
import QtQuick.Controls 
import QtQuick.Controls.Material 

ApplicationWindow {
    id: help_page
    width: 500
    height: 650
    visible: true
    title: qsTr('AutoZoom Help')
    flags: Qt.WindowCloseButtonHint | Qt.WindowMinimizeButtonHint | Qt.CustomizeWindowHint | Qt.Dialog | Qt.WindowTitleHint
    
    Material.theme : Material.Light
    Material.accent : "#2d8cff"
    
    ScrollView {
        width: parent.width
        height: parent.height
        Column {
            id: column
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 10
            spacing:5
    
            Label {
                text: 'What is AutoZoom?'
                font.weight: Font.DemiBold
                font.pointSize: 10
            }

            Text {
                color: '#4d4d4d'
                width: 400
                wrapMode: Text.WordWrap
                text: 'AutoZoom is a tool for lazy students to automatically join Zoom classes'
            }

            Label {
                text: 'How do I use AutoZoom?'
                font.weight: Font.DemiBold
                font.pointSize: 10
            }

            Text {
                color: '#4d4d4d'
                text: `Simple! All you have to do is put in the following information:
        - Time the meeting starts 
        - Duration of the meeting in minutes (Optional)
        - Meeting ID 
        - Meeting Password
Example: `    
            }

            Image {
            id: image
            width: 618 * .65
            height: 67 * .65
            source: '../images/example.png'
            }

            Text {
                color: '#4d4d4d'
                text: `To start the program click "Save" and exit AutoZoom.
To access and change settings that you made earlier, click "Load Saved".
AutoZoom will open your zoom classes at your designated time. 
AutoZoom will also close zoom after a designated duration if you have set one.`
            }

            Label {
                text: 'Why isn\'t my time working?'
                font.weight: Font.DemiBold
                font.pointSize: 10
            }

            Text {
                color: '#4d4d4d'
                text: `Make sure you put in your time correctly!
Time is formatted based on the 24 hour system. 
Example: 4:00 pm = 16:00`
            }

            Label {
                text: 'What are A-Days and B-Days?'
                font.weight: Font.DemiBold
                font.pointSize: 10
            }
            Text {
                color: '#4d4d4d'
                text: `AutoZoom is organized into A-days and B-days to fit the MCPS schedule.
A-day classes run on Mondays/Thursdays
B-day classes run on Tuesdays/Fridays`
            }

            Label {
                text: 'Is AutoZoom resource intensive?'
                font.weight: Font.DemiBold
                font.pointSize: 10
            }

            Text {
                color: '#4d4d4d'
                text: `Nope! AutoZoom isn't as resource intensive as other applications like
chrome, spotify, or discord.`
            }

            
            Label {
                text: 'Who made this?'
                font.weight: Font.DemiBold
                font.pointSize: 10
            }

            Text {
                color:'#4d4d4d'
                text: `AutoZoom was created by Keejay Kim as a small project 
He got sick of having to open Zoom manually for each class😊
It was created using PyQt, schedule, and PyAutoGui`
                
            }
            Text {
                color:'#4d4d4d'
                text: 'Find my code on <a href="https://github.com/KeejayK">github</a>'
                onLinkActivated: Qt.openUrlExternally(link)
            }
        }
    }
}