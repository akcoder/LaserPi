using System;
using Windows.UI.Xaml.Data;

namespace LaserPi.Helpers {
    class BooleanToOnOffConverter : IValueConverter {
        public bool IsReversed { get; set; }

        public object Convert(object value, Type targetType, object parameter, string language) {
            var boolValue = System.Convert.ToBoolean(value);
            if (IsReversed) {
                boolValue = !boolValue;
            }

            return boolValue ? "On" : "Off";
        }

        public object ConvertBack(object value, Type targetType, object parameter, string language) {
            throw new NotImplementedException();
        }
    }
}