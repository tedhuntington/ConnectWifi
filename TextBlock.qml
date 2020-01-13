import QtQuick 2.0

Rectangle {
    width: 300; height: 60
    border.color: "lightblue"
    border.width: 2
    color: "#3776c9"

    //property of text
    property alias fontSize: textContent.font.pointSize
    property alias italic: textContent.font.italic
    property alias bold: textContent.font.bold
    property alias fontColor: textContent.color
    property alias text: textContent.text

    Text {
        id: textContent
        anchors.centerIn: parent
        font.pointSize: 24; fontSizeMode: Text.HorizontalFit
        font.family: "Helvetica LT Black"
        color: "white"
        text: "Range-of-Motion"
    }
}
