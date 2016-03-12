import QtQuick 1.1
import "Temperature.js" as Temperature

Row {
    height: rowHeight
	opacity: 0

    property string text: null
	property real value: -255
	property string units: null
	property color color: 'blue'
	onValueChanged: checkStartAnimation()

	Component.onCompleted: fadeAnimation.pause()

	NumberAnimation on opacity {
        id: fadeAnimation
        from: 0
        to: 1
        duration: 2500
    }

	function checkStartAnimation() {
		if (fadeAnimation.paused) {
			fadeAnimation.resume();
		}
	}

    Label {
        text: parent.text
        height: parent.height
        width: column2Width
        verticalAlignment: Text.AlignVCenter
    }

    Label {
        text: value.toFixed(1)
		color: parent.color
        height: parent.height
        //width: column2_2Width
        verticalAlignment: Text.AlignVCenter
		horizontalAlignment: Text.AlignRight
    }

	Label {
        text: units
		color: parent.color
        height: parent.height
        verticalAlignment: Text.AlignVCenter
	}
}