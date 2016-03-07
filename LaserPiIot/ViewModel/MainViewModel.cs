using GalaSoft.MvvmLight;
using GalaSoft.MvvmLight.Command;
using GalaSoft.MvvmLight.Messaging;
using LaserPi.Messages;
using System;

namespace LaserPi.ViewModel {

    /// <summary>
    /// This class contains properties that the main View can data bind to.
    /// <para>
    /// Use the <strong>mvvminpc</strong> snippet to add bindable properties to this ViewModel.
    /// </para>
    /// <para>
    /// You can also use Blend to data bind with the tool's support.
    /// </para>
    /// <para>
    /// See http://www.galasoft.ch/mvvm
    /// </para>
    /// </summary>
    public class MainViewModel : ViewModelBase {

        #region Commands

        public RelayCommand ToggleChillerCommand { get; private set; }
        public RelayCommand ToggleExhaustCommand { get; private set; }
        public RelayCommand ToggleAirCommand { get; private set; }
        public RelayCommand ExitCommand { get; private set; }
        public RelayCommand ShutdownCommand { get; private set; }

        #endregion Commands

        #region Properties

        #region public string Time

        /// <summary>
        /// The <see cref="Time" /> property's name.
        /// </summary>

        private string _time = "";

        /// <summary>
        /// Sets and gets the Time property.
        /// Changes to that property's value raise the PropertyChanged event.
        /// </summary>
        public string Time {
            get {
                return _time;
            }

            set {
                if (_time == value) {
                    return;
                }

                _time = value;
                RaisePropertyChanged();
            }
        }

        #endregion public string Time

        #region public string Date

        /// <summary>
        /// The <see cref="Date" /> property's name.
        /// </summary>

        private string _date = "";

        /// <summary>
        /// Sets and gets the Date property.
        /// Changes to that property's value raise the PropertyChanged event.
        /// </summary>
        public string Date {
            get {
                return _date;
            }

            set {
                if (_date == value) {
                    return;
                }

                _date = value;
                RaisePropertyChanged();
            }
        }

        #endregion public string Date

        #region public bool AirOn

        /// <summary>
        /// The <see cref="AirOn" /> property's name.
        /// </summary>

        private bool _airOn = false;

        /// <summary>
        /// Sets and gets the AirOn property.
        /// Changes to that property's value raise the PropertyChanged event.
        /// </summary>
        public bool AirOn {
            get {
                return _airOn;
            }

            set {
                if (_airOn == value) {
                    return;
                }

                _airOn = value;
                RaisePropertyChanged();
            }
        }

        #endregion public bool AirOn

        #region public bool ChillerOn

        /// <summary>
        /// The <see cref="ChillerOn" /> property's name.
        /// </summary>

        private bool _chillerOn = false;

        /// <summary>
        /// Sets and gets the ChillerOn property.
        /// Changes to that property's value raise the PropertyChanged event.
        /// </summary>
        public bool ChillerOn {
            get {
                return _chillerOn;
            }

            set {
                if (_chillerOn == value) {
                    return;
                }

                _chillerOn = value;
                RaisePropertyChanged();
            }
        }

        #endregion public bool ChillerOn

        #region public bool ExhaustOn

        /// <summary>
        /// The <see cref="ExhaustOn" /> property's name.
        /// </summary>

        private bool _exhaustOn = false;

        /// <summary>
        /// Sets and gets the ExhaustOn property.
        /// Changes to that property's value raise the PropertyChanged event.
        /// </summary>
        public bool ExhaustOn {
            get {
                return _exhaustOn;
            }

            set {
                if (_exhaustOn == value) {
                    return;
                }

                _exhaustOn = value;
                RaisePropertyChanged();
            }
        }

        #endregion public bool ExhaustOn

        #region public bool IsWorking

        /// <summary>
        /// The <see cref="IsWorking" /> property's name.
        /// </summary>

        private bool _isWorking = false;

        /// <summary>
        /// Sets and gets the LaserOn property.
        /// Changes to that property's value raise the PropertyChanged event.
        /// </summary>
        public bool IsWorking {
            get {
                return _isWorking;
            }

            set {
                if (_isWorking == value) {
                    return;
                }

                _isWorking = value;
                RaisePropertyChanged();
            }
        }

        #endregion public bool IsWorking

        #endregion Properties

        /// <summary>
        /// Initializes a new instance of the MainViewModel class.
        /// </summary>
        public MainViewModel() {
            if (IsInDesignMode) {
                Time = DateTime.Now.ToString("hh:mm tt");
                Date = DateTime.Now.ToString("MMMM dd, yyyy");
                IsWorking = true;
                RaisePropertyChanged("Time");
                // Code runs in Blend --> create design time data.
            } else {
                ToggleAirCommand = new RelayCommand(() => Messenger.Default.Send(new ToggleAirMessage(this)));
                ToggleExhaustCommand = new RelayCommand(() => Messenger.Default.Send(new ToggleExhaustMessage(this)), () => !IsWorking);
                ToggleChillerCommand = new RelayCommand(() => Messenger.Default.Send(new ToggleChillerMessage(this)), () => !IsWorking);

                ExitCommand = new RelayCommand(() => Messenger.Default.Send(new ExitMessage(this)), () => !IsWorking);
                ShutdownCommand = new RelayCommand(() => Messenger.Default.Send(new ShutdownMessage(this)), () => !IsWorking);
                //ToggleChillerCommand.Execute(this);
                // Code runs "for real"
            }
        }
    }
}