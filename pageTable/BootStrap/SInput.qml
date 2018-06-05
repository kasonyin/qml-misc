import QtQuick 2.8
import QtQuick.Controls 2.1
import "./"

/*!
   \qmltype SInput

   \brief SInput 是一个带圆角的基于 TextField 的文本输入框，相较于 Qt 自带的文本输入框，
          SInput 在右侧引入了一个快捷清除当前文本内容的按钮

   使用示例
   \qml
   import QtQuick 2.7

   Window {

        SInput {
            bottomPadding: 5;
            width: 200;
            height: 50
        }
   }
   \endqml
 */

TextField {
    id: control;

    property color fontColor: "#4C4C4C"
    property color fontColorMuted: "#B3B3B3"

    font.family: "微软雅黑";
    font.pixelSize: 20;
    font.weight: Font.Normal;
    color: enabled ? control.fontColor : control.fontColorMuted;
    selectByMouse: false;

    horizontalAlignment: Text.AlignLeft;
    verticalAlignment: Text.AlignVCenter;
    topPadding: undefined;
    bottomPadding: undefined;
    leftPadding: 8;
    rightPadding: 40;

    implicitWidth: 100;
    implicitHeight: control.font.pixelSize + 24

    background: Rectangle {
        id: bg;
        width: parent.width
        border.color: control.enabled ? "#757575" : control.fontColorMuted
        border.width: 1;
        color: "white";
        radius: 4;

        Text {
            anchors.right: parent.right;
            anchors.verticalCenter: parent.verticalCenter;
            visible: control.enabled && control.text;
            font.family: FontAwesome.fontFontAwesome.name;
            font.pointSize: control.font.pointSize * 1.2
            color: control.fontColorMuted;
            text: FontAwesome.fa_times;
            rightPadding: 8;
            MouseArea {
                anchors.fill: parent;
                onClicked: control.text = "";
            }
        }

        states: State {
            name: "active"
            when: control.activeFocus
            PropertyChanges {
                target: bg
                border.width: 2;
                border.color: "#212121";
            }
        }
        transitions: Transition {
            PropertyAnimation { duration: 200 }
            ColorAnimation { duration: 200 }
        }
    }
}
