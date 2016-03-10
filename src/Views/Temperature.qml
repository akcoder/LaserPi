import QtQuick 1.1

Row {
	id: relay
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
        duration: 500
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
        text: temperature.toFixed(1) + viewModel.degree_symbol
		color: getTempColor(temperature)
        height: parent.height
        width: column2_2Width
        verticalAlignment: Text.AlignVCenter
    }
}