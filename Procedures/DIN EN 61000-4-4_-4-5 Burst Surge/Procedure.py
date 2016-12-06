#!/usr/bin/python3.4

import sys, glob
from PyQt4 import QtCore, QtGui, uic
from oct2py import octave


main = uic.loadUiType("Procedures/DIN EN 61000-4-4_-4-5 Burst Surge/Main.ui")[0]# Uebergabe UI Main an Haupt (Name frei waehlbar)
settings = uic.loadUiType("Procedures/DIN EN 61000-4-4_-4-5 Burst Surge/Settings.ui")[0]
measure = uic.loadUiType("Procedures/DIN EN 61000-4-4_-4-5 Burst Surge/Measure.ui")[0]

class MainWindow(QtGui.QMainWindow, main):         			# Klasse mit Parametern (x,x,x)
	def __init__(self, parent=None):              			# initialisiert Hauptfenster
		super(MainWindow, self).__init__()  			# super def. Hauptfenster
		QtGui.QMainWindow.__init__(self, parent)
		self.setupUi(self)                    			# Diese Zeile formt passt den Fensterinhalt an die Vorgabe aus dem Qt an
#		self.checkBox.toggle()
#		liste = glob.glob("Procedures/*")
#		self.comboBox.insertItems(1,liste)
#		self.comboBox.currentIndexChanged.connect(lambda: self.checkBox.setEnabled(True))
#
#		self.checkBox.stateChanged.connect(self.setexeen)
		self.settingsButton.clicked.connect(self.execsettings)	# pushButton.Geklickt--> starte def.Funktion: zeige Messung
		self.measureButton.clicked.connect(self.execmeasure)
		self.connectButton.clicked.connect(self.initialisation)
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
		error = octave.init(genBaddres, genBdriverpath, genSaddres, genSdriverpath, couaddres, coudriverpath)
		print (error)
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
		genBliste = glob.glob("driver/burstgenerator/*")
		self.comboBoxgenB.insertItems(1,genBliste)
		genSliste = glob.glob("driver/surgegenerator/*")
		self.comboBoxgenS.insertItems(1,genSliste)
		couliste = glob.glob("driver/coupler/*")
		self.comboBoxcou.insertItems(1,couliste)

		self.comboBoxgenB.currentIndexChanged.connect(self.setgenBadd)
		self.comboBoxgenS.currentIndexChanged.connect(self.setgenSadd)
		self.comboBoxcou.currentIndexChanged.connect(self.setcouadd)
		self.cancelButton.clicked.connect(self.close)
		self.loadButton.clicked.connect(self.load)
		self.saveButton.clicked.connect(self.save)
		self.okButton.clicked.connect(self.ok)
		self.okButton.clicked.connect(self.close)
#		self.connect(self.addButton, QtCore.SIGNAL("clicked()"), self.addButton_druecken) # addButton --> starte Funktion

	def setgenBadd(self):
		global genBaddres
		global genBaddresfile
		global genBdriverpath

		genBdriverpath = str(self.comboBoxgenB.currentText())
		genBaddresfile = str(self.comboBoxgenB.currentText()) + "/std_address"
		genBaddres = str(octave.fileread (genBaddresfile))
		self.lineEditgenB.setText(genBaddres)

	def setgenSadd(self):
		global genSaddres
		global genSaddresfile
		global genSdriverpath

		genSdriverpath = str(self.comboBoxgenS.currentText())
		genSaddresfile = str(self.comboBoxgenS.currentText()) + "/std_address"
		genSaddres = str(octave.fileread (genSaddresfile))
		self.lineEditgenS.setText(genSaddres)

	def setcouadd(self):
		global couaddres
		global couaddresfile
		global coudriverpath

		coudriverpath = str(self.comboBoxcou.currentText())
		couaddresfile = str(self.comboBoxcou.currentText()) + "/std_address"
		couaddres = str(octave.fileread (couaddresfile))
		self.lineEditcou.setText(couaddres)

	def ok(self):

		genBaddres=self.lineEditgenB.text()
		genSaddres=self.lineEditgenS.text()
		couaddres=self.lineEditcou.text()

		if self.checkBoxgenB.checkState() == 2:

			with open(genBaddresfile,"w") as text_file:
				text_file.write(genBaddres)

		if self.checkBoxgenS.checkState() == 2:

			with open(genSaddresfile,"w") as text_file:
				text_file.write(genSaddres)

		if self.checkBoxcou.checkState() == 2:

			with open(couaddresfile,"w") as text_file:
				text_file.write(couaddres)
	
	def load(self):
		save = str(octave.fileread ("Procedures/DIN EN 61000-4-4_-4-5 Burst Surge/std_system"))
		
		genBdriverpath = octave.sysload(save,"1")
		index = self.comboBoxgenB.findText(genBdriverpath)
		self.comboBoxgenB.setCurrentIndex(index)
		genSdriverpath = octave.sysload(save,"2")
		index = self.comboBoxgenS.findText(genSdriverpath)
		self.comboBoxgenS.setCurrentIndex(index)
		coudriverpath = octave.sysload(save,"3")
		index = self.comboBoxcou.findText(coudriverpath)
		self.comboBoxcou.setCurrentIndex(index)
		
	def save(self):
		
		save = "#" + genBdriverpath + "#" + genSdriverpath + "#" + coudriverpath
		with open("Procedures/DIN EN 61000-4-4_-4-5 Burst Surge/std_system","w") as text_file:
			text_file.write(save)
		

		#octave.push("genaddres",str(genaddres))
		#octave.push("powaddres",str(powaddres))

