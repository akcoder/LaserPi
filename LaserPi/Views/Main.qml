import QtQuick 1.1
//import QtQuick 2.0

Rectangle {
    id: window
    width: 800
    height: 480
    color: "black"

    property int rowHeight: 50
    property int column1Width: 125
    property int column2Width: 150
    property int column2_2Width: 50
	property int buttonWidth: 75

    Column {
        spacing: 5
        //anchors.fill: parent
		anchors.top: parent.top
		//anchors.topMargin: 10
		anchors.left: parent.left
		anchors.leftMargin: 10

        Row {
            height: rowHeight

            Label {
                text: "Working"
                width: column1Width
                height: parent.height
                verticalAlignment: Text.AlignVCenter
            }

            Label {
                height: parent.height
                text: viewModel.working ? "Yes" : "No"
                verticalAlignment: Text.AlignVCenter
            }
        }

        //Row 2
        Row {
            height: rowHeight

            Label {
                text: "Chiller"
                height: parent.height
                width: column1Width
                verticalAlignment: Text.AlignVCenter
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
                verticalAlignment: Text.AlignVCenter
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
                verticalAlignment: Text.AlignVCenter
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
        spacing: 10
		anchors.top: parent.top
		anchors.topMargin: 10
		anchors.right: parent.right
		anchors.rightMargin: 10

        Row {
            //height: rowHeight

			Label {
				id: timeText
                //height: parent.height
				text: Qt.formatDateTime(new Date(), "h:mm AP MMM d, yyyy")
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

        //Row 2
        Row {
            height: rowHeight
			opacity: viewModel.inlet_temp > -255 ? 1 : 0

            Label {
                text: "Inlet Temp"
                height: parent.height
                width: column2Width
                verticalAlignment: Text.AlignVCenter
            }

            Label {
                text: [viewModel.inlet_temp, "°"].join(' ')
                height: parent.height
                width: column2_2Width
                verticalAlignment: Text.AlignVCenter
            }
        }

        //Row 3
        Row {
			height: rowHeight
			opacity: viewModel.outlet_temp > -255 ? 1 : 0

            Label {
                text: "Outlet Temp"
                height: parent.height
                width: column2Width
                verticalAlignment: Text.AlignVCenter
            }

            Label {
                text: [viewModel.outlet_temp, "°"].join(' ')
                height: parent.height
                width: column2_2Width
                verticalAlignment: Text.AlignVCenter
            }
        }

		//Row 4
		Row {
			height: rowHeight
			opacity: viewModel.flow_rate > -255 ? 1 : 0

            Label {
                text: "Flow Rate"
                height: parent.height
                width: column2Width
                verticalAlignment: Text.AlignVCenter
            }

            Label {
                text: [viewModel.flow_rate, viewModel.flow_rate_units].join(' ')
                height: parent.height
                width: column2_2Width
                verticalAlignment: Text.AlignVCenter
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
