using GalaSoft.MvvmLight.Messaging;

namespace LaserPi.Messages {
    class ToggleExhaustMessage : MessageBase {
        public ToggleExhaustMessage(object sender)
                : base(sender) {
        }
    }
}