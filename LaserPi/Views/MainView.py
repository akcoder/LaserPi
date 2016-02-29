from PySide.QtDeclarative import QDeclarativeView
from PySide.QtCore import QUrl, Qt

class MainView(QDeclarativeView):
    """Main view"""
    
    def __init__(self, viewModel):
        super().__init__()
        self.rootContext().setContextProperty('viewModel', viewModel)

        # Set the QML file and show
        url = QUrl('Views/Main.qml')
        self.setSource(url)
        self.setCursor(Qt.BlankCursor)