import QtQuick 2.0
import QtQuick.VirtualKeyboard 2.0
import "." as MyModule
import QtQuick.Controls 2.3


Item {
    id: root
    focus: true
    width: 1200; height: 1000

    property var ssidList: []


    signal pushStartRequest()
    signal escapeKeyExit()

    Keys.onPressed: {
        if (event.key === Qt.Key_Escape) {
            event.accepted = true;
            root.escapeKeyExit();
        }
    }

    function addRecord(ssid)
    {
        ssidList.push(ssid)
        //SSIDList.model.append({})
        // signal change in data model to trigger UI update (list view)
        root.ssidListChanged()
    }


    Rectangle {
        id: scaleRect
        width: 1200
        height: 1000
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


        //button
        TextButton {
            id: connectBtn
            content: "Push to Connect WiFi"
            anchors.top: parent.bottom
            anchors.topMargin: -100
            width: 374
            height: 64
            anchors.horizontalCenter: parent.horizontalCenter
            contentSize: 20
            onClicked:
            {
                root.pushStartRequest();
                if (canInterfaceReady) {
                    connectBtn.visible = false
                    splashImg.visible = false;
                    statusImg.visible = true;
                    animaTimer.running = true
                }
            }
        }

        MouseArea {
            x: 2
            y: 7
            anchors.topMargin: 0
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.fill: parent
            anchors.bottomMargin: 0
        }

        MouseArea {
            x: 9
            y: -6
            anchors.topMargin: 0
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.fill: parent
            anchors.bottomMargin: 0
        }

        ScrollView {
            id: scrollView
            x: 480
            width: 354
            height: 279
            anchors.top: parent.top
            anchors.topMargin: 180
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
        }
        // list view
        ListView {
          id: listView
          anchors.top: parent.top
          anchors.topMargin: 180
          width: 430
          height: 500
          anchors.horizontalCenter: parent.horizontalCenter
          highlight: Rectangle {
              color: "white"
              //z: .5
          }
          highlightFollowsCurrentItem: true
          model: root.ssidList
          delegate: ItemDelegate {
              text: ssidList[index]
              //text: "Item " + index + ssidList[index]
              Component.onCompleted: background.color = 'white'
          }
        }
    }

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

    Text {
        id: txtEscape
        width: 32
        height: 32
        color: "#ffffff"
        text: qsTr("X")
        horizontalAlignment: Text.AlignHCenter
        font.bold: true
        font.pixelSize: 26
        MouseArea {
            width: 32
            height: 32
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            onClicked: escapeKeyExit()
        }
    }


}














































/*##^## Designer {
    D{i:6;anchors_y:113;invisible:true}D{i:1;anchors_height:1000;anchors_width:1200}D{i:11;anchors_x:0;anchors_y:0}
}
 ##^##*/
