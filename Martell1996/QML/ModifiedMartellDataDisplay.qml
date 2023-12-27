import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

Rectangle
{
    width: 370
    height: 476
    color: "#cccccc"

    Rectangle
    {
        width: parent.width
        height: 3
        color: "black"
    }

    Row
    {
        x: 5
        y: 3
        height: 34
        Text
        {
            text: "Level"
            horizontalAlignment: Text.AlignHCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 70
        }
        Label
        {
            text: "Incumbent's\nScore"
            horizontalAlignment: Text.AlignHCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 100
            ToolTip.text: "Average(Standard Deviation)"
            ToolTip.visible: meanScoreMouseArea.containsMouse;
            MouseArea
            {
                id: meanScoreMouseArea
                anchors.fill: parent
                hoverEnabled: true;
            }
        }
        Text
        {
            text: "Number\nof Positions"
            horizontalAlignment: Text.AlignHCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 100
        }
        Text
        {
            text: "Percentage\nof Women";
            horizontalAlignment: Text.AlignHCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 100
            ToolTip.text: "Average(Standard Deviation)"
            ToolTip.visible: percentageWomenMouseArea.containsMouse;
            MouseArea
            {
                id: percentageWomenMouseArea
                anchors.fill: parent
                hoverEnabled: true;
            }
        }
    }

    Rectangle
    {
        y: 37
        width: parent.width
        height: 3
        color: "black"
    }

    ColumnLayout
    {
        y: 40
        width: 370
        height: 275
        ListView
        {
            id: levelListView;
            Layout.fillWidth: true
            Layout.fillHeight: true
            model: dataModel
            spacing: 5

            ScrollBar.vertical: ScrollBar
            {
                width: 8
                anchors.right: levelListView.left
                policy: ScrollBar.AlwaysOn
            }

            delegate: Rectangle
            {
                width: 370
                height: 30
                color: "#ececec"
                Row
                {
                    anchors.fill: parent
                    Text
                    {
                        text: model.level
                        horizontalAlignment: Text.AlignHCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 70
                    }
                    Text
                    {
                        text: model.meanScore.toFixed(2) + "(" + model.meanScoreError.toFixed(2) + ")"
                        horizontalAlignment: Text.AlignHCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 100
                        textFormat: Text.RichText;
                    }
                    Text
                    {
                        text: model.positions
                        horizontalAlignment: Text.AlignHCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 100
                    }

                    Text
                    {
                        text: model.percentWomen.toFixed(1) + "(" + model.percentWomenError.toFixed(1) + ")"
                        horizontalAlignment: Text.AlignHCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 100
                        textFormat: Text.RichText;
                    }
                }
            }
        }
    }

    Rectangle
    {
        y: 315
        width: parent.width
        color: "black"
        height: 10
    }

    Rectangle
    {
        y: 325
        height: 28
        color: "#ececec"
        width: parent.width
        Text
        {
            id: promotionCyclesText
            anchors.centerIn: parent;
            visible: idea.valid;
        }
        Connections
        {
            target: idea
            function onDisplayAveragePromotionCycles(cycles)
            {
                promotionCyclesText.text = "Average Promotion Cycles: " + cycles.toFixed(2);
            }
        }
    }

    Rectangle
    {
        y: 357
        height: 42
        color: "#ececec"
        width: parent.width
        Text
        {
            id: tboddsRatioText
            anchors.centerIn: parent;
            visible: idea.valid;
            horizontalAlignment: Text.AlignHCenter
            ToolTip.text: "Rejects excluded because division by 0 would result in infinity."
            ToolTip.visible: tboddsRatioMouseArea.containsMouse;
            MouseArea
            {
                id: tboddsRatioMouseArea
                anchors.fill: parent
                hoverEnabled: true;
            }
        }
        Connections
        {
            target: idea
            function onDisplayAveragetbOddsRatio(avg, rejects, low, high)
            {
                tboddsRatioText.text = "Average T/B Odds Ratio: " + avg.toFixed(3) + ", Rejects: " + rejects +
                        "\n95% CI: " + low.toFixed(3) + "-" + high.toFixed(3);
            }
        }
    }

    Rectangle
    {
        y: 403
        height: 42
        color: "#ececec"
        width: parent.width
        Text
        {
            id: wmoddsRatioText
            anchors.centerIn: parent;
            visible: idea.valid;
            horizontalAlignment: Text.AlignHCenter
            ToolTip.text: "Rejects excluded because division by 0 would result in infinity."
            ToolTip.visible: wmoddsRatioMouseArea.containsMouse;
            MouseArea
            {
                id: wmoddsRatioMouseArea
                anchors.fill: parent
                hoverEnabled: true;
            }
        }
        Connections
        {
            target: idea
            function onDisplayAveragewmOddsRatio(avg, rejects, low, high)
            {
                wmoddsRatioText.text = "Average W/M Odds Ratio: " + avg.toFixed(3) + ", Rejects: " + rejects +
                        "\n95% CI: " + low.toFixed(3) + "-" + high.toFixed(3);
            }
        }
    }

    Rectangle
    {
        y: 449
        height: 28
        color: "#ececec"
        width: parent.width
        Text
        {
            id: numberRunsText
            anchors.centerIn: parent;
            visible: idea.valid;
        }
        Connections
        {
            target: idea
            function onDisplayNumberRuns(runs)
            {
                numberRunsText.text = "Data from " + runs.toFixed(0) + " simulation runs.";
            }
        }
    }
}
