#!/usr/bin/python3.4

import sys, glob
from PyQt4 import QtCore, QtGui, uic
from oct2py import octave


main = uic.loadUiType("Procedures/DIN EN 61000-4-6 Conducted Imunity/Main.ui")[0]# Uebergabe UI Main an Haupt (Name frei waehlbar)
settings = uic.loadUiType("Procedures/DIN EN 61000-4-6 Conducted Imunity/Settings.ui")[0]
measure = uic.loadUiType("Procedures/DIN EN 61000-4-6 Conducted Imunity/Measure.ui")[0]

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
#		error = octave.graphics_toolkit("fltk")
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
		##veränderung -> connecting...
		error = octave.init(genaddres, gendriverpath, powaddres, powdriverpath)
		##freigeben measureButton; veränderung -> connected
		self.measureButton.setEnabled(True)
		
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
		self.loadButton.clicked.connect(self.load)
		self.saveButton.clicked.connect(self.save)
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
		self.connectenable()

	def setpowadd(self):
		global powaddres
		global powaddresfile
		global powdriverpath
		
		powdriverpath = str(self.comboBoxpow.currentText())
		powaddresfile = str(self.comboBoxpow.currentText()) + "/std_address"
		powaddres = str(octave.fileread (powaddresfile))
		self.lineEditpow.setText(powaddres)
		self.connectenable()
		
	def ok(self):
		
		genaddres=self.lineEditgen.text()
		powaddres=self.lineEditpow.text()

		if self.checkBoxgen.checkState() == 2:
			
			with open(genaddresfile,"w") as text_file:
				text_file.write(genaddres)
			
			
		if self.checkBoxpow.checkState() == 2:
			
			with open(powaddresfile,"w") as text_file:
				text_file.write(powaddres)
				
		self.parent().connectButton.setEnabled(True)
		
	def save(self):
		
		save = "#" + gendriverpath + "#" + powdriverpath
		with open("Procedures/DIN EN 61000-4-6 Conducted Imunity/std_system","w") as text_file:
			text_file.write(save)
	
	def load(self):
		save = str(octave.fileread ("Procedures/DIN EN 61000-4-6 Conducted Imunity/std_system"))
		
		gendriverpath = octave.sysload(save,"1")
		index = self.comboBoxgen.findText(gendriverpath)
		self.comboBoxgen.setCurrentIndex(index)
		powdriverpath = octave.sysload(save,"2")
		index = self.comboBoxpow.findText(powdriverpath)
		self.comboBoxpow.setCurrentIndex(index)
		self.connectenable()
				
				
		#octave.push("genaddres",str(genaddres))
		#octave.push("powaddres",str(powaddres))
		
	def connectenable(self):
	
		cw =  "Choose wisely ..."
		if ((self.comboBoxgen.currentText() == cw) or (self.comboBoxpow.currentText() == cw)):
			self.okButton.setEnabled(False)
		else:
			self.okButton.setEnabled(True)
		

		
class MeasureWindow(QtGui.QDialog, measure):           			# neue Klasse fuer das Dialogfenster
	def __init__(self, Fenster2=None):             			# initialiesiert Dialogfenster
		(MeasureWindow, self).__init__()      			# 
		QtGui.QDialog.__init__(self,Fenster2)  			# 
		self.setupUi(self)                    			# Siehe Komentar z14
		self.arsch2 = Fenster2
		levellist = glob.glob("Procedures/DIN EN 61000-4-6 Conducted Imunity/level/*")
		self.comboBoxLevel.insertItems(1,levellist)
		self.pushButtonClose.clicked.connect(self.close)
		self.comboBoxLevel.currentIndexChanged.connect(self.enable)
		self.comboBoxLevel.currentIndexChanged.connect(self.level)
			
	def enable(self):
		
		aa = str(self.lineEditStart.text())
		bb = str(self.lineEditStop.text())
		cc = str(self.lineEditTolerance.text())
		dd = str(self.lineEditDwell.text())
		ee = str(self.lineEditModfreq.text())
		ff = str(self.lineEditModdepth.text())
		gg = str(self.lineEditWait.text())
		xx = str('')
		 
		cw =  "Choose wisely ..."
		if (self.comboBoxLevel.currentText() != cw) and aa is not xx and bb is not xx and cc is not xx and dd is not xx and ee is not xx and ff is not xx and gg is not xx:
			self.pushButtonStart.setEnabled(True)
		else:
			self.pushButtonStart.setEnabled(False)
			
	def level(self):
		
		octave.eval("level = csvread('"+self.comboBoxLevel.currentText()+"')")
		octave.eval("semilogx(level(:,1),level(:,2))")
		#octave.eval("
		octave.eval('start = level(1)')
		octave.eval('stop = level(end,1)')
		self.lineEditStart.setText(str(octave.pull('start')/1e3))
		self.lineEditStop.setText(str(octave.pull('stop')/1e3))
		
	def procedure(self):
		
		aa = str(self.lineEditStart.text())
		bb = str(self.lineEditStop.text())
		cc = str(self.lineEditTolerance.text())
		dd = str(self.lineEditDwell.text())
		ee = str(self.lineEditModfreq.text())
		ff = str(self.lineEditModdepth.text())
		gg = str(self.lineEditWait.text())
		
		#octave.addpath(str(sys.argv[1]) +"/")
		error = octave.procedure(f_table,levels,leveltol,t_dwell, t_wait,mod_freq,mod_depth)
		print (error)
		
if __name__ == "__main__":                            			# Programmstart
	app = QtGui.QApplication(sys.argv)
	main = MainWindow()                         			# Festlegung des Hauptfensters
	main.show()                                   			# oeffnen des Hauptfensters
	sys.exit(app.exec_())

