using GalaSoft.MvvmLight.Messaging;

namespace LaserPi.Messages {
    class ToggleChillerMessage : MessageBase {
        public ToggleChillerMessage(object sender)
                : base(sender) {
        }
    }
}