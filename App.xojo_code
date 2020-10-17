#tag Class
Protected Class App
Inherits Application
	#tag Event
		Sub Open()
		  app.AllowAutoQuit = True
		  
		End Sub
	#tag EndEvent

	#tag Event
		Function UnhandledException(error As RuntimeException) As Boolean
		  Logging.Error(error.Message + " " + error.Reason)
		  
		  If error <> Nil Then
		    Var type As String = Introspection.GetType(error).Name
		    Var s As String = string.FromArray(error.Stack, EndOfLine).Left(200) + "..."
		    MessageBox(type + EndOfLine + EndOfLine + s )
		  End If
		  
		  Return True
		End Function
	#tag EndEvent


	#tag Note, Name = License
		MIT License
		
		Copyright 2020 Stefan Watermann, Germany
		
		Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation 
		files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, 
		merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is 
		furnished to do so, subject to the following conditions:
		
		The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
		
		THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT 
		LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
		IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, 
		WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
		SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
		
	#tag EndNote

	#tag Note, Name = Readme
		Raspberry Frame
		=============
		
		Eine Software für DIY Foto-Rahmen Projekte mit Raspberry Pi und Raspbian OS.
		Fotos werden automatisch skaliert im Vollbildmodus angezeigt. Die Reihenfolge
		der Fotos wird per Zufallsprinzip nach jedem Durchlauf neu erstellt. Eine integrierte 
		Web-Oberfläche an Port 9001 erlaubt die Steuerung des Raspberry (Ausschalten, 
		Neu starten, Nächtes Foto, ...).
		
		
		Installation
		-----------
		
		1) Die Dateien des kompilietren Projektes auf den Raspiberry nach "/home/pi/RaspiFrame" kopieren.
		2) Die Konfigurtationsdatei "RaspiFrame.config" im Ordner "RaspiFrame Resources" anpassen.
		3) Fotos nach "/home/pi/Pictures" kopieren (dazu Samba auf dem Raspberry installieren).
		4) "./RaspiFrame &" starten und wenn alles läuft als Autostart konfigurieren.
		
		
		Autostart
		----------
		Üblicherweise soll die Software automatisch mit dem Betriebssystem gestartet werden.
		Dazu kann die Datei "/etc/xdg/lxsession/LXDE-pi/autostart" um den Aufruf von 
		"/home/pi/RaspiFrame/RaspiFrame" ergänzt werden:
		
		sudo nano /etc/xdg/lxsession/LXDE-pi/autostart
		
		@lxpanel --profile LXDE-pi
		@pcmanfm --desktop --profile LXDE-pi
		@xset s off
		@xset -dpms
		@xset s noblank
		@unclutter -idle 0
		@/home/pi/RaspiFrame/RaspiFrame
		
	#tag EndNote


End Class
#tag EndClass
