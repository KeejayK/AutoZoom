import QtQuick 
import QtQuick.Window 
import QtQuick.Controls 
import QtQuick.Controls.Material 

Item{
    id: new_field
    property alias meeting_time_text: meeting_time_field.text
    property alias meeting_duration_text: meeting_duration_field.text
    property alias meeting_id_text: meeting_id_field.text
    property alias meeting_password_text: meeting_password_field.text
    
    
    TextField{
        id: meeting_time_field
        width: 70
        text:qsTr('')
        selectByMouse: true
        placeholderText: qsTr('Start Time')
        verticalAlignment : Text.AlignVCenter
        anchors.left: parent.left
        anchors.leftMargin: 20
        
    }
    TextField{
        id: meeting_duration_field
        width: 70
        text:qsTr('')
        selectByMouse: true
        placeholderText: qsTr('Duration')
        verticalAlignment : Text.AlignVCenter
        anchors.left: meeting_time_field.right
        anchors.leftMargin: 25
    }
    TextField{
        id: meeting_id_field
        width: 150
        text:qsTr('')
        selectByMouse: true
        placeholderText: qsTr('Meeting ID')
        verticalAlignment : Text.AlignVCenter
        anchors.left: meeting_duration_field.right
        anchors.leftMargin: 25
    }
    TextField{
        id: meeting_password_field
        width: 120
        text:qsTr('')
        selectByMouse: true
        placeholderText: qsTr('Meeting Password')
        verticalAlignment : Text.AlignVCenter
        anchors.left: meeting_id_field.right
        anchors.leftMargin: 25
    }
    
}