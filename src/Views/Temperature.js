var component;
var container;
var components = [];
var degree_symbol = '°';
var settingsObj = JSON.parse(settings.json);
var units = getUnits();

function setupTempSensors(con) {
    container = con;
    component = Qt.createComponent("Temperature.qml");

    if (component.status == Component.Ready)
        addTempSensors();
    else
        component.statusChanged.connect(addTempSensors);
}

function addTempSensors() {
    var sensors = settingsObj.sensors.temperature;

    if (component.status == Component.Ready) {
        for (var key in sensors) {
            components[key] = component.createObject(container, { "model": sensors[key] });
        }

        viewModel.onTemperatureChanged.connect(tempChanged);
    } else if (component.status == Component.Error) {
        console.log("Error loading component:", component.errorString());
    }
}

//Slot for viewModel.onTemperatureChanged
function tempChanged(id, value) {
    components[id].temperature = value;
}

function format(value) {
    return [value, degree_symbol, units].join('');
    //Temperature.degree_symbol.concat(
}

function getUnits() {
    switch (settingsObj.units.temperature) {
        case 'metric':
            return 'C';
        case 'imperial':
            return 'F';
        case 'kelvin':
            return 'K';
    }

    return 'UNKN';
}