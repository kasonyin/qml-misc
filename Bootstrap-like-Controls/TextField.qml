import QtQuick 2.10
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0

/********************************************************************
 * @attention 使用 InnerShadow 可以在 left 和 top 打出两条渐变效果，
 * 比使用 Gradient 要更好一些。但是 InnerShadow 应该是更耗费资源一些
 * （个人猜测，在使用 QML Profile 分析的时候没有这方面的信息）
 * 因此请选择性使用 Gradient 或 InnerShadow 吧
 *******************************************************************/

/**
 */

TextField {
    id: control

    font.family: "微软雅黑"
    font.pixelSize: 14

    // 显示的字体颜色
    color: "#24292e"

    leftPadding: 10;
    rightPadding: 10;

    background: Item{
        implicitWidth: 257
        implicitHeight: 34

        // 选中时的外发光效果
        RectangularGlow {
            id: effect
            anchors.fill: rect
            glowRadius: 5
            spread: 0.65
            color: Qt.rgba(0.012, 0.4, 0.84, 0.3)
            cornerRadius: rect.radius + glowRadius
            visible: control.activeFocus
        }

        Rectangle {
            id: rect
            anchors.centerIn: parent
            width: parent.width
            height: parent.height
            radius: 3
            border.width: 1
            border.color: !control.enabled ? "#999999"
                                           : control.activeFocus ? "#2188ff"
                                                                 : "#d1d5da"
        }

        // 输入框内阴影
        InnerShadow {
            anchors.fill: rect
            radius: 6.0
            samples: 16
            spread: 0.2
            horizontalOffset: 2
            verticalOffset: 2
            color: Qt.rgba(0.106, 0.121, 0.137, 0.08)
            source: rect
        }
    }
}
