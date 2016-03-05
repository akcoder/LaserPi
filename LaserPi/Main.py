"""Main"""
import sys
import signal
#import ptvsd
#ptvsd.enable_attach('laserpi')

from PySide.QtGui import QApplication
#from PySide.QtCore import Qt

from ViewModel import MainViewModel
from Controller import Controller
from Views import MainView
from ViewModel import MainViewModel

def main():
    """Main"""
    signal.signal(signal.SIGINT, signal.SIG_DFL)

    # Create Qt application and the QDeclarative view
    app = QApplication(sys.argv)

    view_model = MainViewModel()
    controller = Controller(view_model)

    main_view = MainView(view_model)

    if sys.platform == 'win32':
        main_view.show()
    else:
        main_view.showFullScreen()

    sys.exit(app.exec_())

if __name__ == "__main__":
    main()