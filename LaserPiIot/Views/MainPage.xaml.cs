using GalaSoft.MvvmLight.Messaging;
using GalaSoft.MvvmLight.Threading;
using LaserPi.Messages;
using LaserPi.ViewModel;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Threading.Tasks;
using Windows.Devices.Gpio;
using Windows.Foundation;
using Windows.System;
using Windows.System.Profile;
using Windows.System.Threading;
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

        private ThreadPoolTimer _tempTimer;
        private Dictionary<int, GpioPin> _inputPins = new Dictionary<int, GpioPin>();
        private Dictionary<int, GpioPin> _outputPins = new Dictionary<int, GpioPin>();

        public MainPage() {
            SetupApp();
            InitializeComponent();

            var devForm = AnalyticsInfo.DeviceForm;
        }

        private void SetupApp() {
            try {
                if (AnalyticsInfo.VersionInfo.DeviceFamily != "Windows.Desktop") {
                    InitGPIO();
                }
            } catch (Exception ex) {
                Debug.Write(ex);
            }

            //Messenger.Default.Register<NavigateMessage>(this, message => DispatcherHelper.CheckBeginInvokeOnUI(() => ReceiveNavigateMessage(message)));

            Messenger.Default.Register<ToggleChillerMessage>(this, message => DispatcherHelper.CheckBeginInvokeOnUI(() => ReceiveToggleChillerMessage(message)));
            Messenger.Default.Register<ToggleAirMessage>(this, ReceiveToggleAirMessage);
            Messenger.Default.Register<ToggleExhaustMessage>(this, ReceiveToggleExhaustMessage);
            Messenger.Default.Register<ShutdownMessage>(this, ReceiveShutdownMessage);
            Messenger.Default.Register<ExitMessage>(this, ReceiveExitMessage);

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
            _tempTimer = ThreadPoolTimer.CreatePeriodicTimer(PollTemperature, TimeSpan.FromMinutes(1));
            var gpio = GpioController.GetDefault();

            // Show an error if there is no GPIO controller
            if (gpio == null) {
                return;
            }

            //Output Pins
            SetupOutputPin(gpio, Pins.AirOutput);
            SetupOutputPin(gpio, Pins.Chiller);
            SetupOutputPin(gpio, Pins.Exhaust);

            //Input Pins
            SetupInputPin(gpio, Pins.Working, WorkingChanged);
            SetupInputPin(gpio, Pins.AirTrigger, AirTriggerChanged);
        }

        private void PollTemperature(ThreadPoolTimer timer) {
        }

        private void SetupInputPin(GpioController controller, int pin, TypedEventHandler<GpioPin, GpioPinValueChangedEventArgs> callback) {
            var gpio = controller.OpenPin(pin);

            //if (gpio.IsDriveModeSupported(GpioPinDriveMode.InputPullDown))
            //    gpio.SetDriveMode(GpioPinDriveMode.InputPullDown);
            //else
            gpio.SetDriveMode(GpioPinDriveMode.Input);
            gpio.DebounceTimeout = TimeSpan.FromMilliseconds(50);
            gpio.ValueChanged += callback;
            _inputPins.Add(pin, gpio);
        }

        private void SetupOutputPin(GpioController controller, int pin) {
            var gpio = controller.OpenPin(pin);
            if (gpio.IsDriveModeSupported(GpioPinDriveMode.OutputOpenSourcePullDown))
                gpio.SetDriveMode(GpioPinDriveMode.OutputOpenSourcePullDown);
            else
                gpio.SetDriveMode(GpioPinDriveMode.Output);
            gpio.Write(GpioPinValue.Low);
            _outputPins.Add(pin, gpio);
        }

        private void WorkingChanged(GpioPin sender, GpioPinValueChangedEventArgs args) {
            Debug.WriteLine("Pin: {0}, State? {1}", sender.PinNumber, sender.Read());

            DispatcherHelper.CheckBeginInvokeOnUI(() => Vm.IsWorking = sender.Read() == GpioPinValue.High);
            //LED.Fill = sender.Read() == GpioPinValue.High ? redBrush : grayBrush;
        }

        private void AirTriggerChanged(GpioPin sender, GpioPinValueChangedEventArgs args) {
            Debug.WriteLine("Pin: {0}, State? {1}", sender.PinNumber, sender.Read());
            var state = args.Edge == GpioPinEdge.RisingEdge ? GpioPinValue.High : GpioPinValue.Low;

            DispatcherHelper.CheckBeginInvokeOnUI(() => Vm.AirOn = sender.Read() == GpioPinValue.High);
            ChangePin(Pins.AirOutput, state);
        }

        private void ReceiveShutdownMessage(ShutdownMessage obj) {
            ShutdownManager.BeginShutdown(ShutdownKind.Shutdown, new TimeSpan(0));
        }

        private void ReceiveExitMessage(ExitMessage obj) {
            App.Current.Exit();
        }

        private void ReceiveToggleExhaustMessage(ToggleExhaustMessage msg) {
            ChangePin(Pins.AirOutput, Vm.ExhaustOn ? GpioPinValue.Low : GpioPinValue.High);
            Vm.ExhaustOn = !Vm.ExhaustOn;
        }

        private void ReceiveToggleAirMessage(ToggleAirMessage msg) {
            ChangePin(Pins.AirOutput, Vm.AirOn ? GpioPinValue.Low : GpioPinValue.High);
            Vm.AirOn = !Vm.AirOn;
        }

        private void ReceiveToggleChillerMessage(ToggleChillerMessage msg) {
            ChangePin(Pins.Chiller, Vm.ChillerOn ? GpioPinValue.Low : GpioPinValue.High);
            Vm.ChillerOn = !Vm.ChillerOn;
        }

        private void ChangePin(int pin, GpioPinValue value) {
            if (_outputPins.ContainsKey(pin)) {
                _outputPins[pin].Write(value);
            }
        }
    }
}