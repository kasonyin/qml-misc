import QtQuick 2.5
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0

// TODO 在改变了边框的颜色之后，再回到初始状态时，会在边角留下一些痕迹
// 目前还不知道是为什么产生的，不过影响不是很大，基本看不清了

TextField {
    id: control

    // 这里的圆角要比正常的 Rectangle 的 radius 大 1 个像素，
    // 因此设置的时候需要比想要的圆角小 1 个像素
    property real radius: 2

    // margins 必须要设置一个大于 1 的数，否则边框会看不到，这是
    // 因为 canvas 在画线时有线宽，设置为 1 时，实际量的宽高和设置的一致
    property real margins: 1

    // borderWidth 必须要设置一个大于 2 的数，否则边框的颜色会和实际设置的不一样
    property real  borderWidth: 2

    property color borderColor;

    property color backgroundColor: "white"

    property bool leftTopRound: true
    property bool leftBottomRound: true
    property bool rightTopRound: true
    property bool rightBottomRound: true

    borderColor: !control.enabled ? "#999999"
                                   : control.activeFocus ? "#2188ff"
                                                         : "#d1d5da"
    font { pixelSize: 14; family: "微软雅黑"}
    color: "#24292e"
    leftPadding: 10;
    rightPadding: 10;

    onBorderColorChanged: {
        rectCanvas.requestPaint()
    }

    background: Item {
        implicitWidth: 257
        implicitHeight: 34
        Glow {
            radius: 5
            spread: 0.9
            samples: 11
            color: Qt.rgba(0.012, 0.4, 0.84, 0.3)
            anchors.fill: rectCanvas
            source: rectCanvas
            smooth: true
            visible: control.activeFocus
        }
        Canvas {
            id: rectCanvas
            anchors.fill: parent
            visible: !control.activeFocus;
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
                ctx.strokeStyle = borderColor;
                ctx.stroke();
                ctx.fillStyle = backgroundColor;
                ctx.fill();
            }
        }
        InnerShadow {
            anchors.fill: rectCanvas
            radius: 6.0
            samples: 16
            spread: 0.2
            horizontalOffset: 2
            verticalOffset: 2
            color: Qt.rgba(0.106, 0.121, 0.137, 0.08)
            source: rectCanvas
        }
    }
}
