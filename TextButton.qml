import QtQuick 2.0

Item {
    id: root
    width: 280; height: 70
    property alias content: displayText.text
    property alias contentSize: displayText.font.pointSize
    property alias bgColor: rectangle.color

    signal clicked()

    //button shape
    Rectangle {
        id: rectangle
        border.color: "#222"
        border.width: 3
        color: "#2536f9"
        anchors.fill: parent
        radius: 7
    }

    Rectangle {
        id: coverRect
        border.color: "#00000000"
        border.width: 3
        color: "#33ffffff"
        anchors.fill: parent
        anchors.margins: 3
        radius: 5
        visible: mouseArea.pressed
    }

    //display text
    Text {
        id: displayText
        anchors.centerIn: parent
        font.pointSize: 20; fontSizeMode: Text.HorizontalFit
        font.family: "Helvetica LT Black"
        color: "white"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: root.clicked()
    }
}
