/**
 * Urban LifeStyle SDDM Theme
 *
 * @author Alfredo Ramos <alfredo.ramos@protonmail.com>
 * @copyright 2016 Alfredo Ramos
 * @license GPL-3.0-or-later
 */

import QtQuick 2.6

Column {
	id: container

	property date dateTime: new Date()
	property string timeFormat: "hh:mm"
	property string dateFormat: "dddd, MMMM d, yyyy"
	property alias timeFont: time.font
	property alias dateFont: date.font
	property color color: "black"

	Timer {
		interval: 100
		running: true
		repeat: true
		onTriggered: container.dateTime = new Date()
	}

	Text {
		id: time
		anchors.horizontalCenter: parent.horizontalCenter
		color: container.color
		text : Qt.formatTime(container.dateTime, timeFormat)
		font.pixelSize: 25
	}

	Text {
		id: date
		anchors.horizontalCenter: parent.horizontalCenter
		color: container.color
		text : Qt.formatDate(container.dateTime, dateFormat)
		font.pixelSize: 13
	}
}
