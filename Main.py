#!/usr/bin/python3.4

import sys, glob, os
from PyQt4 import QtCore, QtGui, uic
from oct2py import octave
#import Measurewindow

main = uic.loadUiType("Main.ui")[0]                  			# Uebergabe UI Main an Haupt (Name frei waehlbar)


class MainWindow(QtGui.QMainWindow, main):         			# Klasse mit Parametern (x,x,x)
	def __init__(self, parent=None):              			# initialisiert Hauptfenster
		super(MainWindow, self).__init__()  			# super def. Hauptfenster
		QtGui.QMainWindow.__init__(self, parent)
		self.setupUi(self)                    			# Diese Zeile formt passt den Fensterinhalt an die Vorgabe aus dem Qt an
		liste = glob.glob("Procedures/*")
		self.comboBox.insertItems(1,liste)
		self.comboBox.currentIndexChanged.connect(self.setuseen)
		self.checkBox.clicked.connect(self.setexeen)

	def setexeen(self,state):

		global globalpath
		globalpath=str(self.comboBox.currentText()).replace(" ","\ ")
		os.system(globalpath + "/Procedure.py " + globalpath)


	def setuseen(self):
		if self.comboBox.currentText() ==  "choose wisely...":
			self.checkBox.setEnabled(False)
		else:
			self.checkBox.setEnabled(True)




if __name__ == "__main__":                            			# Programmstart
	app = QtGui.QApplication(sys.argv)
	main = MainWindow()                         			# Festlegung des Hauptfensters
	main.show()                                   			# oeffnen des Hauptfensters
	sys.exit(app.exec_())
