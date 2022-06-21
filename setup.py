import sys
import os
from cx_Freeze import setup, Executable

files = ['images/favicon.ico']

target = Executable(
    script = 'autozoom.py',
    base='Win32GUI',
    icon = 'images/favicon.ico'
)

setup (
    name = 'AutoZoom',
    version = '1.0',
    description = 'AutoZoom',
    author = 'Keejay Kim',
    options = {'build.exe' : {'include_files' : files}},
    executables = [target]
)
