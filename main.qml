import QtQuick 2.0
import QtQuick.VirtualKeyboard 2.0
import "." as MyModule
import QtQuick.Controls 2.3


Item {
    id: root
    focus: true
    width: 500; height: 400

    signal pushStartRequest()
    signal escapeKeyExit()

    Keys.onPressed: {
        if (event.key === Qt.Key_Escape) {
            event.accepted = true;
            root.escapeKeyExit();
        }
    }


    Rectangle {
        id: scaleRect
        width: 800; height: 600
        color: "#0099ff"
        transform: Scale{
            id: layoutScale
        }


        //button
        TextButton {
            id: startBtn
            content: "Push to Connect WiFi"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 456
            width: 374
            height: 64
            anchors.horizontalCenterOffset: -5
            contentSize: 20
            onClicked:
            {
                root.pushStartRequest();
                if (canInterfaceReady) {
                    startBtn.visible = false
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

            ScrollView {
                id: scrollView
                x: 223
                y: 128
                width: 354
                height: 279
            }
        }
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
            x: 0
            y: 0
            width: 32
            height: 32
            onClicked: escapeKeyExit()
        }
    }

    TextBlock {
        x: 416
        width: 702
        height: 60
        text: "Connect to WiFi Network to run ePRO app"
        anchors.horizontalCenterOffset: 145
        anchors.top: parent.top
        anchors.topMargin: 53
        anchors.horizontalCenter: parent.horizontalCenter
        //anchors.left: settingRect.left
    }

}







