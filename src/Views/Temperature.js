﻿//sensors, settingsObj.sensors.temperature, settingsObj.units.temperature, viewModel.onTemperatureChanged
function setup(container, sensors, changeEvent) {
    var component = Qt.createComponent("Temperature.qml");

    var func = function () { addSensors(component, container, sensors, changeEvent); };
    if (component.status == Component.Ready)
        func()
    else
        component.statusChanged.connect(func);
}

function addSensors(component, container, sensors, changeEvent) {
    var components = [];

    if (component.status == Component.Ready) {
        for (var key in sensors) {
            var model = sensors[key];

            var item = component.createObject(container);
            item.units = '°' + getUnits(model.units);
            item.text = model.text;

            components[key] = {
                item: item,
                model: model
            };
        }

        changeEvent.connect(function (id, value) {
            var item = components[id].item;
            item.value = value;
            item.color = getColor(value, components[id].model.thresholds);
        });
    } else if (component.status == Component.Error) {
        console.log("Error loading component:", component.errorString());
    }
}

function getColor(value, thresholds) {
    for (var key in thresholds) {
        if (value >= thresholds[key]) {
            return key;
        }
    }

    return 'green';
}

function getUnits(measurementSystem) {
    switch (measurementSystem) {
        case 'imperial':
            return 'F';
        case 'kelvin':
            return 'K';
        default:
            return 'C';
    }
}