#!/usr/bin/python3.4

import sys, glob, os
from PyQt4 import QtCore, QtGui, uic
#from oct2py import octave

main = uic.loadUiType("Checker.ui")[0]                  			# Uebergabe UI Main an Haupt (Name frei waehlbar)


class MainWindow(QtGui.QMainWindow, main):         			# Klasse mit Parametern (x,x,x)
	def __init__(self, parent=None):              			# initialisiert Hauptfenster
		super(MainWindow, self).__init__()  			# super def. Hauptfenster
		QtGui.QMainWindow.__init__(self, parent)
		self.setupUi(self)                    			# Diese Zeile formt passt den Fensterinhalt an die Vorgabe aus dem Qt an
		global a
		a = 0
		self.pushButtonFail.clicked.connect(self.failpressed)
		self.pushButtonStop.clicked.connect(self.stoppressed)
		QtCore.QTimer.singleShot(int(float(sys.argv[1])*1000),lambda: app.exit(a))
		
	def failpressed(self):
		global a
		a = 1
	def stoppressed(self):
		a = 2
		app.exit(a)
		
		 	
	
if __name__ == "__main__":                            			# Programmstart
	app = QtGui.QApplication(sys.argv)
	main = MainWindow()                         			# Festlegung des Hauptfensters
	main.show()                                   			# oeffnen des Hauptfensters
	sys.exit(app.exec_())
