import QtQuick 2.0
import QtQuick.VirtualKeyboard 2.0
import "." as MyModule
import QtQuick.Controls 2.3


Item {
    id: root
    focus: true
    width: 800; height: 800

    property var ssidList: []
    property var ssid
    property var password

    signal escapeKeyExit()
    signal connectWiFiButton()

    Keys.onPressed: {
        if (event.key === Qt.Key_Escape) {
            event.accepted = true;
            root.escapeKeyExit();
        }
    }

    function addRecord(ssid)
    {
        //var newssid =  '<style="font-size:20pt;">' + ssid + '</style>'
        //var newssid =  '<b>' + ssid + '</b>'
        var newssid =  ssid
        ssidList.push(newssid)
        //ssidList.push(ssid)
        //SSIDList.model.append({})
        // signal change in data model to trigger UI update (list view)
        root.ssidListChanged()
    }

    function clearRecord()
    {
        ssidList= []
    }


    Rectangle {
        id: scaleRect
        width: 800
        height: 800
        color: "#0099ff"
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        transform: Scale{
            id: layoutScale
        }
    } //Rectangle


    Rectangle {
        id: listviewRect
        width: 400
        height: 300//100
        color: "#ffffff"
        border.width: 2
        anchors.top: parent.top
        anchors.topMargin: 150
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter


        ScrollView {
            id: scrollView
            width: 400
            height: 300
            font.bold: true
            font.pointSize: 14//100
            anchors.top: parent.top
            anchors.topMargin: 0//180
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.horizontalCenter: parent.horizontalCenter

            // list view
            ListView {
                id: listView
                anchors.top: parent.top
                anchors.topMargin: 0//180
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width
                height: parent.height
                scale: 1
                flickableDirection: Flickable.VerticalFlick
                boundsBehavior: Flickable.StopAtBounds
                highlight: Rectangle {
                    color: "blue"
                    //z: .5
                }
                highlightFollowsCurrentItem: true
                model: root.ssidList
                clip: true
                delegate: ItemDelegate {
                    text: ssidList[index]
                    //text: "Item " + index + ssidList[index]
                    //Component.onCompleted: background.color = 'white'
                    MouseArea {
                        z: 1
                        hoverEnabled: false
                        anchors.fill: parent
                        anchors.bottomMargin: 0
                        onClicked: {
                            listView.currentIndex = index
                            textInput_SSID.text = ssidList[index]
                            //root.ssid=ssidList[index]
                        }
                    } //MouseArea

                }
                //Layout.fillWidth: true
                //Layout.fillHeight: true

                ScrollBar.vertical: ScrollBar {}

            } //ListView
        } //ScrollView
    }  //Rectangle


    TextBlock {
        x: 416
        width: 702
        height: 60
        text: "Select WiFi Network to run ePRO app"
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 53
        //anchors.left: settingRect.left
    }


    Rectangle {
        id: rectangle_SSID
        x: 198
        y: 488
        width: 366
        height: 60
        color: "#ffffff"
        border.width: 1
        anchors.horizontalCenter: parent.horizontalCenter
    }

    TextInput {
        id: textInput_SSID
        x: 188
        z: 1
        width: 366
        height: 60
        clip: true
        //text: qsTr("")
        font.weight: Font.Bold
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 14
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: listviewRect.bottom
        anchors.topMargin: 38
        onTextChanged: {
            root.ssid=textInput_SSID.text
        }

    }

    TextInput {
        id: textInput_password
        x: 188
        y: -8
        z: 1
        width: 366
        height: 60
        echoMode: TextInput.Password
        passwordCharacter: "*"
        clip: true
        //text: qsTr("")
        font.weight: Font.Bold
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 14
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: textInput_SSID.bottom
        anchors.topMargin: 20
        onTextChanged: {
            root.password=textInput_password.text
        }
    }

    Rectangle {
        id: rectangle_password
        x: 188
        y: -8
        width: 366
        height: 60
        color: "#ffffff"
        border.width: 1
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: textInput_SSID.bottom
        anchors.topMargin: 20
    }

    Label {
        id: label_Password
        x: 119
        y: 587
        color: "#ffffff"
        text: qsTr("Password:")
        anchors.right: textInput_password.left
        anchors.rightMargin: 11
        styleColor: "#ffffff"
        font.pointSize: 14
    }

    Label {
        id: label_Access_Point
        x: 39
        y: 507
        color: "#ffffff"
        text: qsTr("Access Point (SSID):")
        anchors.right: rectangle_SSID.left
        anchors.rightMargin: 11
        styleColor: "#ffffff"
        font.pointSize: 14
    }

    Image {
        id: imageEye
        y: 568
        width: 60
        height: 60
        clip: false
        anchors.left: textInput_password.right
        anchors.leftMargin: 4
        z: 1
        source: "images/eye.png"
        fillMode: Image.PreserveAspectFit
        MouseArea {
            z: 2
            hoverEnabled: false
            anchors.fill: parent
            anchors.bottomMargin: 0
            onClicked: {
                if (textInput_password.echoMode === TextInput.Password) {
                    textInput_password.echoMode= TextInput.Normal
                } else {
                    textInput_password.echoMode= TextInput.Password
                }
            }
        } //MouseArea
    }

    //button
    TextButton {
        id: connectBtn
        content: "Push to Connect WiFi"
        anchors.top: textInput_password.bottom
        anchors.topMargin: 72
        width: 374
        height: 64
        anchors.horizontalCenter: parent.horizontalCenter
        contentSize: 20
        onClicked:
        {
            root.connectWiFiButton();
        }
    }


}  //Item






































































































/*##^## Designer {
    D{i:1;anchors_height:1000;anchors_width:1200}D{i:9;anchors_x:0;anchors_y:0}D{i:10;anchors_x:0;anchors_y:0}
D{i:4;anchors_y:113}D{i:13;anchors_y:488}D{i:14;anchors_y:488}D{i:15;anchors_y:"-8"}
D{i:18;anchors_x:583}
}
 ##^##*/
