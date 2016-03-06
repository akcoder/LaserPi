using GalaSoft.MvvmLight.Messaging;
using LaserPi.Messages;
using LaserPi.ViewModel;
using System;
using System.Diagnostics;
using System.Threading.Tasks;
using Windows.Devices.Gpio;
using Windows.System.Profile;
using Windows.UI.Core;
using Windows.UI.Xaml;
using Windows.UI.Xaml.Controls;
using Windows.UI.Xaml.Media;

namespace LaserPi.Views {
    /// <summary>
    /// An empty page that can be used on its own or navigated to within a Frame.
    /// </summary>
    public sealed partial class MainPage : Page {
        public MainViewModel Vm {
            get {
                return (MainViewModel)DataContext;
            }
        }

        private GpioPin _ledPin;
        private GpioPin _laserPin;
        private GpioPin _chillerPin;

        private SolidColorBrush redBrush = new SolidColorBrush(Windows.UI.Colors.Red);
        private SolidColorBrush grayBrush = new SolidColorBrush(Windows.UI.Colors.LightGray);

        public MainPage() {
            SetupApp();
            InitializeComponent();

            var devForm = AnalyticsInfo.DeviceForm;
            status.Text = AnalyticsInfo.VersionInfo.DeviceFamily;
        }

        private void SetupApp() {
            try {
                if (AnalyticsInfo.VersionInfo.DeviceFamily != "Windows.Desktop") {
                    InitGPIO();
                }
            } catch (Exception) {
            }

            Messenger.Default.Register<ToggleChillerMessage>(this, ReceiveToggleChillerMessage);

            // Start Task that updates time
            Task.Factory.StartNew(async () => {
                while (true) {
                    await Windows.ApplicationModel.Core.CoreApplication.MainView.CoreWindow.Dispatcher.RunAsync(CoreDispatcherPriority.Low,
                    () => {
                        Vm.Time = DateTime.Now.ToString("hh:mm tt");
                        Vm.Date = DateTime.Now.ToString("MMMM dd, yyyy");
                    });
                    await Task.Delay(1000);
                }
            });
        }

        private void InitGPIO() {
            var gpio = GpioController.GetDefault();

            // Show an error if there is no GPIO controller
            if (gpio == null) {
                _ledPin = null;
                status.Text = "There is no GPIO controller on this device.";
                return;
            }

            _ledPin = gpio.OpenPin(Pins.LED);
            _ledPin.Write(GpioPinValue.High);
            _ledPin.SetDriveMode(GpioPinDriveMode.Output);

            _chillerPin = gpio.OpenPin(Pins.Chiller);
            _chillerPin.Write(GpioPinValue.Low);
            _chillerPin.SetDriveMode(GpioPinDriveMode.Output);

            _laserPin = gpio.OpenPin(Pins.Laser);
            // Check if input pull-up resistors are supported
            if (_laserPin.IsDriveModeSupported(GpioPinDriveMode.InputPullUp))
                _laserPin.SetDriveMode(GpioPinDriveMode.InputPullUp);
            else
                _laserPin.SetDriveMode(GpioPinDriveMode.Input);
            _laserPin.ValueChanged += LaserState;

            status.Text = "GPIO pin initialized correctly.";
        }

        private void LaserState(GpioPin sender, GpioPinValueChangedEventArgs args) {
            Debug.WriteLine("Rising Edge? {0}", args.Edge == GpioPinEdge.RisingEdge);
            LED.Fill = sender.Read() == GpioPinValue.High ? redBrush : grayBrush;
        }

        private void LedOffClicked(object sender, RoutedEventArgs e) {
            _ledPin?.Write(GpioPinValue.Low);
            status.Text = "Up";
        }

        private void LedOnClicked(object sender, RoutedEventArgs e) {
            _ledPin?.Write(GpioPinValue.High);
            status.Text = "Down";
        }

        private void ReceiveToggleChillerMessage(ToggleChillerMessage msg) {
            ChangePin(_chillerPin, Vm.ChillerOn ? GpioPinValue.Low : GpioPinValue.High);
            Vm.ChillerOn = !Vm.ChillerOn;
        }

        private void ChangePin(GpioPin pin, GpioPinValue value) {
            if (pin != null) {
                pin.Write(value);
            }
        }
    }
}
