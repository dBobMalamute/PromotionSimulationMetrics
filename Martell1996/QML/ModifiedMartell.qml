import QtQuick 2.12
import QtQuick.Shapes 1.12
import QtQuick.Controls 2.12
import com.martell1996.extras 1.0

Rectangle
{
    width: 734
    height: 460
    color: "black"

    Text
    {
        y: 105
        x: 5
        id: cohensDText
        font.pointSize: 10
        color: "lightGray"
    }

    Connections
    {
        target: idea

        function onSetupPieChart(numSections, sweeps, colors)
        {
            //This is a weird way of handling this. Look for a better way.
            section1.fillColor = "transparent";
            section2.fillColor = "transparent";
            section3.fillColor = "transparent";
            section4.fillColor = "transparent";
            section5.fillColor = "transparent";
            section6.fillColor = "transparent";

            if(numSections >= 1)
            {
                section1.fillColor = colors[0];
                section1.sweepAngle = sweeps[0];
            }
            if(numSections >= 2)
            {
                section2.fillColor = colors[1];
                section2.startAngle = sweeps[0];
                section2.sweepAngle = sweeps[1] - sweeps[0];
            }
            if(numSections >= 3)
            {
                section3.fillColor = colors[2];
                section3.startAngle = sweeps[1];
                section3.sweepAngle = sweeps[2] - sweeps[1];
            }
            if(numSections >= 4)
            {
                section4.fillColor = colors[3];
                section4.startAngle = sweeps[2];
                section4.sweepAngle = sweeps[3] - sweeps[2];
            }
            if(numSections >= 5)
            {
                section5.fillColor = colors[4];
                section5.startAngle = sweeps[3];
                section5.sweepAngle = sweeps[4] - sweeps[3];
            }
            if(numSections >= 6)
            {
                section6.fillColor = colors[5];
                section6.startAngle = sweeps[4];
                section6.sweepAngle = sweeps[5] - sweeps[4];
            }
        }

        function onSetupNameRectangles(numRects, names, colors)
        {
            let i; let comp; let obj;
            for(i = 0; i < nameRectangleArea.children.length; i++)
                nameRectangleArea.children[i].destroy();

            for(i = 0; i < numRects; i++)
            {
                comp = Qt.createComponent("ModifiedMartellPieChartKey.qml")
                obj = comp.createObject(nameRectangleArea, {
                                            groupColor: colors[i],
                                            groupName: names[i],
                                            y: 2 + 18*i});
            }
        }

        function onShowCohensD(d)
        {
            cohensDText.text = "Cohens D: " + d.toPrecision(4)
        }
        function onHideCohensD()
        {
            cohensDText.text = "";
        }

        function onShowTBOddsRatio(num)
        {
            tboddsRatioRect.visible = true;
            tboddsRatioText.text = num.toPrecision(4);
        }
        function onHideTBOddsRatio()
        {
            tboddsRatioRect.visible = false;
        }

        function onShowWMOddsRatio(num)
        {
            wmoddsRatioRect.visible = true;
            wmoddsRatioText.text = num.toPrecision(4);
        }
        function onHideWMOddsRatio()
        {
            wmoddsRatioRect.visible = false;
        }

    }

    Rectangle
    {
        id: tboddsRatioRect
        color: "darkGray"
        width: 130
        height: 44
        radius: 4
        y: 6
        x: 420
        visible: true;

        Text
        {
            anchors.horizontalCenter: parent.horizontalCenter
            y: 3
            text: "T/B Odds Ratio"
            horizontalAlignment: Text.AlignHCenter
            font.bold: true
            font.pointSize: 12
            color: "black"
            ToolTip.text: "Odds women in top level vs bottom level"
            ToolTip.visible: tboddsRatioMouseArea.containsMouse;
        }
        Text
        {
            id: tboddsRatioText
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 3
            text: "1.00"
            font.bold: true
            font.pointSize: 12
            color: "black"
            ToolTip.text: "Odds women in top level vs bottom level"
            ToolTip.visible: tboddsRatioMouseArea.containsMouse;
        }
        MouseArea
        {
            id: tboddsRatioMouseArea
            anchors.fill: parent
            hoverEnabled: true;
        }
    }

    Rectangle
    {
        id: wmoddsRatioRect
        color: "darkGray"
        width: 130
        height: 44
        radius: 4
        y: 56
        x: 420
        visible: true;

        Text
        {
            anchors.horizontalCenter: parent.horizontalCenter
            y: 3
            text: "W/M Odds Ratio"
            horizontalAlignment: Text.AlignHCenter
            font.bold: true
            font.pointSize: 12
            color: "black"
            ToolTip.text: "Odds women vs men\nin top two levels"
            ToolTip.visible: wmoddsRatioMouseArea.containsMouse;
        }
        Text
        {
            id: wmoddsRatioText
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 3
            text: "1.00"
            font.bold: true
            font.pointSize: 12
            color: "black"
            ToolTip.text: "Odds women vs men\nin top two levels"
            ToolTip.visible: wmoddsRatioMouseArea.containsMouse;
        }
        MouseArea
        {
            id: wmoddsRatioMouseArea
            anchors.fill: parent
            hoverEnabled: true;
        }
    }
    Rectangle
    {
        id: originalsRect
        color: "darkGray"
        width: 100
        height: 44
        radius: 4
        y: 106
        x: 450
        visible: true;

        Text
        {
            anchors.horizontalCenter: parent.horizontalCenter
            y: 3
            text: "Originals"
            horizontalAlignment: Text.AlignHCenter
            font.bold: true
            font.pointSize: 12
            color: "black"
            ToolTip.text: "Original Employees"
            ToolTip.visible: originalsMouseArea.containsMouse;
        }
        Text
        {
            id: originalsText
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 3
            text: idea.originals
            font.bold: true
            font.pointSize: 12
            color: "black"
            ToolTip.text: "Original Employees"
            ToolTip.visible: originalsMouseArea.containsMouse;
        }
        MouseArea
        {
            id: originalsMouseArea
            anchors.fill: parent
            hoverEnabled: true;
        }
    }
    Rectangle
    {
        id: cyclesRect
        color: "darkGray"
        width: 70
        height: 44
        radius: 4
        y: 156
        x: 480
        visible: true;

        Text
        {
            anchors.horizontalCenter: parent.horizontalCenter
            y: 3
            text: "Cycles"
            horizontalAlignment: Text.AlignHCenter
            font.bold: true
            font.pointSize: 12
            color: "black"
        }
        Text
        {
            id: cyclesText
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 3
            text: idea.promotionCycles
            font.bold: true
            font.pointSize: 12
            color: "black"
        }
    }

    Shape
    {
        id: pieChartShape
        width: 400
        height: 400
        x: -148
        y: -148
        scale: 0.25
        layer.enabled: true
        layer.samples: 12

        ModifiedMartellPieChartPath
        {
            id: section1
            fillColor: "transparent";
            sweepAngle: 120.0;
        }
        ModifiedMartellPieChartPath
        {
            id: section2
            fillColor: "transparent";
            startAngle: 120.0;
            sweepAngle: 120.0;
        }
        ModifiedMartellPieChartPath
        {
            id: section3
            fillColor: "transparent";
            startAngle: 120.0;
            sweepAngle: 120.0;
        }
        ModifiedMartellPieChartPath
        {
            id: section4
            fillColor: "transparent";
            startAngle: 120.0;
            sweepAngle: 120.0;
        }
        ModifiedMartellPieChartPath
        {
            id: section5
            fillColor: "transparent";
            startAngle: 120.0;
            sweepAngle: 120.0;
        }
        ModifiedMartellPieChartPath
        {
            id: section6
            fillColor: "transparent";
            startAngle: 120.0;
            sweepAngle: 120.0;
        }
    }

    Item
    {
        id: nameRectangleArea
        x: 105
        y: 0
        width: 100
        height: 100
    }

    Item
    {
        id: dotsAreaSizer
        width: 560;
        height: 410
        z: 10
        Component.onCompleted:
        {
            idea.setupPersonDotsArea(dotsAreaSizer);
        }
    }

    Column
    {
        width: 540
        height: 360
        x: 10
        y: 50
        spacing: 2

        Repeater
        {
            id: levelsRepeater
            anchors.fill: parent
            model: idea.numLevels
            delegate: Rectangle
            {
                id: rectDelegate
                anchors.horizontalCenter: parent.horizontalCenter
                width: 180 + 360.0 * index / idea.numLevels
                height: (360 / idea.numLevels) - 2
                color: "#3e3124"
            }
        }
    }

    Rectangle
    {
        radius: 4
        color: "darkGray"
        y: 6
        width: 80
        height: 38
        x: 560
        Text
        {
            anchors.centerIn: parent
            text: "Score"
            font.bold: true
            font.pointSize: 12
            color: "black"
        }
    }

    Column
    {
        width: 80
        height: 360
        x: 560
        y: 50
        spacing: 2
        Repeater
        {
            id: avgScoreRepeater
            anchors.fill: parent
            model: 0
            delegate: Rectangle
            {
                width: 80
                height: (360 / idea.numLevels) - 2
                color: "lightgray"
                Text
                {
                    anchors.centerIn: parent
                    text: idea.meanScore[index].toPrecision(4);
                    font.pointSize: Math.min(10, parent.height - 2)
                    color: "black"
                }
            }
        }
        Connections
        {
            target: idea
            function onMeanScoreChanged(meanScore)
            {
                avgScoreRepeater.model = idea.numLevels;
            }
        }
    }

    Rectangle
    {
        radius: 4
        color: "darkGray"
        y: 6
        width: 80
        height: 38
        x: 650
        Text
        {
            anchors.centerIn: parent
            text: "%Women"
            font.bold: true
            font.pointSize: 12
            color: "black"
        }
    }

    Column
    {
        width: 80
        height: 360
        x: 650
        y: 50
        spacing: 2
        Repeater
        {
            id: percentWomenRepeater
            anchors.fill: parent
            model: 0
            delegate: Rectangle
            {
                width: 80
                height: (360 / idea.numLevels) - 2
                color: "lightgray"
                Text
                {
                    anchors.centerIn: parent
                    text: idea.percentWomen[index].toPrecision(4);
                    font.pointSize: Math.min(10, parent.height - 2)
                    color: "black"
                }
            }

        }
        Connections
        {
            target: idea
            function onPercentWomenChanged(percentWomen)
            {
                percentWomenRepeater.model = idea.numLevels;
            }
        }
    }

    Rectangle
    {
        id: singleRunControls
        anchors.bottom: parent.bottom
        color: "grey"
        height: 45
        width: parent.width
        Row
        {
            anchors.fill: parent
            spacing: 10
            anchors.leftMargin: 10

            Button
            {
                enabled: idea.valid
                anchors.verticalCenter: parent.verticalCenter
                text: "Step";
                ToolTip.text: "Next simulation Step. Either Attrition, Promotion, or New Hires."
                ToolTip.delay: 1000
                ToolTip.timeout: 3000
                ToolTip.visible: hovered
                onClicked:
                {
                    idea.animationStepButtonClicked();
                }

            }

            Button
            {
                enabled: idea.valid
                anchors.verticalCenter: parent.verticalCenter
                text: "Cycle";
                onClicked:
                {
                    idea.normalStepButtonClicked();
                }
                ToolTip.text: "Run a full Attrition Promotion New Hiring Cycle."
                ToolTip.delay: 1000
                ToolTip.timeout: 3000
                ToolTip.visible: hovered
                hoverEnabled: true;
            }

            Button
            {
                enabled: idea.valid
                anchors.verticalCenter: parent.verticalCenter
                text: "Complete";
                onClicked:
                {
                    idea.normalFinishButtonClicked();
                }
                ToolTip.text: "Run to finish. For Martell this is when there are no more original employees."
                ToolTip.delay: 1000
                ToolTip.timeout: 3000
                ToolTip.visible: hovered
                hoverEnabled: true;
            }

            Button
            {
                enabled: idea.valid
                anchors.verticalCenter: parent.verticalCenter
                text: "Reset";
                onClicked:
                {
                    idea.normalResetButtonClicked();
                }
            }

            Rectangle
            {
                color: "black"
                width: 4
                height: parent.height;
            }
            Item
            {
                width: runsText.width + 50
                height: parent.height;
                Text
                {
                    id: runsText;
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 16
                    text: "Runs: ";
                }
                TextInput
                {
                    id: runsTextInput;
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 16
                    font.underline: true;
                    validator: IntValidator{bottom: 1; top: 9999}
                    selectByMouse: true;
                    onEditingFinished:
                    {
                        idea.setBulkRunNum(text)
                    }
                    Component.onCompleted:
                    {
                        text = idea.bulkRunNum
                    }
                }
            }

            Button
            {
                enabled: idea.valid
                anchors.verticalCenter: parent.verticalCenter
                text: "Bulk Run";
                hoverEnabled: true
                onClicked:
                {
                    idea.bulkRun();
                }
                onHoveredChanged:
                {
                    mayBeSlowRect.visible = hovered;
                }

                Rectangle
                {
                    id: mayBeSlowRect
                    color: "black"
                    border.width: 2
                    border.color: "grey"
                    visible: false;
                    radius: 5
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: 40
                    width: mayBeSlowText.width + 10
                    height: mayBeSlowText.height + 10
                    Text
                    {
                        id: mayBeSlowText;
                        text: "May take several minutes\non some machines."
                        horizontalAlignment: Text.AlignHCenter
                        color: "darkred"
                        font.pointSize: 14
                        anchors.centerIn: parent
                    }
                }
            }

            Rectangle
            {
                color: "black"
                width: 4
                height: parent.height;
            }
        }
    }
}
