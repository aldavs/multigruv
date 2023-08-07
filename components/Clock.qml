/* /usr/share/sddm/themes/multigruv/components/Clock.qml */

import QtQuick 2.0

Column {
    id: container

    property date dateTime: new Date()
    property color color: "white"
    property alias timeFont: time.font
    property alias dateFont: date.font

    Timer {
        interval: 100; running: true; repeat: true;
        onTriggered: container.dateTime = new Date()
    }

    Text {
        id: time
        anchors.horizontalCenter: parent.horizontalCenter

        color: container.color

        text : Qt.formatTime(container.dateTime, "h:mm AP")

        font.pointSize: 72
    }

    Text {
        id: date
        anchors.horizontalCenter: parent.horizontalCenter

        color: container.color

        text : Qt.formatDate(container.dateTime, Qt.DefaultLocaleLongDate)

        font.pointSize: 24
    }
}