class MeasureWindow(QtGui.QDialog, measure):           			# neue Klasse fuer das Dialogfenster
	def __init__(self, Fenster2=None):             			# initialiesiert Dialogfenster
		(MeasureWindow, self).__init__()      			#
		QtGui.QDialog.__init__(self,Fenster2)  			#
		self.setupUi(self)                    			# Siehe Komentar z14
		self.arsch2 = Fenster2
		self.pushButtonStart.clicked.connect(self.procedure)
		self.checkBox_com1.stateChanged.connect(self.complete1)
		self.checkBox_com3.stateChanged.connect(self.complete3)
		self.pushButton_B.clicked.connect(self.burst)
		self.pushButton_S.clicked.connect(self.surge)
		self.pushButton_Supply.clicked.connect(self.supply)
		self.pushButton_IO.clicked.connect(self.io)
		self.comboBox_BV.currentIndexChanged.connect(self.burstvoltage)
		self.comboBox_BF.currentIndexChanged.connect(self.burstfrequency)
		self.comboBox_SV.currentIndexChanged.connect(self.surgevoltage)
		self.checkBox_SL1.pressed.connect(self.SL1)
		self.checkBox_SL1.toggled.connect(self.enable)
		self.checkBox_SL2.pressed.connect(self.SL2)
		self.checkBox_SL2.toggled.connect(self.enable)
		self.checkBox_SL3.pressed.connect(self.SL3)
		self.checkBox_SL3.toggled.connect(self.enable)
		self.checkBox_SN.pressed.connect(self.SN)
		self.checkBox_SN.toggled.connect(self.enable)
		self.checkBox_BL1.pressed.connect(self.BL1)
		self.checkBox_BL1.toggled.connect(self.enable)
		self.checkBox_BL2.pressed.connect(self.BL2)
		self.checkBox_BL2.toggled.connect(self.enable)
		self.checkBox_BL3.pressed.connect(self.BL3)
		self.checkBox_BL3.toggled.connect(self.enable)
		self.checkBox_BN.pressed.connect(self.BN)
		self.checkBox_BN.toggled.connect(self.enable)
		self.checkBox_BPE.pressed.connect(self.BPE)
		self.checkBox_BPE.toggled.connect(self.enable)

	def procedure(self):
		if self.pushButton_IO.isChecked() == True:
			BVStart = 1
		else:
			BVStart = 2
	
		if self.checkBox_com1.isChecked() == True:
			complete = 2
		elif self.checkBox_com3.isChecked() == True:
			complete = 8
		else:
			complete = 0
		
		B = S = 0
		if self.checkBox_BL1.isChecked() == True:
			B = B + 1
		if self.checkBox_BL2.isChecked() == True:
			B = B + 2
		if self.checkBox_BL3.isChecked() == True:
			B = B + 4
		if self.checkBox_BN.isChecked() == True:
			B = B + 8
		if self.checkBox_BPE.isChecked() == True:
			B = B + 16
		if self.checkBox_SL1.isChecked() == True:
			S = S + 1
		if self.checkBox_SL2.isChecked() == True:
			S = S + 2
		if self.checkBox_SL3.isChecked() == True:
			S = S + 4
		if self.checkBox_SN.isChecked() == True:
			S = S + 8
		
		try:
			BVol = float(self.lineEdit_BV.text())
		except ValueError:
			BVol = 0
		BFreq = int(self.comboBox_BF.currentText())
		BDur = float(self.lineEdit_BD.text())
		BPeriod = int(self.lineEdit_BP.text())
		try:
			SVol = float(self.lineEdit_SV.text())
		except ValueError:
			SVol = 0
		SAng = int(self.comboBox_SA.currentText())
		SNum = int(self.lineEdit_SN.text())
		SDur = int(self.lineEdit_SD.text())

		octave.addpath(str(sys.argv[1]) +"/")
		error = octave.procedure(genBaddres, genSaddres, couaddres, BVol, BFreq, BDur, BPeriod, SVol, SAng, SNum, SDur, B, S, complete, BVStart)
		print (error)
	
	def enable(self):

		a = str('')
		if self.groupBox_Burst.isEnabled() == True:
			b = str(self.lineEdit_BV.text())
		else: 
			b = str('0')
		if self.groupBox_Surge.isEnabled() == True:
			c = str(self.lineEdit_SV.text())
		else:
			c = str('0')
		d = str(self.lineEdit_BP.text())
		e = str(self.lineEdit_SN.text())
		f = str(self.lineEdit_SD.text())

		if (self.checkBox_BL1.isChecked() == True or self.checkBox_BL2.isChecked() == True or self.checkBox_BL3.isChecked() == True or self.checkBox_BN.isChecked() == True or self.checkBox_BPE.isChecked() == True):
			g = str('1')
		else:
			g = str('')

		if (self.checkBox_SL1.isChecked() == True or self.checkBox_SL2.isChecked() == True or self.checkBox_SL3.isChecked() == True or self.checkBox_SN.isChecked() == True):
			h = str('1')
		else:
			h = str('')

		if self.pushButton_B.isChecked() == True:
			if g == '1':
				x = str('1')
			else:
				x = str('')
		else:
			if (g == '1' and h == '1'):
				x = str('1')
			else:
				x = str('')

		if self.pushButton_Supply.isChecked() == True:
			if (self.checkBox_com1.isChecked() == True or self.checkBox_com3.isChecked() == True):
				if (a is not b and a is not c and a is not d and a is not e and a is not f):
					self.pushButtonStart.setEnabled(True)
				else:
					self.pushButtonStart.setEnabled(False)
			else:
				if (a is not b and a is not c and a is not d and a is not e and a is not f and a is not x):
					self.pushButtonStart.setEnabled(True)
				else:
					self.pushButtonStart.setEnabled(False)
		else:
			if (self.checkBox_com1.isChecked() == True or self.checkBox_com3.isChecked() == True):
				if (a is not b and a is not d):
					self.pushButtonStart.setEnabled(True)
				else:
					self.pushButtonStart.setEnabled(False)
			else:
				if (a is not b and a is not d and a is not x):
					self.pushButtonStart.setEnabled(True)
				else:
					self.pushButtonStart.setEnabled(False)


	def burstvoltage(self):
		if self.comboBox_BV.currentText() ==  "Class 1":
			self.lineEdit_BV.setEnabled(False)
			if self.pushButton_Supply.isChecked() == False:
				self.lineEdit_BV.setText('0.25')
			else:
				self.lineEdit_BV.setText('0.5')
		elif self.comboBox_BV.currentText() ==  "Class 2":
			self.lineEdit_BV.setEnabled(False)
			if self.pushButton_Supply.isChecked() == False:
				self.lineEdit_BV.setText('0.5')
			else:
				self.lineEdit_BV.setText('1')
		elif self.comboBox_BV.currentText() ==  "Class 3":
			self.lineEdit_BV.setEnabled(False)
			if self.pushButton_Supply.isChecked() == False:
				self.lineEdit_BV.setText('1')
			else:
				self.lineEdit_BV.setText('2')
		elif self.comboBox_BV.currentText() ==  "Class 4":
			self.lineEdit_BV.setEnabled(False)
			if self.pushButton_Supply.isChecked() == False:
				self.lineEdit_BV.setText('2')
			else:
				self.lineEdit_BV.setText('4')
		elif self.comboBox_BV.currentText() ==  "Class X":
			self.lineEdit_BV.setEnabled(True)
			self.lineEdit_BV.setText('')
		else:
			self.lineEdit_BV.setEnabled(False)
			self.lineEdit_BV.setText('')
		self.enable()

	def surgevoltage(self):
		if self.comboBox_SV.currentText() ==  "Class 1":
			self.lineEdit_SV.setEnabled(False)
			self.lineEdit_SV.setText('0.5')
		elif self.comboBox_SV.currentText() ==  "Class 2":
			self.lineEdit_SV.setEnabled(False)
			self.lineEdit_SV.setText('1')
		elif self.comboBox_SV.currentText() ==  "Class 3":
			self.lineEdit_SV.setEnabled(False)
			self.lineEdit_SV.setText('2')
		elif self.comboBox_SV.currentText() ==  "Class 4":
			self.lineEdit_SV.setEnabled(False)
			self.lineEdit_SV.setText('4')
		elif self.comboBox_SV.currentText() ==  "Class X":
			self.lineEdit_SV.setEnabled(True)
			self.lineEdit_SV.setText('')
		else:
			self.lineEdit_SV.setEnabled(False)
			self.lineEdit_SV.setText('')
		self.enable()

	def burstfrequency(self):
		if self.comboBox_BF.currentText() == "5":
			self.lineEdit_BD.setText('15')
		else:
			self.lineEdit_BD.setText('0.75')
		self.enable()

	def complete1(self):

		if self.checkBox_com1.isChecked() == True:
			self.checkBox_com3.setChecked(False)
			self.pushButton_S.setEnabled(False)
			self.pushButton_B.setEnabled(False)
			self.groupBox_checkS.setEnabled(False)
			self.groupBox_checkB.setEnabled(False)
			self.groupBox_Burst.setEnabled(True)
			self.burstvoltage()
			if self.pushButton_IO.isChecked() == False:
				self.groupBox_Surge.setEnabled(True)
				self.surgevoltage()
		else:
			self.pushButton_S.setEnabled(True)
			self.pushButton_B.setEnabled(True)
			self.groupBox_checkB.setEnabled(True)
			if self.pushButton_S.isChecked() == True:
				self.surge()
			else:
				self.burst()
