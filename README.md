# Raspberry Frame
Raspberry Frame ist eine Software für DIY Foto-Rahmen Projekte mit Raspberry Pi und Raspbian OS.
Fotos werden automatisch skaliert im Vollbildmodus angezeigt. Die Reihenfolge
der Fotos wird per Zufallsprinzip nach jedem Durchlauf automatisch neu erstellt. Eine integrierte 
Web-Oberfläche an Port 9001 erlaubt die grundlegende Steuerung des Raspberry (Ausschalten, 
Neu starten, ...) sowie der Foto Frame Software (Fotos neu einlesen, zu nächstem Foto wechseln, ...).

Zum kompilieren des Projektes wird die Entwicklungsumgebung XOJO (www.xojo.com) benötigt.
Die ausführbaren Dateien für Raspbian Linux befinden sich im Zip Archiv RaspiFrame_1.0.zip.

## Installation
1) Die Dateien des kompilietren Projektes (RaspiFrame_1.0.zip auspacken) auf den Raspberry nach "/home/pi/RaspiFrame" kopieren.
2) Die Konfigurtationsdatei "RaspiFrame.config" im Ordner "RaspiFrame Resources" anpassen.
3) Fotos nach "/home/pi/Pictures" kopieren (dazu Samba auf dem Raspberry installieren).
4) "./RaspiFrame" starten und wenn alles läuft als Autostart konfigurieren.


## Autostart
Üblicherweise soll die Software automatisch mit dem Betriebssystem gestartet werden.
Dazu kann die Datei "/etc/xdg/lxsession/LXDE-pi/autostart" um den Aufruf von 
"/home/pi/RaspiFrame/RaspiFrame" ergänzt werden:

```
sudo nano /etc/xdg/lxsession/LXDE-pi/autostart
```

```
@lxpanel --profile LXDE-pi
@pcmanfm --desktop --profile LXDE-pi
@xset s off
@xset -dpms
@xset s noblank
@unclutter -idle 0
@/home/pi/RaspiFrame/RaspiFrame
```

Admin Oberfläche
----------------

Die Web-Oberfläche ist über http://[hostname]:9001 zu erreichen:

![Web-Oberfläche](https://github.com/stefanwatermann/frame/blob/main/Screenshots/FrameControl.png)


DIY Foto-Rahmen Beispiele
-------------------------
13 Zoll Dispaly eines alten Laptops in einem Rahmen aus Erlenholz.

![Foto-Rahmen](https://github.com/stefanwatermann/frame/blob/main/Screenshots/RaspiFrame.JPG)

7 Zoll Raspberry Touchscreen in einem Holzrahmen von www.eleduino.com.

![Foto-Rahmen](https://github.com/stefanwatermann/frame/blob/main/Screenshots/RaspiFrame2.JPG)
