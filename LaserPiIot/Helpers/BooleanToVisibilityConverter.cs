﻿using System;
using Windows.UI.Xaml;
using Windows.UI.Xaml.Data;

namespace LaserPi.Helpers {
    internal sealed class BooleanToVisibilityConverter : IValueConverter {
        public bool IsReversed { get; set; }

        public object Convert(object value, Type targetType, object parameter, string language) {
            var val = System.Convert.ToBoolean(value);
            if (IsReversed) {
                val = !val;
            }

            if (val) {
                return Visibility.Visible;
            }

            return Visibility.Collapsed;
        }

        public object ConvertBack(object value, Type targetType, object parameter, string language) {
            throw new NotImplementedException();
        }
    }
}