import QtQuick 2.5

Item {
    id: control
    implicitWidth: 80
    implicitHeight: 40

    property real radius: 5
    property real margins: 5

    property color color: "white"
    property color borderColor: "transparent"
    property int   borderWidth: 2

    property bool leftTopRound: true
    property bool leftBottomRound: true
    property bool rightTopRound: true
    property bool rightBottomRound: true

    Canvas {
        id: warnCanvas
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d")

            var leftTopRadius = leftTopRound ? radius : 0
            var leftBottomRadius = leftBottomRound ? radius : 0
            var rightTopRadius = rightTopRound ? radius : 0
            var rightBottomRadius = rightBottomRound ? radius : 0

            // 移动到左边中间
            var px = margins
            var py = height / 2
            ctx.beginPath()
            ctx.moveTo(px, py)

            // 左下角
            ctx.arc(px + leftBottomRadius, height - margins - leftBottomRadius,
                    leftBottomRadius, Math.PI, Math.PI / 2, true)
            // 右下角
            ctx.arc(width - margins - rightBottomRadius, height - margins - rightBottomRadius,
                    rightBottomRadius, Math.PI / 2, 0, true)
            // 右上角
            ctx.arc(width - margins - rightTopRadius, margins + rightTopRadius,
                    rightTopRadius, 0, Math.PI * 3 / 2, true)
            // 左上角
            ctx.arc(margins + leftTopRadius, margins + leftTopRadius,
                    leftTopRadius, Math.PI * 3 / 2, Math.PI, true)

            ctx.closePath();
            ctx.lineWidth = borderWidth;
            ctx.lineCap = "round";
            ctx.strokeStyle = borderColor;
            ctx.lineJoin = "miter";
            ctx.stroke();
            ctx.fillStyle = color;
            ctx.fill();
        }
    }
}
