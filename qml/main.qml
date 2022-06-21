import QtQuick 6
import QtQuick.Window 
import QtQuick.Controls 6
import QtQuick.Controls.Material   

ApplicationWindow{
    id: window
    width: 600
    height: 700
    visible: true
    title: qsTr('AutoZoom')
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
            spacing:0

            Image {
                id: image
                width: 350 * .75
                height: 120 * .7
                source: '../images/AutoZoomLogo.png'
            }

            Label {
                id: aDayLabel
                text: 'A Days'
                font.weight: Font.DemiBold
                font.pointSize : 10
                anchors.left: parent.left
                anchors.leftMargin: 20
            }

            Repeater {
                id: aField
                model: 4
                NewField{
                    width: 450
                    height: 60
                }
            }

            Label {
                id: bDayLabel
                text: 'B Days'
                font.weight: Font.DemiBold
                font.pointSize : 10
                anchors.left: parent.left
                anchors.leftMargin: 20
            }

            Repeater {
                id: bField
                model: 4
                NewField{
                    width: 450
                    height: 60
                }
            }

            Label {
                id: timerLabel
                text: ' '
                font.weight: Font.DemiBold
                font.pointSize : 10
                anchors.left: parent.left
                anchors.leftMargin: 20

            }

            Row {
                spacing: 30
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 10
                Button{
                    id:saveButton
                    width:100
                    text: qsTr('Save')

                    //Button styling
                    onHoveredChanged: hovered ? saveButton.opacity = .9 : saveButton.opacity = 1
                    contentItem: Text {
                        text: saveButton.text
                        font.weight: Font.DemiBold
                        opacity: enabled ? 1.0 : 0.3
                        color: 'white'
                    }
                    background: Rectangle {
                        radius: 5
                        opacity: enabled ? 1 : 0.7
                        color: saveButton.down ? "#6eb1ff" : "#2d8cff"
                    }

                    //Updates periods based on field text input
                    onClicked: {
                        for (var i = 0; i < 4; i++) {
                            try{
                                var fieldItem = aField.itemAt(i)
                                backend.updatePeriods(i+1, fieldItem.meeting_time_text, fieldItem.meeting_duration_text, fieldItem.meeting_id_text, fieldItem.meeting_password_text) 
                                var fieldItem = bField.itemAt(i)
                                backend.updatePeriods(i+6, fieldItem.meeting_time_text, fieldItem.meeting_duration_text, fieldItem.meeting_id_text, fieldItem.meeting_password_text) 
                            }
                            catch (error) {
                                console.log(error)
                            }       
                        }                        
                    }
                    
                }

                Button{
                    id: getPeriodsButton
                    width: 100
                    text: qsTr('Load Saved')

                    //Button styling
                    onHoveredChanged: hovered ? getPeriodsButton.opacity = .9 : getPeriodsButton.opacity = 1
                    contentItem: Text {
                        text: getPeriodsButton.text
                        font.weight: Font.DemiBold
                        opacity: enabled ? 1.0 : 0.3
                        color: 'white'
                    }
                    background: Rectangle {
                        radius: 5
                        opacity: enabled ? 1 : 0.7
                        color: getPeriodsButton.down ? "#6eb1ff" : "#2d8cff"
                        
                    }

                    //Pulls information from autozoom.py when clicked
                    onClicked: backend.getPeriods()
                    
                }   
            
                Button{
                    id: helpButton
                    width: 100
                    text: qsTr('Help')
    

                    //Button Styling
                    onHoveredChanged: hovered ? helpButton.opacity = .9 : helpButton.opacity = 1
                    contentItem: Text {
                        text: helpButton.text
                        font.weight: Font.DemiBold
                        opacity: enabled ? 1.0 : 0.3
                        color: 'white'
                    }
                    background: Rectangle {
                        radius: 5
                        opacity: enabled ? 1 : 0.7
                        color: helpButton.down ? "#6eb1ff" : "#2d8cff"
                    }            
                    //Opens help page when clicked
                    onClicked: {
                        var component = Qt.createComponent("HelpPage.qml")
                        var window = component.createObject(HelpPage)
                        window.show()
                    }
                }
            }
           

            Connections {
                target: backend
                    //Receives signalGetPeriods from autozoom.py to update textfields 
                    function onSignalGetPeriods(a_days, b_days){  
                        for (var i = 0; i < 4; i++) {
                            try {
                                var day = a_days[i].split(', ')
                                aField.itemAt(i).meeting_time_text = day[0]
                                aField.itemAt(i).meeting_duration_text = day[1]
                                aField.itemAt(i).meeting_id_text = day[2]
                                aField.itemAt(i).meeting_password_text = day[3].trim()
                                var day = b_days[i].split(', ')
                                bField.itemAt(i).meeting_time_text = day[0]
                                bField.itemAt(i).meeting_duration_text = day[1]
                                bField.itemAt(i).meeting_id_text = day[2]
                                bField.itemAt(i).meeting_password_text = day[3].trim()
                            }
                            catch (error){
                            }
                        }
                    

                    }
                    //Receives signalTime from autozoom.py
                    //Updates timerLaber to reflect remaining time until next class
                    function onSignalTime(timer){
                        timerLabel.text = timer
                    }
            }
        }
    }
}
