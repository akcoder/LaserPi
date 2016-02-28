import sys, signal
from PySide.QtCore import QTimer
from PySide.QtGui import QApplication

from ViewModel import MainViewModel
from Controller import Controller
from Pins import Pins
from Views import MainView

def sigint_handler(signum, frame):
    print('You pressed Ctrl+C!')
    QApplication.quit()
    sys.exit()

def main():
    signal.signal(signal.SIGINT, sigint_handler)

    # Create Qt application and the QDeclarative view
    app = QApplication(sys.argv)

    timer = QTimer()
    timer.start(500)  # You may change this if you wish.
    timer.timeout.connect(lambda: None)  # Let the interpreter run each 500 ms.

    viewModel = MainViewModel()
    controller = Controller(viewModel)

    mainView = MainView(viewModel)

    if (sys.platform == 'win32'):
        mainView.show()
    else:
        mainView.showFullScreen()

    sys.exit(app.exec_())
    
if __name__ == "__main__":
    main()
