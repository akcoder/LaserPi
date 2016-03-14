"""Main"""
import logging
import sys
import signal
#import ptvsd
#ptvsd.enable_attach('laserpi')

from PySide.QtGui import QApplication

from ViewModel import MainViewModel
from Views import MainView
from Controller import Controller
from Helpers.Settings import Settings

def setup_logging():
    logger = logging.getLogger('')
    logger.setLevel(logging.DEBUG)
    ch = logging.StreamHandler()
    ch.setLevel(logging.DEBUG)
    # create formatter and add it to the handlers
    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
    ch.setFormatter(formatter)
    logger.addHandler(ch)
    logger.debug('debug message')
    logger.info('info message')
    logger.warn('warn message')
    logger.error('error message')
    logger.critical('critical message')

def main():
    """Main"""
    signal.signal(signal.SIGINT, signal.SIG_DFL)

    setup_logging()

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
