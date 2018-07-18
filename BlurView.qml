import QtQuick 2.5
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Item {
    width: 100;
    height: 300;
    Flickable {
        id: content
        width: 100; height: 300
        anchors.centerIn: parent
        contentWidth: 100; contentHeight: 1000
        clip: true

        Column {
            Repeater {
                model: 10
                Image {
                    id: background
                    source: "qt-logo.png"
                }
            }
        }
    }

    Item {
        id: pop
        width: 100
        height: 50
        anchors.bottom: content.bottom
        anchors.left: content.left

        ShaderEffectSource {
            id: theSource
            sourceItem: content
            sourceRect: Qt.rect(0, 250, 100, 50)
        }

        GaussianBlur {
            anchors.fill: parent
            source: theSource
            radius: 8
            samples: 16
            deviation: 3.7
        }

        Rectangle {
            anchors.fill: parent
            color: "#aaFFFFFF"
            border.width: 1
            border.color: "black"
        }
    }
}
