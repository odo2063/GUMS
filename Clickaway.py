#!/usr/bin/python3.4

import sys, glob, os
from PyQt4 import QtCore, QtGui, uic
from oct2py import octave

checker = uic.loadUiType("Clickaway.ui")[0]                  			# Uebergabe UI Main an Haupt (Name frei waehlbar)


class MainWindow(QtGui.QMainWindow, checker):         			# Klasse mit Parametern (x,x,x)
	def __init__(self, parent=None):              			# initialisiert Hauptfenster
		super(MainWindow, self).__init__()  			# super def. Hauptfenster
		QtGui.QMainWindow.__init__(self, parent)
		self.setupUi(self)                    			# Diese Zeile formt passt den Fensterinhalt an die Vorgabe aus dem Qt an
		self.pushButtonOk.clicked.connect(self.ok)
		#QtCore.QTimer.singleShot(int(float(sys.argv[1])*1000),lambda: app.exit(a))
		
	def ok(self):
		app.exit()
		
	
if __name__ == "__main__":                            			# Programmstart
	app = QtGui.QApplication(sys.argv)
	checker = MainWindow()                         			# Festlegung des Hauptfensters
	checker.show()                                   			# oeffnen des Hauptfensters
	sys.exit(app.exec_())
