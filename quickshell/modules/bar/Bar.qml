import QtQuick
import Quickshell
import Quickshell.Hyprland

PanelWindow {
    id:panel
    color: "transparent"

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 40
    margins {
        top: 2
        left: 7
        right: 7

    }

    Rectangle{
        id: bar
        anchors.fill: parent
        color: "#1a1a1a"
        radius: 10
        border.color: "#333333"
        border.width: 3



        Row{
            id: workspacesRow


            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
                leftMargin: 16
            }
            spacing: 8

            Repeater{
                model: Hyprland.workspaces

                Rectangle{
                    width: 32
                    height: 24
                    radius: 4
                    color: modelData.active ? "#4a9eff" : "#333333"
                    border.color: "#555555"
                    border.width: 2



                    MouseArea {
                        anchors.fill: parent
                        onClicked: modelData.activate()
                    }

                    Text {
                        text: modelData.id
                        anchors.centerIn: parent
                        color: modelData.active ? "#ffffff" : "#cccccc"
                        font.pixelSize: 12
                        font.family: "Intel, sans-serif"
                    }
                }
            }

            Text {
                visible: Hyprland.workspaces.length === 0
                text: "No workspaces"
                color: "#ffffff"
                font.pixelSize: 12
            }
        }

        Text {
            id: timeDisplay
            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
                rightMargin: 16
            }

            property string currentTime: ""

            text: currentTime
            color: "#ffffff"
            font.pixelSize: 14
            font.family: "Intel, sans-serif"

            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: {
                    var now = new Date()
                    timeDisplay.currentTime = Qt.formatDate(now, "MMM dd") + " " + Qt.formatTime(now, "hh:mm:ss")
                }
            }

            Component.onCompleted: {
                var now = new Date()
                currentTime = Qt.formatDate(now, "MMM dd") + " " + Qt.formatTime(now, "hh:mm:ss")
                
            }
        }
    }
}