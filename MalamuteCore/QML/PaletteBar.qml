import QtQuick 2.12
import QtQuick.Controls 2.12

ToolBar
{
    id: palleteBar
    height: 60
    background: Rectangle
    {
        anchors.fill: parent
        color: "#C19A6B";
        border.color: Qt.darker(color,1.3);
        border.width: 2
    }
    ComboBox
    {
        id: ideaCollectionComboBox
        editable: false
        width: 1
        height: 60

        model: malamuteHandler.collectionList

        font.bold: true
        font.pixelSize: 16
        background: Rectangle
        {
            anchors.fill: parent
            color: "#C19A6B"
            border.color: Qt.darker(color,1.3);
            border.width: 2
        }

        ToolTip.visible: hovered
        ToolTip.delay: 2000
        ToolTip.text: "Choose a new Idea Collection"
        Component.onCompleted:
        {
            malamuteHandler.setPalleteList(currentValue);
        }
    }

    ListView
    {
        id: palleteListView
        height: parent.height
        interactive: false
        clip: true
        anchors.left: ideaCollectionComboBox.right
        anchors.leftMargin: 2
        anchors.right: parent.right
        orientation: ListView.Horizontal
        model: malamuteHandler.paletteList
        spacing: 3
        delegate: PaletteItem
        {

        }
        ScrollBar.horizontal: ScrollBar
        {
            id: palleteScrollBar
        }
    }

    Button
    {
        id: videoL
        anchors.right: gregEmail.left
        anchors.rightMargin: 20
        width: 160
        height: 52
        anchors.verticalCenter: parent.verticalCenter
        text: "";
        onClicked:
        {
            Qt.openUrlExternally("https://youtu.be/SfVBMzW_4L4")
        }

        Text
        {
            anchors.centerIn:  parent
            text: "Open Instructional\nVideo on YouTube"
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 12
        }

    }

    Text
    {
        anchors.horizontalCenter: gregEmail.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -10
        text: "If you have questions, please contact"
        font.pointSize: 12
    }
    TextInput
    {
        id: gregEmail
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 10
        text: "Greg Mitchell at pgm6u@virginia.edu"
        font.pointSize: 12
        selectByMouse: true
        readOnly: true;
    }
}
