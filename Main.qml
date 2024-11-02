/* /usr/share/sddm/themes/multigruv/Main.qml */

import QtQuick 2.0
import SddmComponents 2.0
import "components"

Rectangle {
  id: container
  width: config.ScreenWidth
  height: config.ScreenHeight

  LayoutMirroring.enabled: Qt.locale().textDirection == Qt.RightToLeft
  LayoutMirroring.childrenInherit: true

  property int sessionIndex: session.index

  TextConstants {
    id: textConstants
  }

  Connections {
    target: sddm
    onLoginSucceeded: {
    }

    onLoginFailed: {
      password.text = ""
      errorMessage.color = config.ColorError
      errorMessage.text = textConstants.loginFailed
    }
  }

  FontLoader {
    id: textFont; source: config.Font
  }

  Repeater {
    model: screenModel
    Background {
      x: geometry.x; y: geometry.y; width: geometry.width; height:geometry.height
      source: config.Background
      fillMode: Image.Tile
      onStatusChanged: {
        if (status == Image.Error && source != config.defaultBackground) {
          source = config.defaultBackground
        }
      }
    }
  }

  Rectangle {
    anchors.fill: parent
    color: "transparent"
    // numix theme properties
    //property variant geometry: screenModel.geometry(screenModel.primary)
    //x: geometry.x; y: geometry.y; width: geometry.width; height: geometry.height
    // primary screen
    //visible: primaryScreen

    Rectangle {
      id: clockContainer
      width: parent.width / 3
      height: parent.height * 0.3
      color: "transparent"
      anchors.right: parent.right
      anchors.verticalCenter: parent.verticalCenter
      anchors.rightMargin: 20

      Clock {
        id: clock
        //anchors.centerIn: parent
        color: config.ColorText
        timeFont.family: textFont.name
        dateFont.family: textFont.name

        Text {
          id: time
          text: Qt.formatTime(container.dateTime, "hh:mm:ss AP")
        }
      }
    }

    Rectangle {
      width: parent.width / 3
      height: parent.height * 0.3
      color: "transparent"
      anchors.top: clockContainer.bottom
      anchors.right: parent.right
      anchors.rightMargin: 90
      clip: true

      Item {
        id: usersContainer
        width: parent.width; height: parent.height
        //anchors.verticalCenter: parent.verticalCenter

        Column {
          id: nameColumn
          width: parent.width * 0.4
          spacing: 10
          anchors.margins: 10

          Text {
            id: lblName
            width: parent.width
            text: textConstants.userName
            font.family: textFont.name
            font.bold: true
            font.pixelSize: 16
            color: config.ColorText
          }

          TextBox {
            id: name
            width: parent.width
            text: userModel.lastUser
            font: textFont.name
            //font.pixelSize: 16
            color: "#25000000"
            borderColor: "#79740e"
            focusColor: config.ColorLogin
            hoverColor: config.ColorLoginH
            textColor: config.ColorText

            Keys.onPressed: {
              if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                sddm.login(name.text, password.text, session.index)
                event.accepted = true
              }
            }

            KeyNavigation.backtab: layoutBox; KeyNavigation.tab: password
          }
          Text {
            id: errorMessage
            //anchors.horizontalCenter: parent.horizontalCenter
            anchors.left: name.left
            text: textConstants.prompt
            font.family: textFont.name
            font.pixelSize: 12
            color: config.ColorPrompt
          }
        }

        Column {
          id: passColumn
          width: parent.width * 0.4
          spacing: 10
          anchors.margins: 10
          anchors.left: nameColumn.right

          Text {
            id: lblPassword
            width: parent.width
            text: textConstants.password
            font.family: textFont.name
            font.bold: true
            font.pixelSize: 16
            color: config.ColorText
          }

          PasswordBox {
            id: password
            //focus: true
            width: parent.width
            font: textFont.name
            //font.pixelSize: 16
            color: "#25000000"
            borderColor: "#79740e"
            focusColor: config.ColorLogin
            hoverColor: config.ColorLoginH
            textColor: config.ColorText
            tooltipBG: "#25000000"
            tooltipFG: config.ColorError
            //icon: "󰀧"
            image: "icon/warning.svg"

            Keys.onPressed: {
              if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                sddm.login(name.text, password.text, session.index)
                event.accepted = true
              }
            }

            KeyNavigation.backtab: name; KeyNavigation.tab: loginButton
          }

          Button {
            id: loginButton
            text: textConstants.login
            width: parent.width * 0.4
            anchors.right: password.right
            color: config.ColorLogin
            disabledColor: config.ColorError
            activeColor: config.ColorLogin
            pressedColor: config.ColorLoginH
            borderColor: config.ColorLogin
            textColor: config.ColorText
            font: textFont.name

            Rectangle {
              border.color: config.ColorLogin
            }

            onClicked: sddm.login(name.text, password.text, session.index)

            KeyNavigation.backtab: password; KeyNavigation.tab: btnReboot
          }
        }
      }
    }
  }
  Rectangle {
    id: actionBar
    anchors.top: parent.top;
    anchors.horizontalCenter: parent.horizontalCenter
    width: parent.width; height: 40
    color: "transparent"
    // primary screen
    //visible: primaryScreen

    Row {
      anchors.left: parent.left
      anchors.margins: 5
      height: parent.height
      spacing: 10

      Text {
        height: parent.height
        anchors.verticalCenter: parent.verticalCenter

        //text: textConstants.session
        text: " 󰕮"
        font.family: textFont.name
        font.pixelSize: 16
        font.bold: true
        verticalAlignment: Text.AlignVCenter
        color: config.ColorMenu
      }

      ComboBox {
        id: session
        width: 245
        height: 20
        anchors.verticalCenter: parent.verticalCenter
        color: "#25000000"
        textColor: config.ColorTopText
        borderColor: "transparent"
        focusColor: config.ColorMenu
        hoverColor: config.ColorMenuH
        menuColor: "#25000000"
        arrowBG: "#25000000"
        arrowIcon: " 󰅀"
        arrowColor: config.ColorMenu
        arrowSize: 16

        model: sessionModel
        index: sessionModel.lastIndex
        font.family: textFont.name
        font.pixelSize: 14
        //dropDown.color: "transparent"

        KeyNavigation.backtab: btnShutdown; KeyNavigation.tab: layoutBox
      }

      Text {
        height: parent.height
        anchors.verticalCenter: parent.verticalCenter

        //text: textConstants.layout
        text: "󰌌"
        font.family: textFont.name
        font.pixelSize: 16
        font.bold: true
        verticalAlignment: Text.AlignVCenter
        color: config.ColorMenu
      }

      //LayoutBox {
      //    id: layoutBox
      //    width: 90
      //    height: 20
      //    anchors.verticalCenter: parent.verticalCenter
      //    font.family: textFont.name
      //    font.pixelSize: 14
      //    color: "#25000000"
      //    textColor: "#da8548"
      //    borderColor: "transparent"

      //    arrowIcon: "icon/angle-down.svg"

      //    KeyNavigation.backtab: session; KeyNavigation.tab: btnShutdown
      //}
      ComboBox {
        id: layoutBox

        model: keyboard.layouts
        index: keyboard.currentLayout
        width: 50
        height: 20
        anchors.verticalCenter: parent.verticalCenter
        color: "#25000000"
        textColor: config.ColorTopText
        borderColor: "transparent"
        focusColor: config.ColorMenu
        hoverColor: config.ColorMenuH
        menuColor: "#25000000"
        arrowBG: "#25000000"
        arrowIcon: " 󰅀"
        arrowColor: config.ColorMenu
        arrowSize: 16
 
       onValueChanged: keyboard.currentLayout = id

        Connections {
          target: keyboard

          onCurrentLayoutChanged: combo.index = keyboard.currentLayout
        }

        rowDelegate: Rectangle {
          color: "transparent"

          Text {
            anchors.margins: 4
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            verticalAlignment: Text.AlignVCenter

            text: modelItem ? modelItem.modelData.shortName : "zz"
            font.family: textFont.name
            font.pixelSize: 14
            color: config.ColorTopText
          }
        }
        KeyNavigation.backtab: session; KeyNavigation.tab: name
      }
    }

    Row {
      height: parent.height
      anchors.right: parent.right
      //anchors.left: actionBar.right
      anchors.margins: 5
      spacing: 10

      Button {
        id: btnReboot
        text: "󰑙"
        textSize: 24
        width: 24
        color: "#00000000"
        disabledColor: config.ColorError
        activeColor: "#00000000"
        pressedColor: "#00000000"
        borderColor: "#25000000"
        textColor: config.ColorTopText
        font: textFont.name

        visible: sddm.canReboot

        onClicked: sddm.reboot()

        KeyNavigation.backtab: loginButton; KeyNavigation.tab: btnShutdown
      }

      Button {
        id: btnShutdown
        text: "󰐥"
        textSize: 24
        width: 24
        color: "#00000000"
        disabledColor: config.ColorError
        activeColor: "#00000000"
        pressedColor: "#00000000"
        borderColor: "#25000000"
        textColor: config.ColorTopText
        font: textFont.name

        visible: sddm.canPowerOff

        onClicked: sddm.powerOff()

        KeyNavigation.backtab: btnReboot; KeyNavigation.tab: session
      }
    }
  }

  Component.onCompleted: {
        if (name.text == "")
            name.focus = true
        else
            password.focus = true
  }
}
