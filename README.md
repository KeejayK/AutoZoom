# This is garbage code.

## AutoZoom 
#### Dependencies: sys, os, cx_freeze, time, schedule, pyautogui, PySide6, subprocess
I was so bored during quarantine.

Using the command prompt, I found a way to join my zoom classes with some classic python automation.

Turned out I could join a zoom class using its unique id and a command shown below:

%APPDATA%\Zoom\bin\Zoom.exe "-url=zoommtg://zoom.us/join?action=join&confno={id}

Using subprocess and os to fire up the command shell with python and a library called schedule, I was able to open my zoom classes for school at their respective classes with 0 input needed from me and afterward, close zoom once the class period was over.

To take it a step further, quarantine me thought it would be a great idea to make a gui for this handy program. (A terrible idea since it took so long)
I used a huge gui toolkit called QT and used PySide6 to strap together a simple (and horribly designed) gui that allowed the user to enter in their meeting ids, passwords, and durations of the respective meetings to automatically close later.

To take it a step even further than that, I played around with cx freeze and inno setup to package the whole app and make an installer for others to use. It sorta worked. The program slept in the background in between classes and quarantine me (and present day me) had no idea what he was doing so the app ended up freezing and permanently running in the background, reducing my friend Jacob's battery life by like 80%. (I actually discovered it was my program that did it when he asked me to figure out why his laptop was dying so fast) 

So uh... I'm gonna take it a step back and learn some more before converting my poorly written python programs into installable exe files and sharing them with other people. 


NOTE: I'm uploading this here more than a year after I made this thing cause I'm just now learning how github works. 
