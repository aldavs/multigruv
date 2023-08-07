/* /usr/share/sddm/themes/multigruv/components/Button.qml */

import QtQuick 2.0

Rectangle {
    id: container
    width: 80; height: 30

    property alias borderColor: main.color
    property alias textColor: textArea.color
    property alias font: textArea.font
    property alias text: textArea.text
    property alias textSize: textArea.font.pixelSize
    property alias implicitWidth: textArea.implicitWidth
    property alias implicitHeight: textArea.implicitHeight

    color: "#4682b4"
    property color disabledColor: "#888888"
    property color activeColor: "#266294"
    property color pressedColor: "#064264"

    property bool enabled: true
    property bool spaceDown: false
    property bool isFocused: activeFocus || mouseArea.containsMouse
    property bool isPressed: spaceDown || mouseArea.pressed

    signal pressed()
    signal released()
    signal clicked()

    states: [
        State {
            name: "disabled"; when: (container.enabled === false)
            PropertyChanges { target: container; color: disabledColor }
            PropertyChanges { target: main; color: disabledColor }
        },
        State {
            name: "active"; when: container.enabled && container.isFocused && !container.isPressed
            PropertyChanges { target: container; color: activeColor }
            PropertyChanges { target: main; color: activeColor }
        },
        State {
            name: "pressed"; when: container.enabled && container.isPressed
            PropertyChanges { target: container; color: pressedColor }
            PropertyChanges { target: main; color: pressedColor }
        }
    ]

    Behavior on color { NumberAnimation { duration: 200 } }

    clip: true
    smooth: true

    Rectangle {
        id: main
        width: parent.width - 2; height: parent.height - 2
        anchors.centerIn: parent

        color: parent.color
        border.color: "#00000000"
        border.width: 1

        visible: container.isFocused
    }

    Text {
        id: textArea
        anchors.centerIn: parent
        color: "white"
        text: "Button"
        font.bold: true
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent

        cursorShape: Qt.PointingHandCursor

        hoverEnabled: container.enabled
		enabled: container.enabled

        acceptedButtons: Qt.LeftButton

        onPressed: { container.focus = true; container.pressed() }
        onClicked: { container.focus = true; container.clicked() }
        onReleased: { container.focus = true; container.released() }
    }

    Keys.onPressed: {
        if (event.key === Qt.Key_Space) {
            container.spaceDown = true;
            container.pressed()
            event.accepted = true
        } else if (event.key === Qt.Key_Return) {
            container.clicked()
            event.accepted = true
        }
    }

    Keys.onReleased: {
        if (event.key === Qt.Key_Space) {
            container.spaceDown = false;
            container.released()
            container.clicked()
            event.accepted = true
        }
    }
}
