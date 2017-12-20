/**
 * Urban LifeStyle SDDM Theme
 *
 * @author Alfredo Ramos <alfredo.ramos@yandex.com>
 * @copyright 2015 Alfredo Ramos
 * @license GPL-3.0+
 */

import QtQuick 2.6

import './' as UrbanLifeStyleComponents

UrbanLifeStyleComponents.ComboBox {
	id: combo

	model: keyboard.layouts
	index: keyboard.currentLayout

	onValueChanged: {
		keyboard.currentLayout = id
	}

	Connections {
		target: keyboard

		onCurrentLayoutChanged: {
			combo.index = keyboard.currentLayout
		}
	}

	rowDelegate: Rectangle {
		color: 'transparent'

		Image {
			id: img
			source: '/usr/share/sddm/flags/%1.png'.arg(modelItem ? modelItem.modelData.shortName : 'zz')

			anchors.margins: 4
			fillMode: Image.PreserveAspectFit

			anchors.left: parent.left
			anchors.top: parent.top
			anchors.bottom: parent.bottom
		}

		Text {
			anchors.margins: 4
			anchors.left: img.right
			anchors.top: parent.top
			anchors.bottom: parent.bottom

			verticalAlignment: Text.AlignVCenter

			text: modelItem ? modelItem.modelData.shortName : 'zz'
			font.pixelSize: 14
		}
	}
}
