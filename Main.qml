/**
 * Urban LifeStyle SDDM Theme
 *
 * @author Alfredo Ramos <alfredo.ramos@skiff.com>
 * @copyright 2015 Alfredo Ramos
 * @license GPL-3.0-or-later
 */

import QtQuick 2.6
import QtQuick.Layouts 1.2
import SddmComponents 2.0

import './components' as UrbanLifeStyleComponents

Rectangle {
	id: container
	width: 1024
	height: 768
	color: config.backgroundColor

	TextConstants {
		id: textConstants
	}

	Connections {
		target: sddm

		onLoginFailed: {
			message.color = '#b00000'
			message.font.bold = true
			message.text = textConstants.loginFailed
			password.text = ''
			password.focus = true
		}
	}

	Background {
		anchors.fill: parent
		anchors.centerIn: parent
		source: config.background
		fillMode: Image.PreserveAspectFit

		onStatusChanged: {
			if (status === Image.Error && source !== config.defaultBackground) {
				source = config.defaultBackground
			}
		}
	}

	Rectangle {
		id: loginBox
		anchors.left: parent.left
		anchors.top: parent.top
		anchors.topMargin: 70
		anchors.leftMargin: anchors.topMargin
		width: 350
		height: loginBoxLayout.implicitHeight + (loginBoxLayout.anchors.margins * 2)
		color: '#33ffffff' // ARGB
		border.color: '#ababab'
		border.width: 1
		radius: 6

		GridLayout {
			id: loginBoxLayout
			anchors.fill: parent
			anchors.margins: 10
			columns: 3
			rows: 9
			z: 1

			// Welcome message
			Text {
				color: '#333'
				font.bold: true
				font.pixelSize: 14
				text: textConstants.welcomeText.arg(sddm.hostName)
				horizontalAlignment: Text.AlignHCenter
				verticalAlignment: Text.AlignVCenter
				wrapMode: Text.WordWrap

				Layout.columnSpan: loginBoxLayout.columns
				Layout.fillWidth: true
				Layout.fillHeight: true
				Layout.bottomMargin: loginBoxLayout.anchors.margins / 2
			}

			// Avatar
			ListView {
				id: users
				model: userModel

				delegate: Image {
					anchors.fill: parent
					width: loginBox.width / 3
					height: width
					sourceSize.width: width
					sourceSize.height: height
					clip: true
					smooth: true
					asynchronous: true
					fillMode: Image.PreserveAspectFit
					source: icon
					property string avatarPath: icon.toString().replace(/(\w*\.face\.icon)/, '')

					onStatusChanged: {
						if (status === Image.Error) {
							source = config.avatar.arg(avatarPath).arg('')
						}
					}
				}

				Layout.rowSpan: 4
				Layout.fillWidth: true
				Layout.fillHeight: true
				Layout.topMargin: loginBoxLayout.anchors.margins / 4
				Layout.bottomMargin: Layout.topMargin
			}

			// Name label
			Text {
				color: '#555'
				font.bold: true
				font.pixelSize: 12
				text: textConstants.userName

				Layout.columnSpan: loginBoxLayout.columns - 1
				Layout.fillWidth: true
			}

			// Name field
			TextBox {
				id: name
				color: '#99ffffff' // ARGB
				font.bold: false
				font.pixelSize: 15
				text: userModel.lastUser
				focusColor: '#69d6ac'
				hoverColor: focusColor

				Layout.columnSpan: loginBoxLayout.columns - 1
				Layout.fillWidth: true

				KeyNavigation.backtab: rebootButton
				KeyNavigation.tab: password

				Keys.onPressed: {
					if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
						sddm.login(name.text, password.text, session.index)
						event.accepted = true
					}
				}

				Keys.onReleased: {
					users.currentItem.source = config.avatar.arg(users.currentItem.avatarPath).arg(name.text)
				}
			}

			// Password label
			Text {
				color: '#555'
				font.bold: true
				font.pixelSize: 12
				text: textConstants.password

				Layout.columnSpan: loginBoxLayout.columns - 1
				Layout.fillWidth: true
			}

			// Password field
			PasswordBox {
				id: password
				color: '#99ffffff' // ARGB
				font.bold: false
				font.pixelSize: 14
				focusColor: '#ebaf1d'
				hoverColor: focusColor

				Layout.columnSpan: loginBoxLayout.columns - 1
				Layout.fillWidth: true

				KeyNavigation.backtab: name
				KeyNavigation.tab: session

				Keys.onPressed: {
					if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
						sddm.login(name.text, password.text, session.index)
						event.accepted = true
					}
				}
			}

			// Session label
			Text {
				color: '#555'
				font.bold: true
				font.pixelSize: 12
				text: textConstants.session

				Layout.columnSpan: loginBoxLayout.columns - 1
				Layout.fillWidth: true
			}

			// Keyboard layout label
			Text {
				color: '#555'
				font.bold: true
				font.pixelSize: 12
				text: textConstants.layout

				Layout.fillWidth: true
			}

			// Session field
			ComboBox {
				id: session
				color: '#99ffffff' // ARGB
				focusColor: '#85c92d'
				hoverColor: focusColor
				arrowIcon: config.angleDown
				model: sessionModel
				index: sessionModel.lastIndex
				z: 1

				Layout.columnSpan: loginBoxLayout.columns - 1
				Layout.fillWidth: true

				KeyNavigation.backtab: password
				KeyNavigation.tab: keyboardLayout
			}

			// Keyboard layout field
			LayoutBox {
				id: keyboardLayout
				color: '#99ffffff' // ARGB
				focusColor: '#31d8de'
				hoverColor: focusColor
				arrowIcon: config.angleDown
				z: 1

				Layout.fillWidth: true

				KeyNavigation.backtab: session
				KeyNavigation.tab: loginButton
			}

			// Message
			Text {
				id: message
				color: '#555'
				font.pixelSize: 11
				text: textConstants.prompt
				horizontalAlignment: Text.AlignHCenter
				verticalAlignment: Text.AlignVCenter

				Layout.columnSpan: loginBoxLayout.columns
				Layout.fillWidth: true
				Layout.fillHeight: true
				Layout.topMargin: loginBoxLayout.anchors.margins / 2
				Layout.bottomMargin: Layout.topMargin
			}

			// Login button
			Button {
				id: loginButton
				color: '#08c'
				font.pixelSize: 12
				activeColor: color
				text: textConstants.login

				onClicked: sddm.login(name.text, password.text, session.index)

				Layout.fillWidth: true

				KeyNavigation.backtab: keyboardLayout
				KeyNavigation.tab: shutdownButton
			}

			// Shutdown button
			Button {
				id: shutdownButton
				color: '#d11'
				font.pixelSize: 12
				activeColor: color
				text: textConstants.shutdown

				onClicked: sddm.powerOff()

				Layout.fillWidth: true

				KeyNavigation.backtab: loginButton
				KeyNavigation.tab: rebootButton
			}

			// Reboot button
			Button {
				id: rebootButton
				color: '#ff4f14'
				font.pixelSize: 12
				activeColor: color
				text: textConstants.reboot

				onClicked: sddm.reboot()

				Layout.fillWidth: true

				KeyNavigation.backtab: shutdownButton
				KeyNavigation.tab: name
			}
		}

		// Clock
		UrbanLifeStyleComponents.CustomClock {
			width: loginBox.width
			anchors.top: loginBox.bottom
			anchors.topMargin: loginBoxLayout.anchors.margins
			color: '#cc555555' // ARGB
			timeFormat: config.timeFormat
			dateFormat: config.dateFormat
			timeFont.pixelSize: parseInt(config.timeFontSize)
			dateFont.pixelSize: parseInt(config.dateFontSize)
		}

	}

	Component.onCompleted: {
		if (name.text === '') {
			name.focus = true
		} else {
			password.focus = true
		}
	}
}
