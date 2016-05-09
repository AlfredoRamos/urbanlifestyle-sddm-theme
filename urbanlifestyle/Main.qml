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

import QtQuick 2.5
import SddmComponents 2.0

import './components'

Rectangle {
	width: 640
	height: 480
	color: config.backgroundColor

	TextConstants {
		id: textConstants
	}

	Connections {
		target: sddm

		onLoginSucceeded: {
			errorMessage.color = "#005398"
			errorMessage.text = textConstants.loginSucceeded
		}

		onLoginFailed: {
			errorMessage.color = "#b00000"
			errorMessage.font.bold = true
			errorMessage.text = textConstants.loginFailed
			password.text = ""
			password.focus = true
		}
	}

	Repeater {
		model: screenModel

		Background {
			x: geometry.x
			y: geometry.y
			anchors.fill: parent
			anchors.centerIn: parent
			width: geometry.width
			height: geometry.height
			source: config.backgroundImage
			fillMode: Image.PreserveAspectFit

			onStatusChanged: {
				if (status == Image.Error && source !== config.defaultBackground) {
					source = config.defaultBackground
				}
			}
		}
	}

	Rectangle {
		property variant geometry: screenModel.geometry(screenModel.primary)
		x: geometry.x
		y: geometry.y
		width: geometry.width
		height: geometry.height
		color: "transparent"

		Rectangle {
			id: mainBox
			color: parent.color
			anchors.left: parent.left
			anchors.top: parent.top
			anchors.leftMargin: 70
			anchors.topMargin: 70
			width: Math.max(320, mainColumn.implicitWidth + 10)
			height: Math.max(295, mainColumn.implicitHeight + 10)
			border.color: "#ababab"
			border.width: 1
			radius: 6

			Column {
				id: mainColumn
				anchors.centerIn: parent
				spacing: 10

				Text {
					anchors.horizontalCenter: parent.horizontalCenter
					verticalAlignment: Text.AlignVCenter
					horizontalAlignment: Text.AlignHCenter
					width: parent.width
					height: text.implicitHeight
					color: "#333"
					text: textConstants.welcomeText.arg(sddm.hostName)
					wrapMode: Text.WordWrap
					font.pixelSize: 15
					font.bold: true
					elide: Text.ElideRight
				}

				Row {
					width: parent.width
					spacing: 5

					Column {
						width: 90
						height: 90

						Image {
							id: avatar
							width: parent.width
							height: parent.height
							sourceSize.width: parent.width
							sourceSize.height: parent.height
							clip: true
							smooth: true
							asynchronous: true
							fillMode: Image.PreserveAspectFit
							source: config.avatarSource.arg(userModel.lastUser)

							onStatusChanged: {
								if (status == Image.Error) {
									source = config.avatarSource.arg("default")
								}
							}
						}
					}

					Column {
						width: (parent.width - avatar.width) - parent.spacing

						Column {
							width: parent.width
							spacing: parent.spacing

							Text {
								id: lblName
								width: parent.width
								text: textConstants.userName
								color: config.textColor
								font.bold: true
								font.pixelSize: 12
							}

							TextBox {
								id: name
								width: parent.width
								height: 30
								text: userModel.lastUser
								font.pixelSize: 14
								font.bold: false
								color: "#99ffffff" // ARGB
								focusColor: "#69d6ac"
								hoverColor: "#69d6ac"

								KeyNavigation.backtab: rebootButton
								KeyNavigation.tab: password

								Keys.onPressed: {
									if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
										sddm.login(name.text, password.text, session.index)
										event.accepted = true
									}
								}

								Keys.onReleased: {
									if (name.text != "") {
										avatar.source = config.avatarSource.arg(name.text)
									}
								}
							}
						}

						Column {
							width: parent.width
							spacing: parent.spacing

							Text {
								id: lblPassword
								width: parent.width
								text: textConstants.password
								color: config.textColor
								font.bold: true
								font.pixelSize: 12
							}

							PasswordBox {
								id: password
								width: parent.width
								height: 30
								font.pixelSize: 14
								font.bold: false
								color: "#99ffffff" // ARGB
								focusColor: "#ebaf1d"
								hoverColor: "#ebaf1d"
								tooltipBG: "lightgrey"

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

				Row {
					spacing: 2
					width: parent.width / 2
					z: 100

					Column {
						z: 100
						width: parent.width * 1.3
						spacing: 4
						anchors.bottom: parent.bottom

						Text {
							id: lblSession
							width: parent.width
							text: textConstants.session
							wrapMode: TextEdit.WordWrap
							color: config.textColor
							font.bold: true
							font.pixelSize: 12
						}

						ComboBox {
							id: session
							width: parent.width
							height: 30
							font.pixelSize: 14
							font.bold: false
							color: "#99ffffff" // ARGB
							focusColor: "#85c92d"
							hoverColor: "#85c92d"

							arrowIcon: config.angleDown

							model: sessionModel
							index: sessionModel.lastIndex

							KeyNavigation.backtab: password
							KeyNavigation.tab: layoutBox
						}
					}

					Column {
						z: 101
						width: parent.width * 0.7
						spacing: 4
						anchors.bottom: parent.bottom

						Text {
							id: lblLayout
							width: parent.width
							text: textConstants.layout
							wrapMode: TextEdit.WordWrap
							color: config.textColor
							font.bold: true
							font.pixelSize: 12
						}

						LayoutBox {
							id: layoutBox
							width: parent.width
							height: 30
							font.pixelSize: 14
							font.bold: false
							color: "#99ffffff" // ARGB
							focusColor: "#31d8de"
							hoverColor: "#31d8de"

							arrowIcon: config.angleDown

							KeyNavigation.backtab: session
							KeyNavigation.tab: loginButton
						}
					}
				}

				Column {
					width: parent.width
					spacing: 3

					Text {
						id: errorMessage
						anchors.horizontalCenter: parent.horizontalCenter
						text: textConstants.prompt
						color: config.textColor
						font.pixelSize: 11
					}
				}

				Row {
					spacing: 3
					anchors.horizontalCenter: parent.horizontalCenter
					property int buttonWidth: Math.max(loginButton.implicitWidth, shutdownButton.implicitWidth, rebootButton.implicitWidth, 80) + 8

					Button {
						id: loginButton
						text: textConstants.login
						width: parent.buttonWidth
						color: "#08c"
						activeColor: "#08c"

						onClicked: sddm.login(name.text, password.text, session.index)

						KeyNavigation.backtab: layoutBox
						KeyNavigation.tab: shutdownButton
					}

					Button {
						id: shutdownButton
						text: textConstants.shutdown
						width: parent.buttonWidth
						color: "#d11"
						activeColor: "#d11"

						onClicked: sddm.powerOff()

						KeyNavigation.backtab: loginButton
						KeyNavigation.tab: rebootButton
					}

					Button {
						id: rebootButton
						text: textConstants.reboot
						width: parent.buttonWidth
						color: "#ff4f14"
						activeColor: "#ff4f14"

						onClicked: sddm.reboot()

						KeyNavigation.backtab: shutdownButton
						KeyNavigation.tab: name
					}
				}
			}

			Rectangle {
				id: clockContainer
				width: mainBox.width
				height: clock.height
				color: "transparent"
				anchors.horizontalCenter: mainBox.horizontalCenter
				anchors.top: mainBox.bottom
				anchors.topMargin: mainColumn.spacing

				CustomClock {
					id: clock
					anchors.centerIn: parent
					color: "#cc555555" // ARGB
					timeFormat: config.timeFormat
					dateFormat: config.dateFormat
					timeFont.pixelSize: parseInt(config.timeFontSize)
					dateFont.pixelSize: parseInt(config.dateFontSize)
				}
			}
		}
	}

	Component.onCompleted: {
		if (name.text == "") {
			name.focus = true
		} else {
			password.focus = true
		}
	}
}
