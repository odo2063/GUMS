#!/usr/bin/python3.4

import sys, glob
from PyQt4 import QtCore, QtGui, uic
from oct2py import octave


main = uic.loadUiType("Procedures/DIN EN 61000-4-6 Coupler Calibration/Main.ui")[0]# Uebergabe UI Main an Haupt (Name frei waehlbar)
settings = uic.loadUiType("Procedures/DIN EN 61000-4-6 Coupler Calibration/Settings.ui")[0]
measure = uic.loadUiType("Procedures/DIN EN 61000-4-6 Coupler Calibration/Measure.ui")[0]

class MainWindow(QtGui.QMainWindow, main):         			# Klasse mit Parametern (x,x,x)
	def __init__(self, parent=None):              			# initialisiert Hauptfenster
		super(MainWindow, self).__init__()  			# super def. Hauptfenster
		QtGui.QMainWindow.__init__(self, parent)
		self.setupUi(self)                    			# Diese Zeile formt passt den Fensterinhalt an die Vorgabe aus dem Qt an
#		self.checkBox.toggle()
#		liste = glob.glob("Procedures/*")
#		self.comboBox.insertItems(1,liste)
#		self.comboBox.currentIndexChanged.connect(lambda: self.checkBox.setEnabled(True))
#		self.comboBox.currentIndexChanged.connect(self.setuseen)
#		self.checkBox.stateChanged.connect(self.setexeen)
		self.settingsButton.clicked.connect(self.execsettings)	# pushButton.Geklickt--> starte def.Funktion: zeige Messung
		self.measureButton.clicked.connect(self.execmeasure)
		self.connectButton.clicked.connect(self.initialisation)
		error = octave.graphics_toolkit("fltk")
#		self.Procedure.setStyleSheet("background-color: #ff6600")

#	def setexeen(self,state):
#		
#		if state == QtCore.Qt.Checked:
#			self.Execution.setEnabled(True)
#		else:
#			self.Execution.setEnabled(False)
#	
#	def setuseen(self):
#		if self.comboBox.currentText() ==  "choose wisely...":
#			self.checkBox.setEnabled(False)
#		else:
#			self.checkBox.setEnabled(True)
	def initialisation(self):
		
		octave.addpath(str(sys.argv[1]) +"/")
		error = octave.init(genaddres, gendriverpath, powaddres, powdriverpath)
		#print str(sys.argv[1]) +"/"
	def execmeasure(self):
		MeasureWindow(self).exec_()	

	def execsettings(self):
		SettingsWindow(self).exec_()			# --> zeige Messfenster exec_()=modal
		 	

class SettingsWindow(QtGui.QDialog, settings):           			# neue Klasse fuer das Dialogfenster
	def __init__(self, Fenster=None):             			# initialiesiert Dialogfenster
		(SettingsWindow, self).__init__()      			# 
		QtGui.QDialog.__init__(self,Fenster)  			# 
		self.setupUi(self)                    			# Siehe Komentar z14
		self.arsch = Fenster                  			# anlegen eines Attributs uns es in der Klasse zu verwenden
		genliste = glob.glob("driver/generator/*")
		self.comboBoxgen.insertItems(1,genliste)
		powliste = glob.glob("driver/powermeter/*")
		self.comboBoxpow.insertItems(1,powliste)
		
		self.comboBoxgen.currentIndexChanged.connect(self.setgenadd)
		self.comboBoxpow.currentIndexChanged.connect(self.setpowadd)
		self.cancelButton.clicked.connect(self.close)
		self.okButton.clicked.connect(self.ok)
		self.okButton.clicked.connect(self.close)
#		self.connect(self.addButton, QtCore.SIGNAL("clicked()"), self.addButton_druecken) # addButton --> starte Funktion
	
	def setgenadd(self):
		global genaddres
		global genaddresfile
		global gendriverpath
		
		gendriverpath = str(self.comboBoxgen.currentText())
		genaddresfile = str(self.comboBoxgen.currentText()) + "/std_address"
		genaddres = str(octave.fileread (genaddresfile))
		self.lineEditgen.setText(genaddres)

	def setpowadd(self):
		global powaddres
		global powaddresfile
		global powdriverpath
		
		powdriverpath = str(self.comboBoxpow.currentText())
		powaddresfile = str(self.comboBoxpow.currentText()) + "/std_address"
		powaddres = str(octave.fileread (powaddresfile))
		self.lineEditpow.setText(powaddres)
		
	def ok(self):
		
		genaddres=self.lineEditgen.text()
		powaddres=self.lineEditpow.text()

		if self.checkBoxgen.checkState() == 2:
			
			with open(genaddresfile,"w") as text_file:
				text_file.write(genaddres)
			
			
		if self.checkBoxpow.checkState() == 2:
			
			with open(powaddresfile,"w") as text_file:
				text_file.write(powaddres)
				
				
		#octave.push("genaddres",str(genaddres))
		#octave.push("powaddres",str(powaddres))
		

		
