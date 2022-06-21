import sys
import pyautogui
import subprocess
import time
import schedule 
import os
from PySide6 import QtGui
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QObject, Slot, Signal, QTimer



#Opens zoom with command prompt
#Pyautogui is used to enter the password 
def open_meeting(id, password, duration):
    cmd_command = rf'%APPDATA%\Zoom\bin\Zoom.exe "-url=zoommtg://zoom.us/join?action=join&confno={id}'
    subprocess.Popen(cmd_command, shell = True)
    #Waiting until Zoom has loaded
    #Tries to find loaded for 30 seconds
    time.sleep(1.5)
    end_time = time.time() + 30
    while time.time() < end_time:
        loaded = pyautogui.locateOnScreen(r'images/loaded.png', grayscale=True)
        print(loaded)
        if loaded is not None:
            pyautogui.write(password)
            pyautogui.hotkey('enter')
            break
    #Closes zoom after certain amount of minutes of duration is specified
    if duration != '':
        time.sleep(float(duration)*60)
        subprocess.Popen(f"TASKKILL /PID Zoom.exe", shell = True)
        time.sleep(.5)
        leave_button = pyautogui.locateOnScreen(r'images/LeaveButton.PNG')
        pyautogui.click(leave_button)

#Schedules every class in periods txt 
def schedule_classes():
    #Opens periods.txt 
    with open('periods.txt', 'r') as f:
        period_list = f.readlines()
        a_days = period_list[1:period_list.index('B-DAY\n')]
        b_days = period_list[period_list.index('B-DAY\n') + 1:]
    #Loops through information from periods.txt to set schedule
    for period in a_days:
        try:
            period_info = period.strip('\n').replace(' ','').split(',')
            meeting_time, meeting_duration, meeting_id, meeting_password = period_info[0], period_info[1], period_info[2], period_info[3] 
            schedule.every().monday.at(meeting_time).do(open_meeting, id = meeting_id, password = meeting_password, duration = meeting_duration)   
            schedule.every().thursday.at(meeting_time).do(open_meeting, id = meeting_id, password = meeting_password, duration = meeting_duration)
        except:
            pass
    for period in b_days:
        try:
            period_info = period.strip('\n').replace(' ','').split(',')
            meeting_time, meeting_duration, meeting_id, meeting_password = period_info[0], period_info[1], period_info[2], period_info[3] 
            schedule.every().tuesday.at(meeting_time).do(open_meeting, id = meeting_id, password = meeting_password, duration = meeting_duration)   
            schedule.every().friday.at(meeting_time).do(open_meeting, id = meeting_id, password = meeting_password, duration = meeting_duration)   
        except:
            pass


#Sleep in background until next class
def run_in_background():
    while True:
        n = schedule.idle_seconds()
        if n is None:
            sys.exit()  
        elif n > 0:
            time.sleep(n)
        schedule.run_pending()



class MainWindow(QObject):
    def __init__(self):
        QObject.__init__(self)

        self.timer = QTimer()
        self.timer.timeout.connect(lambda: self.updateTimer())
        self.timer.start(1000)
    
    #Setting up Signals for QML file
    signalTime = Signal(str)
    signalGetPeriods = Signal(list, list)

    
    def updateTimer(self):
    #Outputting amount of time to next class to signalTime
        n = schedule.idle_seconds()
        try: 
            days = n//(24*3600)
            n = n%(24*3600)
            hours = n//3600
            n = n%3600
            minutes = n//60
            seconds = n%60
            timer = f'Next class in {round(days)} days {round(hours)} hours {round(minutes)} minutes {round(seconds)} seconds'
            self.signalTime.emit(timer)
        except:
            self.signalTime.emit(' ')


    #Pulls information off of the periods.txt file 
    @Slot()
    def getPeriods(self):
        with open('periods.txt', 'r') as f:
            period_list = f.readlines()
        a_days = period_list[1:period_list.index('B-DAY\n')]
        b_days = period_list[period_list.index('B-DAY\n') + 1:]
        self.signalGetPeriods.emit(a_days, b_days)

    
    #Opens and edits periods.txt file based on input from GUI
    @Slot(str, str, str, str, str)
    def updatePeriods(self, line, getTime, getDuration, getID, getPass):
        timer = ''
        #Opens periods.txt and writes changes
        with open('periods.txt', 'r') as f:
            data = f.readlines()
        getPass = getPass.strip('\n')
        data[int(line)] = f'{getTime}, {getDuration}, {getID}, {getPass}\n'
        with open('periods.txt', 'w') as f:
            f.writelines(data)
        #Clears existing schedule calls to prevent stacking
        schedule.clear()
        #Sets schedule for each class
        schedule_classes()



if __name__ == '__main__':
    #Kills previous existences of autozoom so the programs do not stack
    PID = []
    proc = subprocess.Popen('tasklist', shell=True, stdin=subprocess.PIPE, stdout=subprocess.PIPE)
    data, err = proc.communicate()
    for line in data.split(b'\n'):
        string_line = line.decode('utf-8')
        if 'autozoom.exe' in string_line:
            PID.append(string_line.split()[1]) 
    for process in PID[:-1]:
        try: 
            command = f"TASKKILL /F /PID {process}"
            subprocess.Popen(command, shell = True)
        except:
            pass
    #Checks to see if program is run with parameter b
    #If program is run with b then autozoom skips the gui and goes straight to
    #scheduling and running in the background
    argument = None
    try:
        argument = str(sys.argv[1])
    except:
        pass
    if argument == 'b':
        schedule_classes()
        run_in_background()
 
    #Initializing and running GUI
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    main = MainWindow()
    engine.rootContext().setContextProperty("backend", main)
    #Loading splash screen then main
    engine.load(os.path.join(os.path.dirname(__file__), "qml/Splash.qml"))
    time.sleep(2)
    engine.load(os.path.join(os.path.dirname(__file__), "qml/main.qml"))
    if not engine.rootObjects():
        sys.exit(-1)
    app.exec_()
    #Runs program again but with parameter to go in background
    try:
        subprocess.Popen([r'autozoom.exe', 'b'])
    except:
        pass    
    #sys.exit(app.exec_())  

