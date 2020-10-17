# Raspberry Frame
Eine Software für DIY Foto-Rahmen Projekte mit Raspberry Pi und Raspbian OS.
Fotos werden automatisch skaliert im Vollbildmodus angezeigt. Die Reihenfolge
der Fotos wird per Zufallsprinzip nach jedem Durchlauf neu erstellt. Eine integrierte 
Web-Oberfläche an Port 9001 erlaubt die Steuerung des Raspberry (Ausschalten, 
Neu starten, Nächtes Foto, ...).

## Installation
1) Die Dateien des kompilietren Projektes (RaspiFrame_1.0.zip) auf den Raspiberry nach "/home/pi/RaspiFrame" kopieren.
2) Die Konfigurtationsdatei "RaspiFrame.config" im Ordner "RaspiFrame Resources" anpassen.
3) Fotos nach "/home/pi/Pictures" kopieren (dazu Samba auf dem Raspberry installieren).
4) "./RaspiFrame &" starten und wenn alles läuft als Autostart konfigurieren.


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