#				self.groupBox_checkS.setEnabled(True)
		self.enable()

	def complete3(self):

		if self.checkBox_com3.isChecked() == True:
			self.checkBox_com1.setChecked(False)
			self.pushButton_S.setEnabled(False)
			self.pushButton_B.setEnabled(False)
			self.groupBox_checkB.setEnabled(False)
			self.groupBox_checkS.setEnabled(False)
			self.groupBox_Burst.setEnabled(True)
			self.burstvoltage()
			if self.pushButton_IO.isChecked() == False:
				self.groupBox_Surge.setEnabled(True)
				self.surgevoltage()
		else:
			self.pushButton_B.setEnabled(True)
			self.pushButton_S.setEnabled(True)
			self.groupBox_checkB.setEnabled(True)
			if self.pushButton_S.isChecked() == True:
				self.surge()
			else:
				self.burst()
#				self.groupBox_checkS.setEnabled(True)
		self.enable()

	def burst(self):

		if self.pushButton_B.isChecked() == False:
			self.pushButton_B.setChecked(True)
		else:
			self.pushButton_S.setChecked(False)
			self.groupBox_checkS.setEnabled(False)
			self.groupBox_Burst.setEnabled(True)
			self.groupBox_Surge.setEnabled(False)
			self.lineEdit_SV.setText('')
			self.burstvoltage()
		self.enable()

	def surge(self):

		if self.pushButton_S.isChecked() == False:
			self.pushButton_S.setChecked(True)
		else:
			self.pushButton_B.setChecked(False)
			self.groupBox_checkS.setEnabled(True)
			self.checkBox_BL1.setChecked(False)
			self.checkBox_BL2.setChecked(False)
			self.checkBox_BL3.setChecked(False)
			self.checkBox_BN.setChecked(False)
			self.checkBox_BPE.setChecked(False)
			self.groupBox_Surge.setEnabled(True)
			self.groupBox_Burst.setEnabled(False)
			self.lineEdit_BV.setText('')
			self.surgevoltage()
		self.enable()

	def supply(self):

		if self.pushButton_Supply.isChecked() == False:
			self.pushButton_Supply.setChecked(True)
		else:
			self.pushButton_IO.setChecked(False)
			if self.checkBox_com1.isChecked() == False and self.checkBox_com3.isChecked() == False:
				self.pushButton_S.setEnabled(True)
				if self.pushButton_B.isChecked() == True:
					self.burst()
				else:
					self.surge()
			else:
				self.groupBox_Surge.setEnabled(True)
		if self.groupBox_Surge.isEnabled() == True:
			self.surgevoltage()
		self.burstvoltage()

	def io(self):

		self.lineEdit_SV.setText('')
		if self.pushButton_IO.isChecked() == False:
			self.pushButton_IO.setChecked(True)
		else:
			self.pushButton_Supply.setChecked(False)
			self.groupBox_Surge.setEnabled(False)
			self.pushButton_S.setEnabled(False)
			self.burstvoltage()
			self.pushButton_B.setChecked(True)
		self.burst()

	def SL1(self):

		self.checkBox_BL1.setChecked(False)
		self.checkBox_SL2.setChecked(False)
		self.checkBox_SL3.setChecked(False)
		self.checkBox_SN.setChecked(False)

	def SL2(self):

		self.checkBox_SL1.setChecked(False)
		self.checkBox_BL2.setChecked(False)
		self.checkBox_SL3.setChecked(False)
		self.checkBox_SN.setChecked(False)

	def SL3(self):

		self.checkBox_SL1.setChecked(False)
		self.checkBox_SL2.setChecked(False)
		self.checkBox_BL3.setChecked(False)
		self.checkBox_SN.setChecked(False)

	def SN(self):

		self.checkBox_SL1.setChecked(False)
		self.checkBox_SL2.setChecked(False)
		self.checkBox_SL3.setChecked(False)
		self.checkBox_BN.setChecked(False)

	def BL1(self):

		if self.pushButton_S.isChecked() == True:
			self.checkBox_SL1.setChecked(False)
			self.checkBox_BL2.setChecked(False)
			self.checkBox_BL3.setChecked(False)
			self.checkBox_BN.setChecked(False)
			self.checkBox_BPE.setChecked(False)

	def BL2(self):

		if self.pushButton_S.isChecked() == True:
			self.checkBox_BL1.setChecked(False)
			self.checkBox_SL2.setChecked(False)
			self.checkBox_BL3.setChecked(False)
			self.checkBox_BN.setChecked(False)
			self.checkBox_BPE.setChecked(False)

	def BL3(self):

		if self.pushButton_S.isChecked() == True:
			self.checkBox_BL1.setChecked(False)
			self.checkBox_BL2.setChecked(False)
			self.checkBox_SL3.setChecked(False)
			self.checkBox_BN.setChecked(False)
			self.checkBox_BPE.setChecked(False)

	def BN(self):

		if self.pushButton_S.isChecked() == True:
			self.checkBox_BL1.setChecked(False)
			self.checkBox_BL2.setChecked(False)
			self.checkBox_BL3.setChecked(False)
			self.checkBox_SN.setChecked(False)
			self.checkBox_BPE.setChecked(False)

	def BPE(self):

		if self.pushButton_S.isChecked() == True:
			self.checkBox_BL1.setChecked(False)
			self.checkBox_BL2.setChecked(False)
			self.checkBox_BL3.setChecked(False)
			self.checkBox_BN.setChecked(False)


if __name__ == "__main__":                            			# Programmstart
	app = QtGui.QApplication(sys.argv)
	main = MainWindow()                         			# Festlegung des Hauptfensters
	main.show()                                   			# oeffnen des Hauptfensters
	sys.exit(app.exec_())
