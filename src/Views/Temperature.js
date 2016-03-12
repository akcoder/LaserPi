//sensors, settingsObj.sensors.temperature, settingsObj.units.temperature, viewModel.onTemperatureChanged
function setup(container, sensors, measurementSystem, changeEvent) {
    var component = Qt.createComponent("Temperature.qml");

    var func = function () { addSensors(component, container, sensors, changeEvent, measurementSystem); };
    if (component.status == Component.Ready)
        func()
    else
        component.statusChanged.connect(func);
}

function addSensors(component, container, sensors, changeEvent, measurementSystem) {
    var components = [];

    if (component.status == Component.Ready) {
        for (var key in sensors) {
            var item = component.createObject(container, { "model": sensors[key] });
            item.units = '°' + getUnits(measurementSystem);
            components[key] = item;
        }

        changeEvent.connect(function (id, value) {
            components[id].temperature = value;
        });
    } else if (component.status == Component.Error) {
        console.log("Error loading component:", component.errorString());
    }
}

function getUnits(measurementSystem) {
    switch (measurementSystem) {
        case 'metric':
            return 'C';
        case 'imperial':
            return 'F';
        case 'kelvin':
            return 'K';
    }

    return 'UNKN';
}