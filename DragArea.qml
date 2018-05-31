import QtQuick 2.9

/**
    @qmltype    DragArea
    @brief      DragArea 主要为无边框窗体提供拖动支持
    @attention  使用的时候一定不能将 hoverEnabled 属性设置为 true 否则将带来不可预料的后果
    @todo       1.目前是在 onPositionChanged 事件里改变的窗体的坐标，还存在一点滞后感，有待优化。
                2.虽然也可以用来拖动其他的组件，但是并不建议这么用，因为效果不太好，滞后感严重。

    Example:

    @qml
    import QtQuick 2.7

    Window {
        id: root
        visible: true
        width: 640
        height: 480
        title: qsTr("DragArea Example")
        flags: Qt.FramelessWindowHint | Qt.WindowSystemMenuHint| Qt.WindowMinimizeButtonHint| Qt.Window

        DragArea {
            anchors.fill: parent;
            target: root;
        }

        Rectangle {
            color: "#F40"
            width: 100;
            height: 100;

            DragArea {
                anchors.fill: parent;
                target: parent;
            }
        }
    }
    @qmlend
*/

MouseArea {
    id: dragArea

    /**
     * 要拖动的对象，一般是窗体，必须设置，否则 DragArea 无法正常工作
     */
    property var target: null

    /********************* internal *********************/
    property point startPos: Qt.point(0,0);
    property point offsetPos: Qt.point(0,0);

    /**
     * 鼠标按下时记录鼠标的坐标
     */
    onPressed: startPos = Qt.point(mouseX , mouseY);

    /**
     * 鼠标位置改变时，将其坐标与鼠标按下时的坐标相减
     * 得到移动偏移量，将这个偏移量反馈到 target 上，就
     * 可以使 target 得到相同的运动。
     *
     * target 运动完成之后，鼠标的位置又变成了之前按下
     * 时保存的那个位置，因此不需要再手动改变了。
     *
     * 帮助手册里说只有当前按下某个按钮时才会发出此信号，
     * 但是实测时只有鼠标左键按下时才会发出这个信号，因此
     * 就没有做更多的处理了。
     */
    onPositionChanged: {
        offsetPos = Qt.point(mouseX - startPos.x,
                             mouseY - startPos.y);
        target.x += offsetPos.x;
        target.y += offsetPos.y;
    }
}
