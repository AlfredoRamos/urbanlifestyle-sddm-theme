/**
 * Urban LifeStyle SDDM Theme
 * Copyright (C) 2016  Alfredo Ramos <alfredo.ramos@yandex.com>
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
