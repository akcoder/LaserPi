import QtQuick 1.1
//import QtQuick 2.0

Rectangle {
    id: window
    width: 800
    height: 480
    color: "black"

    Column {
        spacing: 5
        //anchors.fill: parent
		anchors.top: parent.top
		//anchors.topMargin: 10
		anchors.left: parent.left
		anchors.leftMargin: 10

        Row {
            id: workingRow
            height: 50

            Label {
                id: workingLabel
                text: "Working"
                width: 100
                height: parent.height
                verticalAlignment: Text.AlignVCenter
            }

            Label {
                height: parent.height
                text: viewModel.working ? "Yes" : "No"
                verticalAlignment: Text.AlignVCenter
            }
        }

        Row {
            id: chillerRow
            height: workingRow.height

            //Row 2
            Label {
                id: chillerLabel
                text: "Chiller"
                height: parent.height
                width: workingLabel.width
                verticalAlignment: Text.AlignVCenter
            }

            Button {
                id: chillerButton
                width: 60
                height: parent.height
                label: viewModel.chiller ? "On" : "Off"
                onClicked: viewModel.toggle_chiller()
            }
        }

        Row {
            id: exaustRow
            height: workingRow.height

            //Row 3
            Label {
                id: exhaustLabel
                text: "Exhaust"
                height: parent.height
                width: workingLabel.width
                verticalAlignment: Text.AlignVCenter
            }

            Button {
                id: exhaustButton
                width: 60
                height: parent.height
                label: viewModel.exhaust ? "On" : "Off"
                onClicked: viewModel.toggle_exhaust()
            }
        }

        Row {
            id: airRow
            height: workingRow.height

            // Row 4
            Label {
                id: airLabel
                text: "Air"
                height: parent.height
                width: workingLabel.width
                verticalAlignment: Text.AlignVCenter
            }

            Button {
                id: airButton
                width: 60
                height: parent.height
                label: viewModel.air ? "On" : "Off"
                onClicked: viewModel.toggle_air()
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

	Item {
		id: clock
			anchors.top: parent.top
			anchors.topMargin: 10
			anchors.right: parent.right
			anchors.rightMargin: 10

		Label {
			id: timeText
			text: Qt.formatDateTime(new Date(), "h:mm AP MMM d, yyyy")
			anchors.top: parent.top
			anchors.right: parent.right
		}

		Timer {
			id: timer
			interval: 1000
			repeat: true
			running: true

			onTriggered:
			{
				timeText.text =  Qt.formatDateTime(new Date(),"h:mm AP MMM d, yyyy")
			}
		}
	}
}
