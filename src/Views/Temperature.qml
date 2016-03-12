import QtQuick 1.1
import "Temperature.js" as Temperature

Row {
    height: rowHeight
	opacity: 0

    property variant model: null
	property real temperature: -255
	onTemperatureChanged: checkStartAnimation()

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

	function getTempColor(value) {
		for (var key in model.thresholds) {
			if (value >= model.thresholds[key]) {
				return key;
			}
		}

		return 'green';
	}

    Label {
        text: model.text
        height: parent.height
        width: column2Width
        verticalAlignment: Text.AlignVCenter
    }

    Label {
        text: temperature.toFixed(1)
		color: getTempColor(temperature)
        height: parent.height
        //width: column2_2Width
        verticalAlignment: Text.AlignVCenter
		horizontalAlignment: Text.AlignRight
    }

	Label {
        text: Temperature.degree_symbol + Temperature.units
		color: getTempColor(temperature)
        height: parent.height
        verticalAlignment: Text.AlignVCenter
	}
}