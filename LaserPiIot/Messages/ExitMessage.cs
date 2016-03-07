using GalaSoft.MvvmLight.Messaging;

namespace LaserPi.Messages {

    internal class ExitMessage : MessageBase {

        public ExitMessage(object sender)
                : base(sender) {
        }
    }
}