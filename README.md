# This is garbage code. It worked but also didn't. 

## AutoZoom 
#### Dependencies: sys, os, cx_freeze, time, schedule, pyautogui, PySide6, subprocess
This project was the result of the fact that I was bored during quaranatine and didn't like opening my zoom classes.

Using the command prompt, I found a way to join my zoom classes with some classic python automation.
Turned out I could join a zoom class using its unique id and a command shown below:

%APPDATA%\Zoom\bin\Zoom.exe "-url=zoommtg://zoom.us/join?action=join&confno={id}

Using subprocess and os to fire up the command shell with python and a library called schedule, I was able to open my zoom classes for school at their respective classes with 0 input needed from me and afterward, close zoom once the class period was over.

Quarantine me thought it would be a great idea to make a gui for this handy program. (A terrible idea since it took so long)
I used a huge gui toolkit called QT and used PySide6 to strap together a simple gui that allowed the user to enter in their meeting ids, passwords, and durations of the respective meetings to automatically close later. It worked, but there were for sure better ways of creating this app. (Maybe something I'll explore in the future)

<img src="https://github.com/KeejayK/AutoZoom/blob/main/preview.png?raw=true" height=500>

I played around with cx freeze and inno setup to package the whole app and make an installer for others to use. It sorta worked. The program slept while it wasn't in use in between classes and quarantine me (and present day me) had no idea what he was doing so the app ended up freezing and permanently running in the background sometimes, taking up a massive amount of resources and reducing my friend Jacob's battery life by 80%. (I actually discovered it was my program that did it when he asked me to figure out why his laptop was dying so fast) 

So uh... I'm gonna take it a step back and learn some more before converting my poorly written python programs into installable exe files and sharing them with other people. 

On the bright side, the program when working saved me a lot of time (and sleep) since I never had to manually open zoom (or wake up early) for my classes. 


NOTE: I'm uploading this here more than a year after I made this thing cause I'm just now learning how github works. 

