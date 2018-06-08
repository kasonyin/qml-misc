import QtQuick 2.9
import QtQuick.Controls 1.4 as QQC14
import QtGraphicalEffects 1.0
import QtQuick.Window 2.2
import Misc 1.0
import "./BootStrap"

Window {
    visible: true
    width: 1024
    height: 768
    title: qsTr("Hello World")
    flags: Qt.FramelessWindowHint | Qt.Window | Qt.WindowSystemMenuHint | Qt.WindowMinimizeButtonHint

    PageModelTest {
        id: pageModel
        tableName: "test";
        resultCurrent: 10;
    }

    Item {
        anchors.fill: parent;

        Rectangle {
            id: topBar
            x: parent.x
            y: parent.y
            width: parent.width
            height: parent.height * 0.04
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#f4f4f4" }
                GradientStop { position: 1.0; color: "#e0e0e0" }
            }
        }

        DropShadow {
            anchors.fill: topBar
            samples: 17
            source: topBar
        }

//        ListModel {
//            id: listModel
//            ListElement { pid: "1"; name: "kason"; age: 25; }
//        }

        QQC14.TableView {
            id: pageTable
            anchors {
                top: topBar.bottom
                bottom: controlBar.top
                left: pageTable.parent.left
                right: pageTable.parent.right
                topMargin: 10
                leftMargin: 5
                rightMargin: 5
            }

            model: pageModel;
//            model:listModel;

            Component.onCompleted: pageModel.initialize();

            QQC14.TableViewColumn {
                title: "ID"
                role: "pid"
                width: 200;
            }
            QQC14.TableViewColumn {
                title: "Name"
                role: "name"
                width: 200;
            }
            QQC14.TableViewColumn {
                title: "Age"
                role: "age"
                width: 200;
            }
        }

        Rectangle {
            id: controlBar
            border.width: 1;
            border.color: "#aaaaaa";
            height: 60;
            anchors {
                bottom: bottomBar.top;
                left: parent.left;
                right: parent.right;
                leftMargin: 5;
                rightMargin: 5;
                bottomMargin: 5;
            }
            Text {
                height: parent.height;
                width: 200;
                verticalAlignment: Text.AlignVCenter;
                horizontalAlignment: Text.AlignLeft;
                anchors.left: parent.left;
                anchors.leftMargin: 10;
                font.family: "微软雅黑";
                font.pointSize: 14;
                text: qsTr("共 %1 条 | 每页 %2 条 | 共 %3 页 | 第 %4 页").arg(pageModel.resultCount).arg(pageModel.resultCurrent).arg(pageModel.pageCount).arg(pageModel.pageCurrent);
            }
            Row {
                id: btn_row
                height: parent.height;
                anchors.right: parent.right;
                anchors.rightMargin: 10;
                spacing: 10;

                SButton {
                    style: "btn-custom";
                    text: "首页";
                    icon_: FontAwesome.fa_fast_backward;
                    font.pixelSize: 14;
                    font.family: "微软雅黑";
                    anchors.verticalCenter: parent.verticalCenter;
                    onClicked: pageModel.first();
                }
                SButton {
                    style: "btn-custom";
                    text: "上一页";
                    icon_: FontAwesome.fa_backward;
                    font.pixelSize: 14;
                    font.family: "微软雅黑";
                    anchors.verticalCenter: parent.verticalCenter;
                    onClicked: pageModel.previous();
                }

                SButton {
                    style: "btn-custom";
                    text: "下一页";
                    icon_: FontAwesome.fa_forward;
                    font.pixelSize: 14;
                    font.family: "微软雅黑"
                    anchors.verticalCenter: parent.verticalCenter;
                    onClicked: pageModel.next();
                }
                SButton {
                    style: "btn-custom";
                    text: "尾页";
                    icon_: FontAwesome.fa_fast_forward;
                    font.pixelSize: 14;
                    font.family: FontAwesome.fontOpenSans.name;
                    anchors.verticalCenter: parent.verticalCenter;
                    onClicked: pageModel.last();
                }
            }
        }

        Rectangle {
            id: bottomBar

            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.topMargin: 5
            anchors.leftMargin: -1
            anchors.rightMargin: -1
            anchors.bottomMargin: -1
            height: 75
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#f5f5f5" }
                GradientStop { position: 1.0; color: "#eaeaea" }
            }
            border.width: 1
            border.color: "#c5c5c5"
        }
    }
}
