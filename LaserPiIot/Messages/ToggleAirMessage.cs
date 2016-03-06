using GalaSoft.MvvmLight.Messaging;

namespace LaserPi.Messages {
    class ToggleAirMessage : MessageBase {
        public ToggleAirMessage(object sender)
                : base(sender) {
        }
    }
}