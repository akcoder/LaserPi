var component;
var container;
var components = [];
var degree_symbol = '°';

function setupTempSensors(con) {
    container = con;
    component = Qt.createComponent("Temperature.qml");

    if (component.status == Component.Ready)
        addTempSensors();
    else
        component.statusChanged.connect(addTempSensors);
}

function addTempSensors() {
    var data = viewModel.temperature_sensors().replace(/'/g, '"');
    var sensors = JSON.parse(data);

    if (component.status == Component.Ready) {
        for (var key in sensors) {
            components[key] = component.createObject(container, { "model": sensors[key] });
        }

        viewModel.onTemperatureChanged.connect(tempChanged);
    } else if (component.status == Component.Error) {
        console.log("Error loading component:", component.errorString());
    }
}

function tempChanged(id, value) {
    components[id].temperature = value;
}