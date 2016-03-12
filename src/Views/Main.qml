import QtQuick 1.1
import "Temperature.js" as Temperature
import "FlowMeter.js" as FlowMeter

Rectangle {
    id: window
    width: 800
    height: 480
    color: "black"

	Component.onCompleted: {
		var settingsObj = JSON.parse(settings.json);

		Temperature.setup(sensors, settingsObj.sensors.temperature, viewModel.onTemperatureChanged);
		FlowMeter.setup(sensors, settingsObj.sensors.flow, viewModel.onFlowRateChanged);
	}

    property int rowHeight: 50
    property int column1Width: 125
    property int column2Width: 125
    property int column2_2Width: 50
	property int buttonWidth: 75

    Column {
        spacing: 5
		anchors.top: parent.top
		anchors.left: parent.left
		anchors.leftMargin: 10

        Row {
            height: rowHeight

            Label {
                text: "Working"
                width: column1Width
                height: parent.height
            }

            Label {
                height: parent.height
                text: viewModel.working ? "Yes" : "No"
            }
        }

        //Row 2
        Row {
            height: rowHeight

            Label {
                text: "Chiller"
                height: parent.height
                width: column1Width
            }

            Button {
                width: buttonWidth
                height: parent.height
                label: viewModel.chiller ? "On" : "Off"
                onClicked: viewModel.toggle_chiller()
            }
        }

        //Row 3
        Row {
            height: rowHeight

            Label {
                text: "Exhaust"
                height: parent.height
                width: column1Width
            }

            Button {
                width: buttonWidth
                height: parent.height
                label: viewModel.exhaust ? "On" : "Off"
                onClicked: viewModel.toggle_exhaust()
            }
        }

        // Row 4
        Row {
            height: rowHeight

            Label {
                text: "Air"
                height: parent.height
                width: column1Width
            }

            Button {
                width: buttonWidth
                height: parent.height
                label: viewModel.air ? "On" : "Off"
                onClicked: viewModel.toggle_air()
            }
        }
    }

    Column {
		id: sensors
        spacing: 5
		anchors.top: parent.top
		anchors.right: parent.right
		anchors.rightMargin: 10

        Row {
            height: rowHeight

			Label {
				id: timeText
				text: Qt.formatDateTime(new Date(), "h:mm AP MMM d, yyyy")
				width: 235
				horizontalAlignment: Text.AlignRight
                height: parent.height
			}

			Timer {
				interval: 1000
				repeat: true
				running: true

				onTriggered: {
					timeText.text =  Qt.formatDateTime(new Date(),"h:mm AP MMM d, yyyy")
				}
            }
		}
	}

	Button {
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 10
		anchors.right: parent.right
		anchors.rightMargin: 10
		label: "Shutdown"
        onClicked: viewModel.shutdown()
	}

	Button {
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 10
		anchors.left: parent.left
		anchors.leftMargin: 10
		label: "Exit"
        onClicked: viewModel.exit()
	}
}
