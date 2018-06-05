import QtQuick 2.6
import "./"

/*!
   \qmltype SIcon

   \brief SInput 是一个带文本的图标控件，图标使用 FontAwesome 字体图标

   使用示例
   \qml
   import QtQuick 2.7

   Window {

        Column {
            spacing: 20;
            Row {
                spacing: 20;

                SIcon {
                    icon: FontAwesome.fa_location_arrow;
                    pulse: true;
                    label: "低速步进"
                    animationPeriod: 5000;
                }

                SIcon {
                    icon: FontAwesome.fa_safari;
                    spin: true;
                    label: "低速旋转"
                    animationPeriod: 5000;
                }

                SIcon {
                    icon: FontAwesome.fa_chevron_left;
                    label: "普通"
                }

                SIcon {
                    icon: FontAwesome.fa_cloud_download;
                }
            }

            Row {
                spacing: 20;

                SIcon {
                    icon: FontAwesome.fa_spinner;
                    pulse: true;
                    label: "中速步进"
                }

                SIcon {
                    icon: FontAwesome.fa_refresh;
                    spin: true;
                    label: "中速旋转"
                }
            }

            Row {
                spacing: 20

                SIcon {
                    icon: FontAwesome.fa_circle_o_notch;
                    pulse: true;
                    label: "高速步进"
                    animationPeriod: 1000;
                }

                SIcon {
                    icon: FontAwesome.fa_cog;
                    spin: true;
                    label: "高速旋转"
                    animationPeriod: 1000;
                }
            }
        }
    }
   \endqml
 */

Item {
    id: control

    /*
     * icon 使用 FontAwesome 字体图标，详情可以参照使用示例
     */
    property alias icon: icon.text;
    property alias label: label.text;
    property int fontSize: 18;
    property alias color: icon.color
    /*
     * spin（旋转） 和 pulse（步进） 这两个属性不能同时设置为 true
     * 否则动画效果会很怪异
     */
    property bool spin: false
    property bool pulse: false;

    /*
     * 步进或者旋转一圈所需要的时间（ms），可通过调整此时间来调整
     * 步进或旋转的速度
     */
    property int animationPeriod: 2000;

    /*
     * 每圈步进步数，此属性应和图标对应着使用
     */
    property int pulseSteps: 8;

    property color fontColor: "#4C4C4C"
    property color fontColorMuted: "#B3B3B3"

    implicitWidth: icon.implicitWidth + (label.implicitWidth) + row.spacing;
    implicitHeight: Math.max(icon.implicitHeight, label.implicitHeight);

    onPulseChanged: {
        if ( false === pulse) {
            icon.rotation = 0;
        }
    }

    Row {
        id: row;
        anchors.centerIn: parent;
        spacing: 3;

        Text {
            id: icon;
            anchors.verticalCenter: parent.verticalCenter;
            text: control.icon;
            font.family: "fontAwesome";
            font.pointSize: control.fontSize*1.2;
            font.weight: Font.Normal;
            color: enabled ? control.fontColor : control.fontColorMuted;

            RotationAnimation on rotation {
                loops: Animation.Infinite;
                paused: !control.spin;
                from: 0;
                to: 360;
                duration: animationPeriod;
            }

            Timer {
                id: pulseTimer
                running: control.pulse;
                repeat: true;
                interval: control.animationPeriod/control.pulseSteps
                onTriggered: icon.rotation += 360/control.pulseSteps
            }
        }

        Text {
            id: label
            anchors.verticalCenter: parent.verticalCenter;
            text: control.label;
            font.family: "微软雅黑"//FontAwesome.fontOpenSans.name
            font.pointSize: control.fontSize
            font.weight: Font.Normal;
            color: icon.color
        }
    }
}
