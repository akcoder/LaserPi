using GalaSoft.MvvmLight.Messaging;

namespace LaserPi.Messages {

    internal class ShutdownMessage : MessageBase {

        public ShutdownMessage(object sender)
                : base(sender) {
        }
    }
}