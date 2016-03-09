import QtQuick 1.1
//import QtQuick 2.0

Rectangle {
	SystemPalette { id: activePalette; colorGroup: SystemPalette.Active }

    property string label: "Button"
	property color buttonColor: activePalette.light

    signal clicked

    onClicked: {
        //animateColor.start()
	}
 
    width: buttonLabel.width + 20;
	height: buttonLabel.height + 20
    smooth: true
    border { width: 1; color: Qt.darker(activePalette.button) }
    radius: 8

    gradient: Gradient {
        GradientStop {
            position: 0.0
            color: {
                if (mouseArea.pressed)
                    return activePalette.dark
                else
                    return buttonColor
            }
        }

        GradientStop {
			position: 1.0;
            color: {
                if (mouseArea.pressed)
                    return buttonColor
                else
                    return activePalette.dark
            }
		}
    }

    MouseArea {
		id: mouseArea;
		anchors.fill: parent;
		hoverEnabled: true

		onClicked: parent.clicked()
	}

    Text {
        id: buttonLabel
		text: parent.label
		anchors.centerIn: parent
		color: activePalette.buttonText
		font.pixelSize: 24
    }
}