class MeasureWindow(QtGui.QDialog, measure):           			# neue Klasse fuer das Dialogfenster
	def __init__(self, Fenster2=None):             			# initialiesiert Dialogfenster
		(MeasureWindow, self).__init__()      			# 
		QtGui.QDialog.__init__(self,Fenster2)  			# 
		self.setupUi(self)                    			# Siehe Komentar z14
		self.arsch2 = Fenster2 
		self.lineEditStart.setText('150e3')
		self.lineEditStop.setText('80e6')
		self.pushButtonStart.clicked.connect(self.procedure)
		self.radioButton_1.toggled.connect(self.rB1)
		self.radioButton_2.toggled.connect(self.rB2)
		self.radioButton_3.toggled.connect(self.rB3)
		self.radioButton_4.toggled.connect(self.rB4)
		self.radioButton_5.toggled.connect(self.rB5)
		self.radioButton_6.toggled.connect(self.rB6)
		self.radioButton_7.toggled.connect(self.rB7)
		self.radioButton_1.toggled.connect(self.enable)
		self.radioButton_2.toggled.connect(self.enable)
		self.radioButton_3.toggled.connect(self.enable)
		self.radioButton_4.toggled.connect(self.enable)
		self.radioButton_5.toggled.connect(self.enable)
		self.radioButton_6.toggled.connect(self.enable)
		self.radioButton_7.toggled.connect(self.enable)
		self.lineEditLevel.textEdited.connect(self.enable)
		self.lineEditTolerance.textEdited.connect(self.enable)
		self.lineEditCoupleFac.textEdited.connect(self.enable)
		
	def enable(self):
		
		aa = str(self.lineEditLevel.text())
		bb = str(self.lineEditTolerance.text())
		cc = str(self.lineEditCoupleFac.text())
		dd = str('')
		
		if aa is not dd and bb is not dd and cc is not dd:
			self.pushButtonStart.setEnabled(True)
		else:
			self.pushButtonStart.setEnabled(False)
	def procedure(self):
		
		level = str(self.lineEditLevel.text())
		tolerance = str(self.lineEditTolerance.text())
		coupleFac = str(self.lineEditCoupleFac.text())
		start = str(self.lineEditStart.text())
		stop = str(self.lineEditStop.text())
		
		#octave.addpath(str(sys.argv[1]) +"/")
		error = octave.procedure(start, stop, level, tolerance, coupleFac, genaddres, powaddres)
		print (error)
	

	def rB1(self):
		self.lineEditLevel.setEnabled(False)
		self.lineEditTolerance.setEnabled(False)
		self.lineEditLevel.setText('120')
		self.lineEditTolerance.setText('0.5')
		
		
	def rB2(self):
		self.lineEditLevel.setEnabled(False)
		self.lineEditTolerance.setEnabled(False)
		self.lineEditLevel.setText('130')
		self.lineEditTolerance.setText('0.5')
	 	
	def rB3(self):
		self.lineEditLevel.setEnabled(False)
		self.lineEditTolerance.setEnabled(False)
		self.lineEditLevel.setText('140')
		self.lineEditTolerance.setText('0.5')
	 	
	def rB4(self):
		self.lineEditLevel.setEnabled(True)
		self.lineEditLevel.setFocus
		self.lineEditTolerance.setEnabled(True)
		
	def rB5(self):
		self.lineEditCoupleFac.setEnabled(False)
		self.lineEditCoupleFac.setText('-15,6')
		
	def rB6(self):
		self.lineEditCoupleFac.setEnabled(False)
		self.lineEditCoupleFac.setText('-6')
		
	def rB7(self):
		self.lineEditCoupleFac.setEnabled(True)
		self.lineEditCoupleFac.setFocus

	
	
	
if __name__ == "__main__":                            			# Programmstart
	app = QtGui.QApplication(sys.argv)
	main = MainWindow()                         			# Festlegung des Hauptfensters
	main.show()                                   			# oeffnen des Hauptfensters
	sys.exit(app.exec_())

