import QtQuick 2.8
import QtQuick.Controls 2.1
import "./"

/*!
   \qmltype SButton

   \brief SButton 是一个带图标的 Button ，图标使用FontAwesome字体
          除此之外，它还有几种风格，不过因为这是个 BootStrap 风格的控件，
          与我们现在使用的 Material 风格相差很多，因此暂时先不建议使用

   使用示例
   \qml
   import QtQuick 2.7

   Window {
        Row{
            spacing: 20;
            SButton {
                style: "btn-naked";
                text: "菜单";
                icon: FontAwesome.fa_bars;
                font.pixelSize: 18;
                font.family: FontAwesome.fontOpenSans.name
            }

            SButton {
                style: "btn-naked";
                text: "返回";
                icon: FontAwesome.fa_chevron_left;
                font.pixelSize: 18;
                font.family: FontAwesome.fontOpenSans.name
            }

            SButton {
                style: "btn-warning";
                text: "警告";
                icon: FontAwesome.fa_warning;
                font.pixelSize: 18;
                font.family: FontAwesome.fontOpenSans.name
            }

            SButton {
                style: "btn-primary";
                text: "普通";
                icon: FontAwesome.fa_cloud;
                font.pixelSize: 18;
                font.family: FontAwesome.fontOpenSans.name
            }
        }
   }
   \endqml
 */

Button {
    id: control;

    property string icon_;
    property alias label: control.text
    property string style;

    property real nakedOpacity  : 1.0;
    property real hoveredOpacity: 1.0;
    property real pressedOpacity: 1.0;

    property color colorHovered: Qt.darker("transparent", 1.3);
    property color colorPressed: Qt.darker(colorHovered, 1.3);
    property color colorDisabled: "#B3B3B3";

    property color color: "transparent";
    property color fontColor: "transparent";
    property color borderColor: "transparent";
    property color textColorMuted: "transparent";

    function parseStyle(){ return style.split(" "); }

    implicitWidth: contentItem.implicitWidth + 24;
    implicitHeight: control.font.pixelSize + 24;

    topPadding: 8;
    bottomPadding: 8;
    leftPadding: 12;
    rightPadding: 12;

    contentItem: SIcon {
        id: contentIcon;
        icon: control.icon_;
        label: control.text;
        fontColor: control.fontColor;
        fontSize: control.font.pixelSize;
    }

    background: Rectangle {
        color: {
            if(!enabled)
                return control.colorDisabled;

            if(control.pressed)
                return control.colorPressed;

            if(control.hovered)
                return control.colorHovered;

            return control.color;
        }
        border.color: enabled ? control.borderColor : control.colorDisabled;
        border.width: 1;
        radius: 4;
        opacity: {
            if(control.pressed)
                return control.pressedOpacity;

            if(control.hovered)
                return control.hoveredOpacity;

            return control.nakedOpacity;
        }
    }

    onStyleChanged: {
        var items = parseStyle();
        for(var i = 0; i < items.length; ++i) {
            if(items[i] === "btn-primary") {
                control.color = Qt.binding(function() { return Qt.darker("#1D7DC5", 1 + 6.5/100) });
                control.fontColor = "#fff";
                control.borderColor = Qt.binding(function() { return Qt.darker(control.color, 1 + 5/100) });
                control.textColorMuted = "#fff";
                control.colorHovered = Qt.binding(function() { return Qt.darker(control.color, 1.1) });
            }else if(items[i] === "btn-warning") {
                control.color = "#f0ad4e";
                control.fontColor = "#fff";
                control.borderColor = Qt.binding(function() { return Qt.darker(control.color, 1 + 5/100) });
                control.textColorMuted = "#fff";
                control.colorHovered = Qt.binding(function() { return Qt.darker(control.color, 1.1) });
            }else if(items[i] === "btn-naked") {
                control.pressedOpacity = 0.25;
                control.hoveredOpacity = 0.1;
                control.nakedOpacity = 0.0;
                control.color = "#000";
                control.fontColor = Qt.binding(function() { return Qt.lighter("#333", 1 + 50/100) });
                control.borderColor = control.color;
                control.textColorMuted = control.fontColor;
                control.colorHovered = control.color;
            } else if (items[i] === "btn-custom") {
                control.color = Qt.binding(function() { return Qt.darker("#DDD", 1 + 6.5/100) });
                control.fontColor = Qt.binding(function() { return Qt.lighter("#333", 1 + 50/100) });
                control.borderColor = Qt.binding(function() { return Qt.darker(control.color, 1 + 5/100) });
                control.textColorMuted = "#fff";
                control.colorHovered = Qt.binding(function() { return Qt.darker(control.color, 1.1) });
            }
        }
    }
}
