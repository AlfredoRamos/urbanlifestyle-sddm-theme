/**
 * Urban LifeStyle SDDM Theme
 * Copyright (C) 2015  Alfredo Ramos <alfredo.ramos@yandex.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>
 */

import QtQuick 2.6
import SddmComponents 2.0

import './components'

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
		anchors.leftMargin: 70
		anchors.topMargin: 70
		color: 'transparent'
		border.color: '#ababab'
		border.width: 1
		radius: 5
		width: minWidth + 30
		height: mainColumn.implicitHeight + 30
		property int spacing: 5
		property int minWidth: 300

		Column {
			id: mainColumn
			anchors.centerIn: parent
			spacing: parent.spacing * 2

			// Welcome message
			Text {
				width: parent.width
				height: Text.implicitHeight
				text: textConstants.welcomeText.arg(sddm.hostName)
				horizontalAlignment: Text.AlignHCenter
				verticalAlignment: Text.AlignVCenter
				wrapMode: Text.WordWrap
				elide: Text.ElideRight
				color: '#333'
				font.pixelSize: 15
				font.bold: true
			}

			// Avatar, name and password
			Row {
				spacing: loginBox.spacing

				// Avatar
				ListView {
					id: users
					model: userModel
					width: 90
					height: 90

					delegate: Image {
						width: parent.width
						height: parent.height
						sourceSize.width: parent.width
						sourceSize.height: parent.height
						clip: true
						smooth: true
						asynchronous: true
						fillMode: Image.PreserveAspectFit
						source: icon
						property string avatarPath: icon.toString().replace(/(\w*\.face\.icon)/, '')

						Component.onCompleted: {
							console.log(avatarPath)
						}

						onStatusChanged: {
							if (status === Image.Error) {
								source = '%1%2.face.icon'.arg(avatarPath).arg('')
							}
						}
					}
				}

				// Name and password
				Column {
					width: (loginBox.minWidth - users.width) - parent.spacing

					// Name
					Column {
						width: parent.width
						spacing: parent.spacing

						Text {
							width: parent.width
							text: textConstants.userName
							color: '#555'
							font.bold: true
							font.pixelSize: 12
						}

						TextBox {
							id: name
							width: parent.width
							height: 30
							text: userModel.lastUser
							color: '#99ffffff' // ARGB
							font.bold: false
							font.pixelSize: 14
							focusColor: '#69d6ac'
							hoverColor: focusColor

							KeyNavigation.backtab: rebootButton
							KeyNavigation.tab: password

							Keys.onPressed: {
								if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
									sddm.login(name.text, password.text, session.index)
									event.accepted = true
								}
							}

							Keys.onReleased: {
								users.currentItem.source = '%1%2.face.icon'.arg(users.currentItem.avatarPath).arg(name.text)
							}
						}
					}

					// Password
					Column {
						width: parent.width
						spacing: parent.spacing

						Text {
							width: parent.width
							text: textConstants.password
							color: '#555'
							font.bold: true
							font.pixelSize: 12
						}

						PasswordBox {
							id: password
							width: parent.width
							height: 30
							color: '#99ffffff' // ARGB
							font.bold: false
							font.pixelSize: 14
							focusColor: '#ebaf1d'
							hoverColor: focusColor

							KeyNavigation.backtab: name
							KeyNavigation.tab: session

							Keys.onPressed: {
								if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
									sddm.login(name.text, password.text, session.index)
									event.accepted = true
								}
							}
						}
					}
				}
			}

			// Session and keyboard layout
			Row {
				spacing: loginBox.spacing
				z: 100

				// Session
				Column {
					width: (loginBox.minWidth * 0.7) - (parent.spacing / 2)
					spacing: parent.spacing

					Text {
						width: parent.width
						text: textConstants.session
						color: '#555'
						font.bold: true
						font.pixelSize: 12
					}

					ComboBox {
						id: session
						width: parent.width
						height: 30
						color: '#99ffffff' // ARGB
						font.bold: false
						font.pixelSize: 14
						focusColor: '#85c92d'
						hoverColor: focusColor
						arrowIcon: config.angleDown
						model: sessionModel
						index: sessionModel.lastIndex

						KeyNavigation.backtab: password
						KeyNavigation.tab: keyboardLayout
					}
				}

				// Keyboard layout
				Column {
					width: (loginBox.minWidth * 0.3) - (parent.spacing / 2)
					spacing: parent.spacing

					Text {
						width: parent.width
						text: textConstants.layout
						color: '#555'
						font.bold: true
						font.pixelSize: 12
					}

					LayoutBox {
						id: keyboardLayout
						width: parent.width
						height: 30
						color: '#99ffffff' // ARGB
						font.bold: false
						font.pixelSize: 14
						focusColor: '#31d8de'
						hoverColor: focusColor
						arrowIcon: config.angleDown

						KeyNavigation.backtab: session
						KeyNavigation.tab: loginButton
					}

				}
			}

			// Message
			Text {
				id: message
				width: parent.width
				height: Text.implicitHeight
				text: textConstants.prompt
				horizontalAlignment: Text.AlignHCenter
				verticalAlignment: Text.AlignVCenter
				color: '#555'
				font.pixelSize: 11
			}

			// Buttons
			Row {
				width: parent.width
				spacing: parent.spacing / 3
				anchors.horizontalCenter: parent.horizontalCenter
				property int buttonWidth: (width / 3) - (spacing / 3)

				Button {
					id: loginButton
					text: textConstants.login
					width: parent.buttonWidth
					color: '#08c'
					activeColor: color

					onClicked: sddm.login(name.text, password.text, session.index)

					KeyNavigation.backtab: keyboardLayout
					KeyNavigation.tab: shutdownButton
				}

				Button {
					id: shutdownButton
					text: textConstants.shutdown
					width: parent.buttonWidth
					color: '#d11'
					activeColor: color

					onClicked: sddm.powerOff()

					KeyNavigation.backtab: loginButton
					KeyNavigation.tab: rebootButton
				}

				Button {
					id: rebootButton
					text: textConstants.reboot
					width: parent.buttonWidth
					color: '#ff4f14'
					activeColor: color

					onClicked: sddm.reboot()

					KeyNavigation.backtab: shutdownButton
					KeyNavigation.tab: name
				}
			}
		}

		// Clock
		CustomClock {
			width: loginBox.width
			anchors.top: loginBox.bottom
			anchors.topMargin: mainColumn.spacing
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
